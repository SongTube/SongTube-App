// Flutter
import 'dart:io';

import 'package:flutter/services.dart';

class NativeMethod {

  static const media = const MethodChannel("registerMedia");
  static const platform = const MethodChannel("sharedTextChannel");
  static const intentPlatform = const MethodChannel("intentChannel");

  static Future<String> handleIntent() async {
    String _intent = await platform.invokeMethod('getSharedText');
    await platform.invokeMethod('clearSharedText');
    if (_intent == null) return null;
    print("IntentHandler: Result: " + _intent);
    return _intent;
  }

  static void registerFile(String file) async {
    await media.invokeMethod('registerFile', {"file":file});
  }

  static void openVideo(String videoPath) async {
    if (await File(videoPath).exists()) {
      intentPlatform.invokeMethod('openVideo', {"videoPath": videoPath});
    }
  }

}