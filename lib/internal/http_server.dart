import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/enums/download_type.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/audio_tags.dart';
import 'package:songtube/internal/models/download/download_info.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/download_provider.dart';

// Server port
const _port = 1458;

// Global HTTP Bind
HttpServer? linkServer;

class LinkServer {

  static void listenToServer() {
    if (linkServer != null) {
      linkServer!.listen((request) async {
        // Setup headers
        request.response.headers.add("Access-Control-Allow-Origin", "*");
        request.response.headers.add("Access-Control-Allow-Methods", "POST,GET,DELETE,PUT,OPTIONS");
        request.response.statusCode = HttpStatus.ok;
        // Reply with an unique message
        if (request.uri.path == '/ping') {
          request.response.write('pong');
          request.response.close();
        } else if (request.uri.path == '/connect') {
          final info = await DeviceInfoPlugin().androidInfo;
          final jsonBody = jsonEncode({"name": info.model});
          request.response.headers.add("Content-Type", "application/json");
          request.response.write(jsonBody);
          request.response.close();
        } else if (request.uri.path == '/sendLink') {
          final data = await utf8.decoder.bind(request).join();
          request.response.write("success");
          request.response.close();
          handleLink(data);
        } else {
          request.response.write("undefined");
          request.response.close();
        }
      });
    }
  }

  static void handleLink(String data) async {
    final map = jsonDecode(data);
    final String type = map['type'];
    String url = map['url'];
    url = url.contains('&list=') ? url.split('&list').first : url;
    if (type == 'view') {
      Provider.of<ContentProvider>(navigatorKey.currentState!.context, listen: false).loadVideoPlayer(url);
    } else if (type == 'download') {
      // Fetch video details
      final YoutubeVideo videoDetails = await VideoExtractor.getStream(url);
      // Get default format
      final format = sharedPreferences.getString('instant_download_format') ?? 'AAC';
      // Build download
      final downloadInfo = DownloadInfo(
        url: videoDetails.videoInfo.url!,
        name: videoDetails.videoInfo.name ?? 'Unknown',
        duration: videoDetails.videoInfo.length!,
        downloadType: DownloadType.audio,
        audioStream: format == 'AAC'
          ? videoDetails.audioWithBestAacQuality!
          : videoDetails.audioWithBestOggQuality!,
        tags: AudioTags.withStreamInfoItem(videoDetails.toStreamInfoItem()),
      );
      final downloadProvider = Provider.of<DownloadProvider>(navigatorKey.currentState!.context, listen: false);
      downloadProvider.handleDownloadItem(info: downloadInfo);
    }
  }

  static Future<void> initialize() async {
    linkServer = await HttpServer.bind(InternetAddress.tryParse('0.0.0.0'), _port);
    if (linkServer == null) {
      return;
    }
    listenToServer();
    if (kDebugMode) {
      print("Server running on IP : ${linkServer!.address} On Port : ${linkServer!.port}");
    }
  }

  static Future<void> close() async {
    if (linkServer != null) {
      await linkServer!.close();
      linkServer = null;
    }
  }

}