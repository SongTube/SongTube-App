import 'dart:convert';
import 'dart:isolate';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// This Class holds static functions to retrieve data from Youtube using
/// the youtube_explode_dart library, but, because those library functions are
/// CPU expensive, these are implemented with Isolates to avoid lagging
/// or blocking the App main Isolate
/// 
/// These will only work using a Fork of the original youtube_explode_dart
/// library which has the methods to convert its objects into maps for json
/// encode/decode. The fork can be found on [https://github.com/songtube]
class YoutubeIsolates {

  /// All Data returned by this isolate has to be on a String or Json Format
  static void _mainIsolate(SendPort mainSendPort) async {
    ReceivePort childReceivePort = ReceivePort();
    mainSendPort.send(childReceivePort.sendPort);
    await for (var message in childReceivePort) {
      YoutubeExplode yt = YoutubeExplode();
      String request = message[0]["request"];
      SendPort replyPort = message[1];
      // Get Channel Information
      if (request == "getChannel") {
        String videoId = message[0]["videoId"];
        Channel channel;
        try {
          channel = await yt.channels.getByVideo(videoId);
        } catch (_) {
          replyPort.send("Failed");
          yt.close();
          break;
        }
        replyPort.send(jsonEncode(channel.toMap()));
        yt.close();
        break;
      }
      // Get StreamManifest
      if (request == "getManifest") {
        String videoId = message[0]["videoId"];
        StreamManifest manifest;
        try {
          manifest = await yt.videos.streamsClient.getManifest(videoId);
        } catch (_) {
          replyPort.send("Failed");
          yt.close();
          break;
        }
        replyPort.send(jsonEncode(manifest.toMap()));
        yt.close();
        break;
      }
    }
  }

  static Future<Channel> getChannelByVideoId(String id) async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(_mainIsolate, receivePort.sendPort);
    SendPort childSendPort = await receivePort.first;
    ReceivePort responsePort = ReceivePort();
    childSendPort.send([
      {
        "request": "getChannel",
        "videoId": id,
      },
      responsePort.sendPort
    ]);
    String encodedChannel = await responsePort.first;
    Map<String, dynamic> map = jsonDecode(encodedChannel);
    Channel channel = Channel.fromMap(map);
    return channel;
  }

  static Future<StreamManifest> getStreamManifest(String id) async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(_mainIsolate, receivePort.sendPort);
    SendPort childSendPort = await receivePort.first;
    ReceivePort responsePort = ReceivePort();
    childSendPort.send([
      {
        "request": "getManifest",
        "videoId": id,
      },
      responsePort.sendPort
    ]);
    String jsonManifest = await responsePort.first;
    Map<String, dynamic> map = jsonDecode(jsonManifest);
    return StreamManifest.fromMap(map);
  }

}