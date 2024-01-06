import 'package:flutter/material.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/ui/components/fancy_scaffold.dart';
import 'package:songtube/ui/components/palette_loader.dart';

enum CurrentPlayer { music, video }

class UiProvider extends ChangeNotifier {

  // Bottom Navigation Bar Current Index
  int _bottomNavigationBarIndex = AppSettings.defaultLandingPage;
  int get bottomNavigationBarIndex => _bottomNavigationBarIndex;
  set bottomNavigationBarIndex(int value) {
    _bottomNavigationBarIndex = value;
    notifyListeners();
  }

  /// Loads the User's preferred ThemeMode from local or remote storage.
  ThemeMode get themeMode {
    final savedMode = sharedPreferences.getInt('themeMode') ?? 0;
    switch (savedMode) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    switch (theme) {
      case ThemeMode.system:
        await sharedPreferences.setInt('themeMode', 0);
        break;
      case ThemeMode.light:
        await sharedPreferences.setInt('themeMode', 1);
        break;
      case ThemeMode.dark:
        await sharedPreferences.setInt('themeMode', 2);
        break;
    }
    notifyListeners();
  }

  // Palette Loader Controller
  PaletteLoaderController paletteLoaderController = PaletteLoaderController();

  // Determines the current player so we allow the user to switch
  // between the MusicPlayer of the VideoPlayer
  CurrentPlayer _currentPlayer = CurrentPlayer.video;
  CurrentPlayer get currentPlayer => _currentPlayer;
  set currentPlayer(CurrentPlayer player) {
    _currentPlayer = player;
    notifyListeners();
  }

  // Switch Between Players
  void switchPlayers() {
    if (_currentPlayer == CurrentPlayer.video) {
      currentPlayer = CurrentPlayer.music;
      paletteLoaderController.switchToSongColors();
    } else {
      currentPlayer = CurrentPlayer.video;
      paletteLoaderController.switchToVideoColors();
    }
  }

  // Floating Music/Video Widget Controller
  FloatingWidgetController fwController =
    FloatingWidgetController();

  // Indicate if we are on another route different than home
  bool onAltRoute = false;

  // Search Controllers
  TextEditingController homeSearchController = TextEditingController();
  FocusNode homeSearchNode = FocusNode();
  TextEditingController musicSearchController = TextEditingController();
  FocusNode musicSearchNode = FocusNode();

  // Update State
  void setState() {
    notifyListeners();
  }

}