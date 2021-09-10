import 'dart:io';
import 'dart:isolate';

import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/utils/url.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class AvatarHandler {

  /// Returns a file path string associated to this channel name which
  /// represents the avatar image as [File] type, if the avatar image does
  /// not exist it will be downloaded and written to its file and if it 
  /// does exist this function will just return that file path string.
  /// 
  /// If you want to update the cached image, save and return a new image,
  /// set [updateAvatar] to true.
  static Future<String> getAvatarUrl(String channelName, String channelUrl, {bool updateAvatar = false}) async {

    // Create our dirs and define our avatar file path
    Directory avatarDir = Directory((await getApplicationDocumentsDirectory()).path + "/avatarDir/");
    if (!(await avatarDir.exists())) avatarDir.create(recursive: true);
    File avatarImage = File(avatarDir.path + "/$channelName");

    // Return avatar image file path if it exist
    if (await avatarImage.exists() && !updateAvatar) return avatarImage.path;

    // Extract the avatar image from the channel url provided using our Isolate
    String id = (await YoutubeId.getIdFromChannelUrl(channelUrl)).split("/").last;
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(_getChannelLogoUrlIsolate, receivePort.sendPort);
    SendPort childSendPort = await receivePort.first;
    ReceivePort responsePort = ReceivePort();
    childSendPort.send([id, responsePort.sendPort]);
    String imageUrl = await responsePort.first;

    // Create our avatar image file
    http.Client client = http.Client();
    try {
      var response = await client.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) return null;
      await avatarImage.writeAsBytes(response.bodyBytes);
      client.close();
    } catch (_) { client.close(); return null; }

    // Return newly created avatar Image, any other request to the same
    // Channel avatar image will just return this cached image
    return avatarImage.path;
  }

  // Since parsing the channel avatar image url is CPU expensive, we will
  // use this isolate to take out the work off the main thread
  static void _getChannelLogoUrlIsolate(SendPort mainSendPort) async {
    ReceivePort childReceivePort = ReceivePort();
    mainSendPort.send(childReceivePort.sendPort);
    await for (var message in childReceivePort) {
      String videoId = message[0];
      SendPort replyPort = message[1];
      String avatarUrl;
      try {
        avatarUrl = await ChannelExtractor.getAvatarUrl(videoId);
      } catch (_) {
        replyPort.send("");
        break;
      }
      replyPort.send(avatarUrl);
      break;
    }
  }

}