// Dart
import 'dart:io';

// Flutter
import 'package:flutter/services.dart';

class NativeMethod {

  static const media = const MethodChannel("registerMedia");
  static const platform = const MethodChannel("sharedTextChannel");
  static const intentPlatform = const MethodChannel("intentChannel");
  static const imageProcessing = const MethodChannel("imageProcessing");

  // Handle Intent (Ej: when you share a YouTube link to this app)
  static Future<String> handleIntent() async {
    String _intent = await platform.invokeMethod('getSharedText');
    await platform.invokeMethod('clearSharedText');
    if (_intent == null) return null;
    print("IntentHandler: Result: " + _intent);
    return _intent;
  }

  // Exit FullScreen
  static Future<void> exitFullScreen() async {
    await platform.invokeMethod('exitFullScreen');
  }

  // Update android MediaStore with a new File
  // This allows music/video players to detect the new media
  static void registerFile(String file) async {
    await media.invokeMethod('registerFile', {"file":file});
  }

  // Open a local video with the default video player
  static void openVideo(String videoPath) async {
    if (await File(videoPath).exists()) {
      intentPlatform.invokeMethod('openVideo', {"videoPath": videoPath});
    }
  }
  
  // (TEMP FIX) Request All Files Access to The App
  // to fix Downloads on Android 11
  static void requestAllFilesPermission() {
    intentPlatform.invokeListMethod('requestAllFilesPermission');
  }
}