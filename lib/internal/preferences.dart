// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Key identifiers for variables saved in SharedPreferences.
String accentKey = "accent_color";
String systemThemeKey = "use_system_theme";
String darkThemeKey = "use_dark_theme";
String blackThemeKey = "use_black_theme";
String enableAudioConvertion= "enable_audio_convertion";
String enableVideoConvertion= "enable_video_convertion";
String audioConvertingFormat = "audio_converting_format";
String audioDownloadPath = "audio_download_path";
String videoDownloadPath = "video_download_path";

class Preferences {
  SharedPreferences prefs;

  Future<void> init() async => prefs = await SharedPreferences.getInstance();

  Future<bool> isSystemThemeAvailable() async {
    String version;
    if(Platform.isAndroid){
      AndroidDeviceInfo deviceInfo = await DeviceInfoPlugin().androidInfo;
      version = deviceInfo.version.release;
    } else if (Platform.isIOS) {
      IosDeviceInfo deviceInfo = await DeviceInfoPlugin().iosInfo;
      version = deviceInfo.systemVersion;
    }
    if (double.parse(version) >= 9 || double.parse(version) >= 13)
      return true;
    else return false;
  }

  Color getAccentColor() {
    return Color(prefs.getInt(accentKey) ?? Colors.blueAccent.value);
  }

  void saveAccentColor(Color color) {
    prefs.setInt(accentKey, color.value);
  }

  bool getSystemThemeEnabled() {
    return prefs.getBool(systemThemeKey) ?? true;
  }

  void saveSystemThemeEnabled(bool value) {
    prefs.setBool(systemThemeKey, value);
  }

  bool getDarkThemeEnabled() {
    return prefs.getBool(darkThemeKey) ?? false;
  }

  void saveDarkThemeEnabled(bool value){
    prefs.setBool(darkThemeKey, value);
  }

  bool getBlackThemeEnabled() {
    return prefs.getBool(blackThemeKey) ?? false;
  }

  void saveBlackThemeEnabled(bool value) {
    prefs.setBool(blackThemeKey, value);
  }

  bool getEnableAudioConvertion() {
    return prefs.getBool(enableAudioConvertion) ?? true;
  }

  void saveEnableAudioConvertion(bool value) {
    prefs.setBool(enableAudioConvertion, value);
  }

  bool getEnableVideoConvertion() {
    return prefs.getBool(enableVideoConvertion) ?? false;
  }

  void saveEnableVideoConvertion(bool value) {
    prefs.setBool(enableVideoConvertion, value);
  }

  void saveAudioConvertingFormat(String format) {
    prefs.setString(audioConvertingFormat, format);
  }

  String getAudioConvertingFormat() {
    return prefs.getString(audioConvertingFormat) ?? "AAC";
  }

  String getAudioDownloadPath() {
    return prefs.getString(audioDownloadPath);
  }

  String getVideoDownloadPath() {
    return prefs.getString(videoDownloadPath);
  }

  void saveAudioDownloadPath(String path) {
    prefs.setString(audioDownloadPath, path);
  }

  void saveVideoDownloadPath(String path) {
    prefs.setString(videoDownloadPath, path);
  }

}
