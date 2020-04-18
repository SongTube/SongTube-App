<<<<<<< HEAD
// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';

// Packages
=======
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
>>>>>>> 63c4d8d... Initial automatic theming implementation
import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Key identifiers for variables saved in SharedPreferences.
<<<<<<< HEAD
String accentKey = "accent_color";
String systemThemeKey = "use_system_theme";
String darkThemeKey = "use_dark_theme";
String blackThemeKey = "use_black_theme";
String enableAudioConvertion= "enable_audio_convertion";
String enableVideoConvertion= "enable_video_convertion";
=======
String _accentKey = "accent_color";
String _systemThemeKey = "use_system_theme";
String _darkThemeKey = "use_dark_theme";
String _blackThemeKey = "use_black_theme";
>>>>>>> 63c4d8d... Initial automatic theming implementation

class Preferences {
  SharedPreferences prefs;

<<<<<<< HEAD
  Future<void> init() async => prefs = await SharedPreferences.getInstance();
=======
  Future<Preferences> init() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }
>>>>>>> 63c4d8d... Initial automatic theming implementation

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

<<<<<<< HEAD
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

=======
  Color get accentColor => Color(prefs.getInt(_accentKey) ?? Colors.blueAccent.value);
  set accentColor(Color color) => prefs.setInt(_accentKey, color.value);

  bool get systemThemeEnabled => prefs.getBool(_systemThemeKey) ?? true;
  set systemThemeEnabled(bool value) => prefs.setBool(_systemThemeKey, value);
  
  bool get darkThemeEnabled => prefs.getBool(_darkThemeKey) ?? false;
  set darkThemeEnabled(bool value) => prefs.setBool(_darkThemeKey, value);

  bool get blackThemeEnabled => prefs.getBool(_blackThemeKey) ?? false;
  set blackThemeEnabled(bool value) => prefs.setBool(_blackThemeKey, value);
>>>>>>> 63c4d8d... Initial automatic theming implementation
}
