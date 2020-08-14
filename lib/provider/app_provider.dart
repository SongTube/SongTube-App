// Dart
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

// Internal
import 'package:songtube/internal/preferences.dart';

// Packages
import 'package:ext_storage/ext_storage.dart';

class AppDataProvider extends ChangeNotifier {

  Preferences preferences;
  AppDataProvider({
    @required this.preferences
  }){
    preferences = this.preferences;
    initProvider();
  }

  void initProvider() {
    loadSavedData();
    if (_audioDownloadPath == null)
      ExtStorage.getExternalStorageDirectory().then((value) {
        _audioDownloadPath = value + "/SongTube";
        if (!Directory(_audioDownloadPath).existsSync())
          Directory(_audioDownloadPath).createSync();
      });
    if (_videoDownloadPath == null)
      ExtStorage.getExternalStorageDirectory().then((value) {
        _videoDownloadPath = value + "/SongTube";
        if (!Directory(_videoDownloadPath).existsSync())
          Directory(_videoDownloadPath).createSync();
      });
    PackageInfo.fromPlatform().then((value) {
      appName = value.appName;
      packageName = value.packageName;
      appVersion = value.version;
      buildNumber = value.buildNumber;
    });
    accentColor = preferences.getAccentColor();
  }

  // Platform Info
  String appName;
  String packageName;
  String appVersion;
  String buildNumber;

  Color _accentColor;
  bool _systemThemeAvailable = false;
  bool _systemThemeEnabled = false;
  bool _darkThemeEnabled = false;
  bool _blackThemeEnabled = false;
  bool _enableAudioConvertion = true;
  bool _enableVideoConvertion = false;  
  // Converting audio format
  String _audioConvertFormat = "AAC";
  // Download paths
  String _audioDownloadPath;
  String _videoDownloadPath;
  // Use Youtube Webview
  bool _useYoutubeWebview = false;
  Color get accentColor => _accentColor;
  bool get systemThemeAvailable => _systemThemeAvailable;
  bool get systemThemeEnabled => _systemThemeEnabled;
  bool get darkThemeEnabled => _darkThemeEnabled;
  bool get blackThemeEnabled => _blackThemeEnabled;
  bool get enableAudioConvertion => _enableAudioConvertion;
  bool get enableVideoConvertion => _enableVideoConvertion;
  // Converting audio format
  String get audioConvertFormat => _audioConvertFormat;
  // Download paths
  String get audioDownloadPath => _audioDownloadPath;
  String get videoDownloadPath => _videoDownloadPath;
  // Use Youtube Webview
  bool get useYoutubeWebview => _useYoutubeWebview;

  set systemThemeAvailable(bool value){
    _systemThemeAvailable = value;
    if (value)
      _systemThemeEnabled = preferences.getSystemThemeEnabled();
    else 
      _systemThemeEnabled = false;
    notifyListeners();
  }

  set accentColor(Color value) {
    _accentColor = value;
    preferences.saveAccentColor(value);
    notifyListeners();
  }

  set systemThemeEnabled(bool value) {
    _systemThemeEnabled = value;
    preferences.saveSystemThemeEnabled(value);
    notifyListeners();
  }

  set darkThemeEnabled(bool value) {
    _darkThemeEnabled = value;
    preferences.saveDarkThemeEnabled(value);
    notifyListeners();
  }

  set blackThemeEnabled(bool value) {
    _blackThemeEnabled = value;
    preferences.saveBlackThemeEnabled(value);
    notifyListeners();
  }

  set enableAudioConvertion(bool value) {
    _enableAudioConvertion = value;
    preferences.saveEnableAudioConvertion(value);
    notifyListeners();
  }

  set enableVideoConvertion(bool value) {
    _enableVideoConvertion = value;
    preferences.saveEnableVideoConvertion(value);
    notifyListeners();
  }

  void loadSavedData() {
    systemThemeAvailable = preferences.isSystemThemeAvailable;
    accentColor = preferences.getAccentColor();
    darkThemeEnabled = preferences.getDarkThemeEnabled();
    blackThemeEnabled = preferences.getBlackThemeEnabled();
    audioConvertFormat = preferences.getAudioConvertingFormat();
    audioDownloadPath = preferences.getAudioDownloadPath();
    videoDownloadPath = preferences.getVideoDownloadPath();
    useYoutubeWebview = true;
  }

  // Converting audio format
  set audioConvertFormat(String format) {
    _audioConvertFormat = format;
    preferences.saveAudioConvertingFormat(format);
    notifyListeners();
  }

  // Download paths
  set audioDownloadPath(String path) {
    _audioDownloadPath = path;
    preferences.saveAudioDownloadPath(path);
    notifyListeners();
  }
  set videoDownloadPath(String path) {
    _videoDownloadPath = path;
    preferences.saveVideoDownloadPath(path);
    notifyListeners();
  }

  // Use Youtube Webview
  set useYoutubeWebview(bool value) {
    _useYoutubeWebview = value;
    preferences.saveUseYoutubeWebview(value);
    notifyListeners();
  }

}
