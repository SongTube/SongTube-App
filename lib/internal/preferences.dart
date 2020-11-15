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
String enableFFmpegActionTypeion= "enable_audio_convertion";
String enableVideoConvertion= "enable_video_convertion";
String ffmpegActionTypeingFormat = "audio_converting_format";
String audioDownloadPath = "audio_download_path";
String videoDownloadPath = "video_download_path";
String useYoutubeWebview = "use_youtube_webview";
String appColor = "app_color";
String showIntroduction = "show_introduction";
String albumFolder = "album_folder";

// Search History
String searchHistory = "search_history";

// Navigate ChannelLogo Cache
String channelLogo = "channel_logo";

// Settings for the MusicPlayer
String expandedArtwork = "expanded_artwork";
String blurBackground = "blur_background";

// Disclaimer Status
String disclaimerKey = "disclaimer_key";

// Fix Downloads on Android 11 Status
String fixStatus = "download_fix_status";

class Preferences {
  
  SharedPreferences prefs;

  Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    AndroidDeviceInfo deviceInfo = await DeviceInfoPlugin().androidInfo;
    int version = deviceInfo.version.sdkInt;
    if (version >= 28) {
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

  bool getEnableFFmpegActionTypeion() {
    return prefs.getBool(enableFFmpegActionTypeion) ?? true;
  }

  void saveEnableFFmpegActionTypeion(bool value) {
    prefs.setBool(enableFFmpegActionTypeion, value);
  }

  bool getEnableVideoConvertion() {
    return prefs.getBool(enableVideoConvertion) ?? false;
  }

  void saveEnableVideoConvertion(bool value) {
    prefs.setBool(enableVideoConvertion, value);
  }

  void saveFFmpegActionTypeingFormat(String format) {
    prefs.setString(ffmpegActionTypeingFormat, format);
  }

  String getFFmpegActionTypeingFormat() {
    return prefs.getString(ffmpegActionTypeingFormat) ?? "AAC";
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

  bool getEnableAlbumFolder() {
    return prefs.getBool(albumFolder) ?? false;
  }

  void saveEnableAlbumFolder(bool value) {
    prefs.setBool(albumFolder, value);
  }

  // Search History
  String getSearchHistory() {
    return prefs.getString(searchHistory) ?? "[]";
  }
  void saveSearchHistory(String history) {
    prefs.setString(searchHistory, history);
  }

  // Navigate ChannelLogo Cache
  String getChannelLogos() {
    return prefs.getString(channelLogo) ?? "{}";
  }
  void saveChannelLogos(String json) {
    prefs.setString(channelLogo, json);
  }

  //
  // Settings for the MusicPlayer are found bellow this
  //

  bool getExpandedArtwork() {
    return prefs.getBool(expandedArtwork) ?? true;
  }
  void saveExpandedArtwork(bool value) {
    prefs.setBool(expandedArtwork, value);
  }
  bool getBlurBackground() {
    return prefs.getBool(blurBackground) ?? true;
  }
  void saveBlurBackground(bool value) {
    prefs.setBool(blurBackground, value);
  }

  // Disclaimer Status
  bool getDisclaimerStatus() {
    return prefs.getBool(disclaimerKey) ?? false;
  }
  void saveDisclaimerStatus(bool value) {
    prefs.setBool(disclaimerKey, value);
  }

  // Fix Downloads on Android 11 Status
  bool getShowDownloadFixDialog() {
    return prefs.getBool(fixStatus) ?? true;
  }
  void saveShowDownloadFixDialog(bool value) {
    prefs.setBool(fixStatus, value);
  }
}
