// Dart
import 'dart:async';

// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Key identifiers for variables saved in SharedPreferences.
String accentKey = "app_accent_color";
String systemThemeKey = "use_system_theme";
String darkThemeKey = "use_dark_theme";
String blackThemeKey = "use_black_theme";
String enableAudioConvertion= "enable_audio_convertion";
String enableVideoConvertion= "enable_video_convertion";
String audioConvertingFormat = "audio_converting_format";
String audioDownloadPath = "audio_download_path";
String videoDownloadPath = "video_download_path";
String useYoutubeWebview = "use_youtube_webview";
String appColor = "app_color";
String showIntroduction = "show_introduction";

class Preferences {
  
  SharedPreferences prefs;

  Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    String version;
    AndroidDeviceInfo deviceInfo = await DeviceInfoPlugin().androidInfo;
    version = deviceInfo.version.release;
    if (double.parse(version) >= 9 || double.parse(version) >= 13) {
      isSystemThemeAvailable = true;
    } else {isSystemThemeAvailable = false;}
  }

  bool isSystemThemeAvailable;

  Color getAccentColor() {
    return Color(prefs.getInt(accentKey) ?? Colors.redAccent.value);
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

  bool getUseYoutubeWebview() {
    return prefs.getBool(useYoutubeWebview) ?? false;
  }

  void saveUseYoutubeWebview(bool value) {
    prefs.setBool(useYoutubeWebview, value);
  }

  bool showIntroductionPages() {
    return prefs.getBool(showIntroduction) ?? true;
  }

  void saveShowIntroductionPages(bool value) {
    prefs.setBool(showIntroduction, value);
  }

}
