import 'dart:convert';
import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:apk_installer/apk_installer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rxdart/rxdart.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/update/update_detail.dart';
import 'package:songtube/main.dart';
import 'package:songtube/ui/components/app_update_dialog.dart';

class AppUpdateManger {
  static final BehaviorSubject<double?> downloadProgress =
      BehaviorSubject.seeded(.0);

  static double appVersion = 0;
  static late PackageInfo packageInfo;

  /// Checks for app update
  static void inAppUpdater() async {
    packageInfo = await PackageInfo.fromPlatform();
    appVersion = double.parse(packageInfo.version.replaceRange(3, 5, ""));
    final latestRelease = await _getLatestRelease();
    if (latestRelease != null && appVersion < latestRelease.versionDouble) {
      showDialog(
          barrierDismissible: false,
          context: internalNavigatorKey.currentContext!,
          builder: (context) {
            return AppUpdateDialog(
              details: latestRelease,
            );
          });
    }
  }

  /// Downloads update if it's available
  static void download(UpdateDetails details) async {
    Uri? downloadUrl = _abiToDownload(details);
    //print("Downloading: $downloadUrl");
    var client = http.Client();
    int downloadedLength = 0;
    final saveName = await _fileName(downloadUrl.toString());
    final ioSink = saveName.openWrite(mode: FileMode.writeOnly);

    final download = await client.send(http.Request("GET", downloadUrl));
    final contentLength = download.contentLength;

    download.stream.listen((value) {
      downloadedLength += value.length;
      downloadProgress.add(downloadedLength / contentLength!);
      ioSink.add(value);
    }, onDone: () async {
      await ioSink.flush();
      await ioSink.close();
      await downloadProgress.close();
      client.close();
      _installApk(saveName.absolute.path);
    }, onError: (e) async {
      await ioSink.close();
      client.close();
      print("Error from download: $e");
    });
  }

  /// Check GitHub for new update.
  static Future<UpdateDetails?> _getLatestRelease() async {
    var client = http.Client();
    var headers = {
      "Accept": "application/vnd.github.v3+json",
    };
    const songTubeNew =
        "https://api.github.com/repos/SongTube/SongTube-New/releases";
    var repoUrl = Uri.parse(songTubeNew);
    try {
      var response = await client.get(repoUrl, headers: headers);
      if (response.body.isNotEmpty && response.body.trim() != "[]") {
        var jsonResponse = jsonDecode(response.body);
        UpdateDetails details = UpdateDetails.fromMap(jsonResponse[0]);
        client.close();
        return details;
      }
    } catch (e, s) {
      client.close();
      print("Error with getting update: $e\n$s");
      return null;
    }
    return null;
  }

  /// Decides which apk to download based on device abi
  static Uri _abiToDownload(UpdateDetails details) {
    late Uri abi;
    for (var element in deviceInfo.supportedAbis) {
      if (element!.contains(SupportedAbi.armeabi.name)) {
        abi = details.armeabi;
      } else if (element.contains(SupportedAbi.arm64.name)) {
        abi = details.arm64;
      } else if (element.contains(SupportedAbi.x86.name)) {
        abi = details.x86;
      } else {
        abi = details.general;
      }
    }
    return abi;
  }

  /// Installs the downloaded apk
  static void _installApk(String apkPath) async {
    await ApkInstaller.installApk(apkPath);
  }

  /// Determine apk save name
  static Future<File> _fileName(String file) async {
    final savePath = await _createDir();
    final fileName = File("$savePath/${file.split("/").last}");
    return fileName;
  }

  /// Create a folder (SongTube) at download
  static Future<String> _createDir() async {
    final path =
        Directory("${await AndroidPathProvider.downloadsPath}/SongTube");
    if (!(await path.exists())) {
      await path.create();
    }
    return path.path;
  }
}
