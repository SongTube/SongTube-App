import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider extends ChangeNotifier {

  PreferencesProvider() {
    init();
  }

  // Initialize Shared Preferences
  void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Preferences Instance
  SharedPreferences prefs;

  // Favorites Videos
  List<StreamInfoItem> get favoriteVideos {
    var map = jsonDecode(prefs.getString('newFavoriteVideos') ?? "{}");
    List<StreamInfoItem> videos = [];
    if (map.isNotEmpty) {
      if (map['favoriteVideos'].isNotEmpty) {
        map['favoriteVideos'].forEach((v) {
          videos.add(StreamInfoItem.fromMap(v));
        });
      }
    }
    return videos;
  }
  set favoriteVideos(List<StreamInfoItem> videos) {
    var map = videos.map((e) {
      return e.toMap();
    }).toList();
    String json = jsonEncode({ 'favoriteVideos': map });
    prefs.setString('newFavoriteVideos', json).then((_) {
      notifyListeners();
    });
  }

  // Watch Later Videos
  List<StreamInfoItem> get watchLaterVideos {
    var map = jsonDecode(prefs.getString('newWatchLaterList') ?? "{}");
    List<StreamInfoItem> videos = [];
    if (map.isNotEmpty) {
      if (map['watchLaterList'].isNotEmpty) {
        map['watchLaterList'].forEach((v) {
          videos.add(StreamInfoItem.fromMap(v));
        });
      }
    }
    return videos;
  }
  set watchLaterVideos(List<StreamInfoItem> videos) {
    var map = videos.map((e) {
      return e.toMap();
    }).toList();
    String json = jsonEncode({ 'watchLaterList': map });
    prefs.setString('newWatchLaterList', json).then((_) {
      notifyListeners();
    });
  }

  // View History Videos
  List<StreamInfoItem> get viewHistory {
    var map = jsonDecode(prefs.getString('newViewHistory') ?? "{}");
    List<StreamInfoItem> videos = [];
    if (map.isNotEmpty) {
      if (map['viewHistory'].isNotEmpty) {
        map['viewHistory'].forEach((v) {
          videos.add(StreamInfoItem.fromMap(v));
        });
      }
    }
    return videos;
  }
  set addVideoToViewHistory(StreamInfoItem video) {
    List<StreamInfoItem> videos = viewHistory;
    videos.add(video);
    var map = videos.map((e) {
      return e.toMap();
    }).toList();
    String json = jsonEncode({ 'viewHistory': map });
    prefs.setString('newViewHistory', json).then((_) {
      notifyListeners();
    });
  }

  // Join Telegram Dialog
  bool get showJoinTelegramDialog {
    return prefs.getBool('joinTelegramDialog') ?? true;
  }
  set showJoinTelegramDialog(bool value) {
    prefs.setBool('joinTelegramDialog', value);
  }
  // Remind Later
  bool remindTelegramLater = false;

  // Enable/Disable App's BlurUI
  bool get enableBlurUI {
    return prefs.getBool('enable_BlurUI') ?? false;
  }
  set enableBlurUI(bool value) {
    prefs.setBool('enable_BlurUI', value);
    notifyListeners();
  }

  bool get enablePlayerBlurBackground {
    return prefs?.getBool('enablePlayerBlurBackground') ?? true;
  }
  set enablePlayerBlurBackground(bool value) {
    prefs.setBool('enablePlayerBlurBackground', value);
    notifyListeners();
  }

  // MusicPlayer Artwork Rounded Corners
  double get musicPlayerArtworkRoundCorners {
    return prefs.getDouble('musicPlayerArtworkRoundCorners') ?? 20;
  }
  set musicPlayerArtworkRoundCorners(double value) {
    prefs.setDouble('musicPlayerArtworkRoundCorners', value);
    notifyListeners();
  }

  // Youtube Auto-Play
  bool get youtubeAutoPlay {
    return prefs.getBool('youtubeAutoPlay') ?? true;
  }

  set youtubeAutoPlay(bool value) {
    prefs.setBool('youtubeAutoPlay', value);
    notifyListeners();
  }

  // Watch History
  List<StreamInfoItem> get watchHistory {
    String json = prefs.getString('newWatchHistory');
    if (json == null) return [];
    var map = jsonDecode(json);
    List<StreamInfoItem> history = [];
    if (map.isNotEmpty) {
      map.forEach((element) {
        history.add(StreamInfoItem.fromMap(element));
      });
    }
    return history;
  }

  set watchHistory(List<StreamInfoItem> history) {
    List<Map<String, dynamic>> map =
      history.map((e) => e.toMap()).toList();
    prefs.setString('newWatchHistory', jsonEncode(map));
    notifyListeners();
  }

  void watchHistoryInsert(dynamic video) {
    List<StreamInfoItem> history = watchHistory;
    history.add(video);
    watchHistory = history;
  }

}