import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/id_helper.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:http/http.dart' as http;
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/ui/sheets/info_item_options.dart';

class UiUtils {
  
  static Future<dynamic> pushRouteAsync(BuildContext context, Widget widget, {BuildContext? providerContext}) async {
    // Media Provider, which contains the controller for the FancyScaffold
    final uiProvider = Provider.of<UiProvider>(providerContext ?? context, listen: false);
    // Previous values for the FancyScaffold position variables
    final navbarAnimationValue = uiProvider.fwController.navbarAnimationController.value;
    final navbarScrollStatus = uiProvider.fwController.navbarScrolledDown;
    uiProvider.fwController.lockNotificationListener = true;
    uiProvider.onAltRoute = true;
    // Set FancyScaffold position variables so that the MediaPlayer
    // removes the bottom padding with animation
    uiProvider.fwController.navbarAnimationController.animateTo(0);
    uiProvider.fwController.navbarScrolledDown = true;
    // Execute our page push asynchronous for performance
    final page = await Future.microtask(() => widget);
    final route = MaterialPageRoute(builder: (context) => page);
    // ignore: use_build_context_synchronously
    final result = await Navigator.of(context).push(route);
    // Once the pushed route has been removed, restore FancyScaffold position variables
    // so that we restore the MediaPlayer bottom padding with animation
    uiProvider.fwController.navbarScrolledDown = navbarScrollStatus;
    uiProvider.fwController.navbarAnimationController.animateTo(navbarAnimationValue);
    uiProvider.fwController.lockNotificationListener = false;
    uiProvider.onAltRoute = false;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Theme.of(context).brightness,
      statusBarIconBrightness: Theme.of(context).brightness,
    ));
    return result;
  }

  static Color desaturateColor(Color color, {double desaturateValue = 0.8}) {
    HSVColor hsvColor = HSVColor.fromColor(color);
    HSVColor desaturated = HSVColor.fromAHSV(hsvColor.alpha, hsvColor.hue, desaturateValue, hsvColor.value);
    return desaturated.toColor();
  }

  /// Returns a file path string associated to this channel name which
  /// represents the avatar image as [File] type, if the avatar image does
  /// not exist it will be downloaded and written to its file and if it 
  /// does exist this function will just return that file path string.
  /// 
  /// If you want to update the cached image, save and return a new image,
  /// set [updateAvatar] to true.
  static Future<String?> getAvatarUrl(String channelName, String channelUrl, {bool updateAvatar = false}) async {

    // Create our dirs and define our avatar file path
    Directory avatarDir = Directory("${(await getApplicationDocumentsDirectory()).path}/avatarDir/");
    if (!(await avatarDir.exists())) avatarDir.create(recursive: true);
    File avatarImage = File("${avatarDir.path}/$channelName");

    // Return avatar image file path if it exist
    if (await avatarImage.exists() && !updateAvatar) return avatarImage.path;

    // Extract the avatar image from the channel url provided using our Isolate
    String? id = (await IdHelper.getIdFromChannelUrl(channelUrl))?.split("/").last;
    if (id == null) return null;
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(_getChannelLogoUrlIsolate, receivePort.sendPort);
    SendPort childSendPort = await receivePort.first;
    ReceivePort responsePort = ReceivePort();
    childSendPort.send([id, responsePort.sendPort]);
    String? imageUrl = await responsePort.first;
    if (imageUrl == null) return null;
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
      String? avatarUrl;
      try {
        avatarUrl = await ChannelExtractor.getAvatarUrl(videoId);
      } catch (_) {
        replyPort.send(null);
        break;
      }
      replyPort.send(avatarUrl);
      break;
    }
  }

  // Show options for any info item
  static void showInfoItemOptions(dynamic infoItem, {Function()? onDelete}) {
    showModalBottomSheet(
      context: internalNavigatorKey.currentContext!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InfoItemOptions(infoItem: infoItem, onDelete: onDelete));
  }

  // Format to HH:MM:SS
  static String timeFormatter(int time) {
    var duration = Duration(seconds: time);
    var hour = duration.inHours;
    var minute = duration.inMinutes.remainder(60);
    var second = duration.inSeconds.remainder(60);

    return "${hour == 0 ? "" : "$hour:"}"
        "${(hour != 0 && minute <= 9) ? "0$minute" : minute}"
        ":${second <= 9 ? "0$second" : "$second"}";
  }
}