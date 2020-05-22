// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/internal/preferences.dart';

class AppDataProvider extends ChangeNotifier {
  Preferences preferences;

  Future<void> initProvider() async {
    preferences = await Preferences().init();
    await loadSavedData();
    _libraryScaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Color _accentColor = Colors.redAccent;
  bool _systemThemeAvailable = false;
  bool _systemThemeEnabled = false;
  bool _darkThemeEnabled = false;
  bool _blackThemeEnabled = false;
  bool _appBarEnabled = true;
  bool _enableAudioConvertion = true;
  bool _enableVideoConvertion = false;
  // Library
  GlobalKey<ScaffoldState> _libraryScaffoldKey;
  int _screenIndex = 0;

  Color get accentColor => _accentColor;
  bool get systemThemeAvailable => _systemThemeAvailable;
  bool get systemThemeEnabled => _systemThemeEnabled;
  bool get darkThemeEnabled => _darkThemeEnabled;
  bool get blackThemeEnabled => _blackThemeEnabled;
  bool get appBarEnabled => _appBarEnabled;
  bool get enableAudioConvertion => _enableAudioConvertion;
  bool get enableVideoConvertion => _enableVideoConvertion;
  // Library
  GlobalKey<ScaffoldState> get libraryScaffoldKey => _libraryScaffoldKey;
  int get screenIndex => _screenIndex;

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

  Future<void> loadSavedData() async {
    systemThemeAvailable = await preferences.isSystemThemeAvailable();
    accentColor = preferences.getAccentColor();
    darkThemeEnabled = preferences.getDarkThemeEnabled();
    blackThemeEnabled = preferences.getBlackThemeEnabled();
  }

  // Library
  set screenIndex(int newValue) {
    _screenIndex = newValue;
    notifyListeners();
  }
}
