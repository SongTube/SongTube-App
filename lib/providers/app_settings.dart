import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/global.dart';

// FFmpeg Related Keys
const defaultFfmpegTaskKey = 'defaultFfmpegTask';

// App Save Directories Keys
const musicDirectoryKey = 'music_directory';
const videoDirectoryKey = 'video_directory';

// Music Player Keys
const enableMusicPlayerBlurKey = 'enablePlayerBlurKey';
const musicPlayerBackdropOpacityKey = 'musicPlayerBlurOpacity';
const musicPlayerBlurStrenghtKey = 'musicPlayerBlurStrenght';
const musicPlayerArtworkZoomKey = 'musicPlayerArtworkZoom';
const musicPlayerLandingPage = 'musicPlayerLandingPage';

// Home Screen Settings
const defaultLandingPageKey = 'defaultLandingPage';

// Download Keys
const maxSimultaneousDownloadsKey = 'maxSimultaneousDownloads';

// Watch History Status
const enableWatchHistoryKey = 'enableWatchHistory';

// Background Playback Key (Alpha Feature)
const enableBackgroundPlaybackKey = 'enableBackgroundPlayback';

// Auto Picture in Picture mode
const enableAutoPictureInPictureModeKey = 'enableAutoPictureInPictureMode';

// Last video quality saved
const lastVideoQualityKey = 'lastVideoQuality';

// Enable Material You Colors
const enableMaterialYouColorsKey = 'enableMaterialYouColors';

// Lock Navigation Bar from hiding
const lockNavigationBarKey = 'lockNavigationBar';

// Enable Music Player Background Parallax
const musicPlayerBackgroundParallaxKey = 'musicPlayerBackgroundParallaxKey';

// Music Player Artwork Shadow Level
const musicPlayerArtworkShadowLevelKey = 'musicPlayerArtworkShadowLevelKey';

// Music Player Artwork Shadow Radius
const musicPlayerArtworkShadowRadiusKey = 'musicPlayerArtworkShadowRadiusKey';

// Use System font family
const useSystemFontFamilyKey = 'useSystemFontFamilyKey';

// Video suggestions view mode
const videoSuggestionsViewModeKey = 'videoSuggestionsViewMode';

// Hide appbar when video player is expanded
const hideSystemAppBarOnVideoPlayerExpandedKey = 'hideSystemAppBarOnVideoPlayerExpanded';

// Dynamic Colors
const enableDynamicColorsKey = 'enableDynamicColorsKey';

class AppSettings extends ChangeNotifier {

  // Initialize App Settings
  static Future<void> initSettings() async {
    final musicPath = sharedPreferences.getString(musicDirectoryKey);
    final videoPath = sharedPreferences.getString(videoDirectoryKey);
    // Check for our media directories, if they're null we have to set a default path
    if (musicPath == null) {
      final defaultMusicDirectory = await AndroidPathProvider.musicPath;
      await sharedPreferences.setString(musicDirectoryKey, defaultMusicDirectory);
    }
    if (videoPath == null) {
      final defaultVideoDirectory = await AndroidPathProvider.moviesPath;
      await sharedPreferences.setString(videoDirectoryKey, defaultVideoDirectory);
    }
  }

  // Dynamic Colors
  static bool get enableDynamicColors => sharedPreferences.getBool(enableDynamicColorsKey) ?? true;
  static set enableDynamicColors(bool value) {
    sharedPreferences.setBool(enableDynamicColorsKey, value);
  }

  // Home Screen Settings
  static int get defaultLandingPage => sharedPreferences.getInt(defaultLandingPageKey) ?? 0;
  static set defaultLandingPage(int value) {
    sharedPreferences.setInt(defaultLandingPageKey, value);
  }

  // Landing Music Page
  static int get defaultLandingMusicPage => sharedPreferences.getInt(musicPlayerLandingPage) ?? 0;
  static set defaultLandingMusicPage(int value) {
    sharedPreferences.setInt(musicPlayerLandingPage, value);
  }

  // Downloads Settings
  static int get maxSimultaneousDownloads => sharedPreferences.getInt(maxSimultaneousDownloadsKey) ?? 3;
  static set maxSimultaneousDownloads(int value) {
    sharedPreferences.setInt(maxSimultaneousDownloadsKey, value);
  }

  // Watch History
  static bool get enableWatchHistory => sharedPreferences.getBool(enableWatchHistoryKey) ?? true;
  static set enableWatchHistory(bool value) {
    sharedPreferences.setBool(enableWatchHistoryKey, value);
  }

  // FFmpeg Default Task
  static FFmpegTask get defaultFfmpegTask {
    if (sharedPreferences.containsKey(defaultFfmpegTaskKey)) {
      final task = sharedPreferences.get(defaultFfmpegTaskKey);
      if (task == 'aac') {
        return FFmpegTask.convertToAAC;
      } else if (task == 'mp3') {
        return FFmpegTask.convertToMP3;
      } else if (task == 'ogg') {
        return FFmpegTask.convertToOGG;
      } else {
        return FFmpegTask.convertToAAC;
      }
    } else {
      return FFmpegTask.convertToAAC;
    }
  }
  static set defaultFfmpegTask(FFmpegTask task) {
    final format = task.toString().split('.').last.split('convertTo').last.toLowerCase();
    sharedPreferences.setString(defaultFfmpegTaskKey, format);
  }

  // Default download directorie for Music
  static Directory get musicDirectory {
    final path = sharedPreferences.getString(musicDirectoryKey)!;
    return Directory(path);
  }
  static set musicDirectory(Directory directory) {
    final path = directory.path;
    sharedPreferences.setString(musicDirectoryKey, path);
  }

  // Default download directorie for Videos
  static Directory get videoDirectory {
    final path = sharedPreferences.getString(videoDirectoryKey)!;
    return Directory(path);
  }
  static set videoDirectory(Directory directory) {
    final path = directory.path;
    sharedPreferences.setString(videoDirectoryKey, path);
  }

  // MusicPlayer Settings
  bool get enableMusicPlayerBlur {
    return sharedPreferences.getBool(enableMusicPlayerBlurKey) ?? false;
  }
  set enableMusicPlayerBlur(bool value) {
    sharedPreferences.setBool(enableMusicPlayerBlurKey, value);
    notifyListeners();
  }
  double get musicPlayerBackdropOpacity {
    return sharedPreferences.getDouble(musicPlayerBackdropOpacityKey) ?? 0.2;
  }
  set musicPlayerBackdropOpacity(double value) {
    sharedPreferences.setDouble(musicPlayerBackdropOpacityKey, value);
    notifyListeners();
  }
  double get musicPlayerBlurStrenght {
    return sharedPreferences.getDouble(musicPlayerBlurStrenghtKey) ?? 50;
  }
  set musicPlayerBlurStrenght(double value) {
    sharedPreferences.setDouble(musicPlayerBlurStrenghtKey, value);
    notifyListeners();
  }
  double get musicPlayerArtworkZoom {
    return sharedPreferences.getDouble(musicPlayerArtworkZoomKey) ?? 1;
  }
  set musicPlayerArtworkZoom(double value) {
    sharedPreferences.setDouble(musicPlayerArtworkZoomKey, value);
    notifyListeners();
  }

  // Background Playback (Alpha)
  static bool get enableBackgroundPlayback => sharedPreferences.getBool(enableBackgroundPlaybackKey) ?? false;
  static set enableBackgroundPlayback(bool value) {
    sharedPreferences.setBool(enableBackgroundPlaybackKey, value);
  }

  // Auto Picture in Picture mode
  static bool get enableAutoPictureInPictureMode => sharedPreferences.getBool(enableAutoPictureInPictureModeKey) ?? true;
  static set enableAutoPictureInPictureMode(bool value) {
    sharedPreferences.setBool(enableAutoPictureInPictureModeKey, value);
  }

  // Cached last video quality
  static String get lastVideoQuality => sharedPreferences.getString(lastVideoQualityKey) ?? '720';
  static set lastVideoQuality(String qualityString) {
    sharedPreferences.setString(lastVideoQualityKey, qualityString);
  }

  // Enable Material You Colors
  bool get enableMaterialYou => sharedPreferences.getBool(enableMaterialYouColorsKey) ?? false;
  set enableMaterialYou(bool value) {
    sharedPreferences.setBool(enableMaterialYouColorsKey, value);
    notifyListeners();
  }

  // Lock Bottom Navigation Bar so it doesnt hides on scroll
  static bool get lockNavigationBar => sharedPreferences.getBool('lockNavigationBar') ?? false;
  static set lockNavigationBar(bool value) {
    sharedPreferences.setBool(lockNavigationBarKey, value);
  }

  // Music Player Background Image Parallax
  static bool get enableMusicPlayerBackgroundParallax => sharedPreferences.getBool(musicPlayerBackgroundParallaxKey) ?? true;
  static set enableMusicPlayerBackgroundParallax(bool value) {
    sharedPreferences.setBool(musicPlayerBackgroundParallaxKey, value);
  }

  // Music Player Artwork Shadow Level
  static double get musicPlayerArtworkShadowLevel => sharedPreferences.getDouble(musicPlayerArtworkShadowLevelKey) ?? 0.2;
  static set musicPlayerArtworkShadowLevel(double value) {
    sharedPreferences.setDouble(musicPlayerArtworkShadowLevelKey, value);
  }

  // Music Player Artwork Shadow Level
  static int get musicPlayerArtworkShadowRadius => sharedPreferences.getInt(musicPlayerArtworkShadowRadiusKey) ?? 12;
  static set musicPlayerArtworkShadowRadius(int value) {
    sharedPreferences.setInt(musicPlayerArtworkShadowRadiusKey, value);
  }

  // Use system default font family
  static bool get useSystemFontFamiliy => sharedPreferences.getBool(useSystemFontFamilyKey) ?? false;
  static set useSystemFontFamiliy(bool value) {
    sharedPreferences.setBool(useSystemFontFamilyKey, value);
  }

  // Update State
  void setState() {
    notifyListeners();
  }

  // Video Suggestions video mode
  static String get videoSuggestionsViewMode => sharedPreferences.getString(videoSuggestionsViewModeKey) ?? 'collapsed';
  static set videoSuggestionsViewMode(String mode) {
    sharedPreferences.setString(videoSuggestionsViewModeKey, mode);
  }

  // Fullscreen portrait video player
  bool get hideSystemAppBarOnVideoPlayerExpanded => sharedPreferences.getBool(hideSystemAppBarOnVideoPlayerExpandedKey) ?? false;
  set hideSystemAppBarOnVideoPlayerExpanded(bool value) {
    sharedPreferences.setBool(hideSystemAppBarOnVideoPlayerExpandedKey, value);
  }

}