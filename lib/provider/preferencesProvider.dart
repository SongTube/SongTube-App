import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

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
  List<Video> get favoriteVideos {
    var map = jsonDecode(prefs.getString('favoriteVideos') ?? "{}");
    List<Video> videos = [];
    if (map.isNotEmpty) {
      if (map['favoriteVideos'].isNotEmpty) {
        map['favoriteVideos'].forEach((v) {
          videos.add(Video.fromMap(v));
        });
      }
    }
    return videos;
  }
  set favoriteVideos(List<Video> videos) {
    var map = videos.map((e) {
      return e.toMap();
    }).toList();
    String json = jsonEncode({ 'favoriteVideos': map });
    prefs.setString('favoriteVideos', json).then((_) {
      notifyListeners();
    });
  }

  // Watch Later Videos
  List<Video> get watchLaterVideos {
    var map = jsonDecode(prefs.getString('watchLaterList') ?? "{}");
    List<Video> videos = [];
    if (map.isNotEmpty) {
      if (map['watchLaterList'].isNotEmpty) {
        map['watchLaterList'].forEach((v) {
          videos.add(Video.fromMap(v));
        });
      }
    }
    return videos;
  }
  set watchLaterVideos(List<Video> videos) {
    var map = videos.map((e) {
      return e.toMap();
    }).toList();
    String json = jsonEncode({ 'watchLaterList': map });
    prefs.setString('watchLaterList', json).then((_) {
      notifyListeners();
    });
  }



}