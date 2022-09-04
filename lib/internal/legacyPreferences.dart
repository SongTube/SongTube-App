// Dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// Flutter
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

// Packages
import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:songtube/internal/globals.dart';

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

class LegacyPreferences {
  
  Future<void> initPreferences() async {
    AndroidDeviceInfo deviceInfo = await DeviceInfoPlugin().androidInfo;
    sdkInt = deviceInfo.version.sdkInt;
    if (sdkInt >= 28) {
      isSystemThemeAvailable = true;
    } else {isSystemThemeAvailable = false;}
  }

  int sdkInt;

  bool isSystemThemeAvailable;

  Color getAccentColor() {
    return Color(globalPrefs.getInt(accentKey) ?? Colors.redAccent.value);
  }

  void saveAccentColor(Color color) {
    globalPrefs.setInt(accentKey, color.value);
  }

  bool getSystemThemeEnabled() {
    return globalPrefs.getBool(systemThemeKey) ?? true;
  }

  void saveSystemThemeEnabled(bool value) {
    globalPrefs.setBool(systemThemeKey, value);
  }

  bool getDarkThemeEnabled() {
    return globalPrefs.getBool(darkThemeKey) ?? false;
  }

  void saveDarkThemeEnabled(bool value){
    globalPrefs.setBool(darkThemeKey, value);
  }

  bool getBlackThemeEnabled() {
    return globalPrefs.getBool(blackThemeKey) ?? false;
  }

  void saveBlackThemeEnabled(bool value) {
    globalPrefs.setBool(blackThemeKey, value);
  }

  bool getEnableFFmpegActionTypeion() {
    return globalPrefs.getBool(enableFFmpegActionTypeion) ?? true;
  }

  void saveEnableFFmpegActionTypeion(bool value) {
    globalPrefs.setBool(enableFFmpegActionTypeion, value);
  }

  bool getEnableVideoConvertion() {
    return globalPrefs.getBool(enableVideoConvertion) ?? false;
  }

  void saveEnableVideoConvertion(bool value) {
    globalPrefs.setBool(enableVideoConvertion, value);
  }

  void saveFFmpegActionTypeingFormat(String format) {
    globalPrefs.setString(ffmpegActionTypeingFormat, format);
  }

  String getFFmpegActionTypeingFormat() {
    return globalPrefs.getString(ffmpegActionTypeingFormat) ?? "AAC";
  }

  String getAudioDownloadPath() {
    return globalPrefs.getString(audioDownloadPath);
  }

  String getVideoDownloadPath() {
    return globalPrefs.getString(videoDownloadPath);
  }

  void saveAudioDownloadPath(String path) {
    globalPrefs.setString(audioDownloadPath, path ?? '');
  }

  void saveVideoDownloadPath(String path) {
    globalPrefs.setString(videoDownloadPath, path ?? '');
  }

  bool getUseYoutubeWebview() {
    return globalPrefs.getBool(useYoutubeWebview) ?? false;
  }

  void saveUseYoutubeWebview(bool value) {
    globalPrefs.setBool(useYoutubeWebview, value);
  }

  bool showIntroductionPages() {
    return globalPrefs.getBool(showIntroduction) ?? true;
  }

  void saveShowIntroductionPages(bool value) {
    globalPrefs.setBool(showIntroduction, value);
  }

  bool getEnableAlbumFolder() {
    return globalPrefs.getBool(albumFolder) ?? false;
  }

  void saveEnableAlbumFolder(bool value) {
    globalPrefs.setBool(albumFolder, value);
  }

  // Search History
  String getSearchHistory() {
    return globalPrefs.getString(searchHistory) ?? "[]";
  }
  void saveSearchHistory(String history) {
    globalPrefs.setString(searchHistory, history);
  }

  // Navigate ChannelLogo Cache
  String getChannelLogos() {
    return globalPrefs.getString(channelLogo) ?? "{}";
  }
  void saveChannelLogos(String json) {
    globalPrefs.setString(channelLogo, json);
  }

  //
  // Settings for the MusicPlayer are found bellow this
  //

  bool getExpandedArtwork() {
    return globalPrefs.getBool(expandedArtwork) ?? true;
  }
  void saveExpandedArtwork(bool value) {
    globalPrefs.setBool(expandedArtwork, value);
  }
  bool getBlurBackground() {
    return globalPrefs.getBool(blurBackground) ?? true;
  }
  void saveBlurBackground(bool value) {
    globalPrefs.setBool(blurBackground, value);
  }

  // Disclaimer Status
  bool getDisclaimerStatus() {
    return globalPrefs.getBool(disclaimerKey) ?? false;
  }
  void saveDisclaimerStatus(bool value) {
    globalPrefs.setBool(disclaimerKey, value);
  }

  // Fix Downloads on Android 11 Status
  bool getShowDownloadFixDialog() {
    return globalPrefs.getBool(fixStatus) ?? true;
  }
  void saveShowDownloadFixDialog(bool value) {
    globalPrefs.setBool(fixStatus, value);
  }

  // Set/Get cached device songs
  Future<List<MediaItem>> getCachedSongs() async {
    final songs = <MediaItem>[];
    final cached = globalPrefs.getString('cachedSongs') ?? '';
    if (cached.isNotEmpty) {
      final map = jsonDecode(cached);
      for (final song in map) {
        if (await File(song['id']).exists()) {
          songs.add(MediaItem(
            id: song['id'],
            title: song['title'],
            album: song['album'],
            artist: song['artist'],
            genre: song['genre'],
            artUri: Uri.parse(song['artUri']),
            duration: song['duration'] != null ? Duration(seconds: int.parse(song['duration'])) : null,
            extras: {
              "downloadType": song['extras']['downloadType'],
              "artwork": song['extras']['artwork'],
            }
          ));
        }
      }
    }
    songs.sort((a, b) => a.title.toLowerCase().trim()
      .compareTo(b.title.toLowerCase().trim()));
    return songs;
  }
  void saveCachedSongs(List<MediaItem> list) {
    final songs = List.generate(list.length, (index) {
      if (File(list[index].id).existsSync()) {
        return list[index];
      }
    });
    if (songs.isEmpty) {
      globalPrefs.setString('cachedSongs', '');
    } else {
      final map = List.generate(songs.length, (index) {
        final song = songs[index];
        return {
          'id': song.id,
          'album': song.album,
          'title': song.title,
          'artist': song.artist,
          'genre': song.genre,
          'duration': song.duration != null ? song.duration.inSeconds.toString() : null,
          'artUri': song.artUri.toString(),
          'extras': {
            'downloadType': song.extras['downloadType'],
            'artwork': song.extras['artwork']
          }
        };
      });
      globalPrefs.setString('cachedSongs', jsonEncode(map));
    }
  }

}
