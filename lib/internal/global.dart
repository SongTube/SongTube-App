import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pip/platform_channel/channel.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:songtube/internal/artwork_manager.dart';
import 'package:songtube/internal/models/update/update_manger.dart';
import 'package:songtube/providers/app_settings.dart';

import '../services/audio_service.dart';

// Initialize All Global Variables
Future<void> initGlobals() async {
  sharedPreferences = await SharedPreferences.getInstance();
  songArtworkPath =
      Directory('${(await getApplicationDocumentsDirectory()).path}/artworks');
  if (!(await songArtworkPath.exists())) {
    await songArtworkPath.create();
  }
  songThumbnailPath = (await getApplicationDocumentsDirectory());
  deviceInfo = await DeviceInfoPlugin().androidInfo;
  androidSdk = deviceInfo.version.sdkInt!;
  audioHandler = await AudioService.init(
      builder: () => StAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.artxdev.songtube',
        androidNotificationChannelName: 'SongTube',
      ));
  isPictureInPictureSupported =
      await FlutterPip.isPictureInPictureSupported() ?? false;
  packageInfo = await PackageInfo.fromPlatform();
  bool autoUpdateEnabled = sharedPreferences.getBool(enableInAppUpdatesKey) ?? true;
  if (autoUpdateEnabled) {
    AppUpdateManger.inAppUpdater();
  }
}

// App Custom Accent Color
Color accentColor = const Color.fromARGB(255, 229, 12, 73);

// Platform Details
late AndroidDeviceInfo deviceInfo;

// Device SDK
late int androidSdk;

// Shared Preferences for user settings and app caching and stuff
late SharedPreferences sharedPreferences;

// App initial Route getter and setter (First time default route is Intro Screen)
String get initialRoute =>
    sharedPreferences.getString('initialRoute') ?? 'intro';
set initialRoute(String route) {
  sharedPreferences.setString('initialRoute', route);
}

// Audio Handler Singleton
late AudioHandler audioHandler;

// Support for PictureInPicture
late bool isPictureInPictureSupported;

// App Info
late PackageInfo packageInfo;

// First run
bool get appFirstRun => sharedPreferences.getBool('appFirstRun') ?? true;

// Auto-update notice
bool get autoUpdateNotice => sharedPreferences.getBool('autoUpdateNotice') ?? true;

// Block for Picture in Picture mode
bool blockPipMode = false;

// Animation default values
const Duration kAnimationShortDuration = Duration(milliseconds: 150);
const Duration kAnimationDuration = Duration(milliseconds: 300);
const Duration kAnimationLongDuration = Duration(milliseconds: 500);
const Curve kAnimationCurve = Easing.standard;