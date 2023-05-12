import 'dart:convert';

import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/song_item.dart';

class CacheUtils {

  // -------------------------
  // Cached Watch History
  // -------------------------
  static List<StreamInfoItem> get watchHistory {
    String? json = sharedPreferences.getString('watchHistory');
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
  static set watchHistory(List<StreamInfoItem> history) {
    List<Map<dynamic, dynamic>> map =
      history.map((e) => e.toMap()).toList();
    sharedPreferences.setString('watchHistory', jsonEncode(map));
  }

  // -------------------------
  // Cached songs get/setter
  // -------------------------
  static List<SongItem> get cacheSongs {
    if (sharedPreferences.getString('deviceSongs') != null) {
      final List<dynamic> songsMap = jsonDecode(sharedPreferences.getString('deviceSongs')!);
      return List<SongItem>.generate(songsMap.length, (index) {
        return SongItem.fromMap(songsMap[index]);
      });
    } else {
      return <SongItem>[];
    }
  }

  static set cacheSongs(List<SongItem> songs) {
    if (songs.isNotEmpty) {
      final map = List<Map<String, dynamic>>.generate(
        songs.length, (index) => songs[index].toMap());
      sharedPreferences.setString('deviceSongs', jsonEncode(map));
    }
  }

  

}