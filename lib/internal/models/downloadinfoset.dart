// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/internal/services/databaseService.dart';
import 'package:songtube/internal/models/songFile.dart';
import 'package:songtube/internal/models/metadata.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/internal/randomString.dart';
import 'package:songtube/internal/tagsManager.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:string_validator/string_validator.dart';

enum DownloadType { AUDIO, VIDEO }

class DownloadInfoSet {

  // Streams
  BehaviorSubject<String> currentAction;
  BehaviorSubject<String> dataProgress;
  BehaviorSubject<double> progressBar;

  // Classes
  MediaMetaData metadata;
  StreamInfo audioStreamInfo;
  StreamInfo videoStreamInfo;
  Video videoDetails;
  Converter converter;

  // Variables
  String downloadPath;
  DownloadType downloadType;
  AudioConvert convertFormat;
  List audioModifiers;
  bool downloaderClosed;
  bool _cancelDownload;
  bool get cancelDownload => _cancelDownload;
  set cancelDownload(bool value) {
    _cancelDownload = value;
    if (value == true) { 
      dataProgress.add("Incompleted");
      progressBar.add(0.0);
    }
  }

  DownloadInfoSet({
    @required this.metadata,
    @required this.downloadType,
    @required this.convertFormat,
    @required this.downloadPath,
    @required this.audioModifiers,
    @required this.audioStreamInfo,
    @required this.videoDetails,
    this.videoStreamInfo,
  }) {
    converter = new Converter();
    currentAction = new BehaviorSubject<String>();
    dataProgress = new BehaviorSubject<String>();
    progressBar = new BehaviorSubject<double>();
    cancelDownload = false;
  }
  
  // ---------------------------------------------
  // Initialize this Media Download, automatically
  // Download, Convert, Write Metadata and Save
  // ---------------------------------------------
  Future<void> downloadMedia() async {
    // Check Storage Permissions
    var status = await Permission.storage.request();
    if (status != PermissionStatus.granted) {
      currentAction.add("Access Denied");
      dataProgress.add("Can't Download");
      cancelDownload = true;
      return;
    }
    // Reset to Default values
    cancelDownload = false;
    currentAction.add("Downloading...");
    currentAction.add(" ");
    // Check our Download Folder
    if (!await Directory(downloadPath).exists()) {
      await Directory(downloadPath).create(recursive: true);
    }
    // Download File
    File downloadedFile = await downloadStream();
    if (downloadedFile == null) cancelDownload = true;
    // Rename File
    downloadedFile = await renameFile(downloadedFile, metadata.title);
    // Write All Metadata if its Audio
    if (downloadType == DownloadType.AUDIO) {
      currentAction.add("Writting Tags & Artwork...");
      await writeAllMetadata(downloadedFile.path);
    }
    // Move file to its Predefined Directory
    Permission.storage.request().then((value) async {
      if (value == PermissionStatus.granted) {
        if (!await Directory(downloadPath).exists()) {
          await Directory(downloadPath).create(recursive: true);
        }
        String fileName = downloadedFile.path.split("/").last;
        File finalFile = await downloadedFile.copy("$downloadPath/$fileName");
        await finishDownload(finalFile);
      }
    });
  }

  // Start Downloading our Stream, this function
  // automatically converts the downloaded File
  Future<File> downloadStream() async { 
    // Download
    File file = File(
      (await getTemporaryDirectory()).path +
      "/" + RandomString.getRandomString(10)
    );
    // YoutubeExplode Instance
    YoutubeExplode yt = new YoutubeExplode();
    // StreamData
    Stream<List<int>> streamData;
    if (videoStreamInfo == null) {
      streamData = yt.videos.streamsClient.get(audioStreamInfo);
      currentAction.add("Downloading Audio...");
    } else {
      streamData = yt.videos.streamsClient.get(videoStreamInfo);
      currentAction.add("Downloading Video...");
    }
    // Update Streams
    dataProgress.add("Starting...");
    progressBar.add(0.0);
    // Open the file in write.
    var _output = file.openWrite(mode: FileMode.write);
    // Local variables for File Download Status
    var _count = 0;
    var _len;
    if (videoStreamInfo == null) {
      _len = audioStreamInfo.size.totalBytes;
    } else {
      _len = videoStreamInfo.size.totalBytes + audioStreamInfo.size.totalBytes;
    }
    // Start stream download while updating internal
    // BehaviorSubject for external access
    await for (var data in streamData) {
      if (cancelDownload == true) {
        _output.close();
        currentAction.add("Download cancelled...");
        return null;
      }
      _count += data.length;
      dataProgress.add("${(_count * 0.000001).toStringAsFixed(2)} MB / ${(_len * 0.000001).toStringAsFixed(2)} MB");
      progressBar.add((_count / _len).toDouble());
      print("Downloading: " + _count.toString());
      _output.add(data);
    }
    await _output.flush();
    await _output.close();
    // Download and Paste Audio if the Previous Download was a Video
    if (downloadType == DownloadType.VIDEO) {
      currentAction.add("Downloading Audio...");
      _count = 0;
      // Audio Download
      File audioFile = File(
        (await getTemporaryDirectory()).path +
        "/" + RandomString.getRandomString(10)
      );
      // Open Write on our Audio File
      var _outputAudio = audioFile.openWrite(mode: FileMode.write);
      // StreamData
      Stream<List<int>> audioStreamData = yt.videos.streamsClient.get(audioStreamInfo);
      // Start stream download while once again updating
      // internal BehaviorSubject for external access
      await for (var data in audioStreamData) {
        if (cancelDownload == true) {
          _outputAudio.close();
          currentAction.add("Download cancelled...");
          return null;
        }
        _count += data.length;
        dataProgress.add(
          "${((_count + videoStreamInfo.size.totalBytes) * 0.000001).toStringAsFixed(2)} MB" +
          " / ${(_len * 0.000001).toStringAsFixed(2)} MB"
        );
        progressBar.add(((_count + videoStreamInfo.size.totalBytes)/_len).toDouble());
        print("Downloading: " + _count.toString());
        _outputAudio.add(data);
      }
      await _outputAudio.flush();
      await _outputAudio.close();
      progressBar.add(null);
      // Write our Audio File downloaded to the
      // previously downloaded Video File
      currentAction.add("Patching Audio...");
      File finalFile = await converter.writeAudioToVideo(
        saveFormat: await converter.getMediaFormat(file.path),
        videoPath: file.path,
        audioPath: audioFile.path,
      );
      // If convertion failed notify the User
      if (finalFile == null) {
        currentAction.add("An issue ocurred with the Converter");
        return null;
      }
      file = finalFile;
    }
    // Convert Audio if enabled to Requested Format
    if (downloadType == DownloadType.AUDIO) {
      if (convertFormat != AudioConvert.NONE) {
        progressBar.add(null);
        currentAction.add("Converting...");
        File finalFile = await converter.convertAudio(
          audioPath: file.path,
          format: convertFormat,
          filters: audioModifiers
        );
        if (finalFile == null) {
          currentAction.add("An issue ocurred with the Converter");
          return null;
        }
        file = finalFile;
      }
    }
    return file;
  }

  // Rename File to a new provided FileName this function
  // preserves the file path and file extension.
  Future<File> renameFile(File file, String newName) async {
    String filePath = file.path
      .replaceAll("/${file.path.split('/').last}", '');
    String fileFormat = file.path.split('.').last;
    return await file.rename("$filePath/$newName.$fileFormat");
  }

  // Write Tags & Artwork
  Future<void> writeAllMetadata(String filePath) async {
    try {
      await TagsManager.writeAllTags(
        songPath: filePath,
        title: metadata.title,
        album: metadata.album,
        artist: metadata.artist,
        genre: metadata.genre,
        year: metadata.date,
        disc: metadata.disk,
        track: metadata.track
      );
      File croppedImage;
      if (isURL(metadata.coverurl)) {
        http.Response response;
        File artwork = new File(
          (await getTemporaryDirectory()).path +
          "/${RandomString.getRandomString(5)}"
        );
        if (metadata.coverurl == videoDetails.thumbnails.mediumResUrl) {
          // Try getting FullQuality Artwork
          try {
            response = await http.get(videoDetails.thumbnails.maxResUrl)
              .timeout(Duration(seconds: 10));
            await artwork.writeAsBytes(response.bodyBytes);
          } catch (_) {}
          // If it doesnt exist try Getting MediumQuality Artwork
          if (response == null || response.bodyBytes == null) {
            try {
              response = await http.get(videoDetails.thumbnails.mediumResUrl)
                .timeout(Duration(seconds: 10));
              await artwork.writeAsBytes(response.bodyBytes);
            } catch (_) {}
          }
        } else {
          try {
            response = await http.get(metadata.coverurl)
              .timeout(Duration(seconds: 10));
            await artwork.writeAsBytes(response.bodyBytes);
          } catch (_) {}
        }
        croppedImage = await NativeMethod.cropToSquare(artwork);
      } else {
        croppedImage = await NativeMethod.cropToSquare(File(metadata.coverurl));
      }
      await TagsManager.writeArtwork(
        songPath: filePath,
        artworkPath: croppedImage.path
      );
      // Copy our CoverArt to default folder
      await croppedImage.copy((await getApplicationDocumentsDirectory()).path +
        "${metadata.title}.jpg");
    } on Exception catch (_) {}
  }

  // Finish download by inserting it to the Database
  // and updating Android MediaStore
  Future<void> finishDownload(File finalFile) async {
    final dbHelper = DatabaseService.instance;
    await dbHelper.insertDownload(new SongFile.toDatabase(
      title: metadata.title,
      album: metadata.album,
      author: metadata.artist,
      duration: videoDetails.duration.toString(),
      downloadType: downloadType == DownloadType.AUDIO
        ? "Audio"
        : "Video",
      fileSize: ((await finalFile.length()) * 0.000001).toStringAsFixed(2),
      coverUrl: metadata.coverurl,
      path: finalFile.path
    ));
    currentAction.add("Completed");
    progressBar.add(1.0);
    downloaderClosed = true;
    NativeMethod.registerFile(finalFile.path);
    currentAction.close();
    progressBar.close();
    dataProgress.close();
  }
}