import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/media_playlist.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:uuid/uuid.dart';

const allPlaylistKey = 'allPlaylistKey';
const favoritesKey = 'favoritesPlaylistKey';

class PlaylistProvider extends ChangeNotifier {

  List<MediaPlaylist> get globalPlaylists {
    final json = sharedPreferences.getString(allPlaylistKey);
    if (json == null) {
      return [];
    } else {
      final map = jsonDecode(json);
      final dataList = List<MediaPlaylist>.generate(map.length, (index) {
        final data = map[index];
        return MediaPlaylist.fromMap(data);
      });
      return dataList;
    }
  }

  set globalPlaylists(List<MediaPlaylist> items) {
    final mapList = List<Map<String, dynamic>>.generate(items.length, (index) {
      return items[index].toMap();
    });
    final json = jsonEncode(mapList);
    sharedPreferences.setString(allPlaylistKey, json).then((_) {
      notifyListeners();
    });
  }

  MediaPlaylist? getPlaylist(String key) {
    final data = sharedPreferences.getString(key);
    if (data != null) {
      final playlist = MediaPlaylist.fromJson(data);
      return playlist;
    }
    return null;
  }

  void savePlaylist({required MediaPlaylist playlist, required String key}) {
    final map = playlist.toMap();
    final json = jsonEncode(map);
    sharedPreferences.setString(key, json).then((_) {
      notifyListeners();
    });
  } 

  // Create - Delete Playlists
  void createGlobalPlaylist(String name, {required List<SongItem> songs}) {
    final global = List<MediaPlaylist>.from(globalPlaylists);
    final newPlaylist = MediaPlaylist(id: const Uuid().v4(), name: name, favorite: false, songs: songs);
    global.add(newPlaylist);
    globalPlaylists = global;
  }
  void removeGlobalPlaylist(String id) {
    final global = List<MediaPlaylist>.from(globalPlaylists);
    global.removeWhere((element) => element.id == id);
    globalPlaylists = global;
  }

  // Update Global Playlist Artwork
  void updateGlobalPlaylist(String id, {List<SongItem>? songs, String? artworkPath, String? newName}) {
    final global = List<MediaPlaylist>.from(globalPlaylists);
    final playlist = global.firstWhere((element) => element.id == id);
    if (songs != null) {
      playlist.songs = songs;
    }
    if (artworkPath != null) {
      playlist.artworkPath = artworkPath;
    }
    if (newName != null && newName.trim().isNotEmpty) {
      playlist.name = newName;
    }
    // Save Playlist
    final index = global.indexWhere((element) => element.id == id);
    global.removeAt(index);
    global.insert(index, playlist);
    globalPlaylists = global;
  }

  // Add/Remove song to a global playlist
  void addToGlobalPlaylist(String id, {required SongItem song}){
    final global = List<MediaPlaylist>.from(globalPlaylists);
    final index = global.indexWhere((element) => element.id == id);
    if (index != -1) {
      if (global[index].songs.any((element) => element.id == song.id)) {
        global[index].songs.removeWhere((element) => element.id == song.id);
      } else {
        global[index].songs.add(song);
      }
      globalPlaylists = global;
    }
  }

  // Favorite a global playlist
  void favoriteGlobalPlaylist(String id) {
    final global = List<MediaPlaylist>.from(globalPlaylists);
    final index = global.indexWhere((element) => element.id == id);
    if (index != -1) {
      global[index].favorite = !global[index].favorite;
    }
    globalPlaylists = global;
  }

  // -------------------
  // Favorites Playlist
  // -------------------
  MediaPlaylist get favorites {
    final data = sharedPreferences.getString(favoritesKey);
    if (data != null) {
      return MediaPlaylist.fromJson(data);
    } else {
      final favoritesPlaylist = MediaPlaylist(id: 'userFavorites', name: 'Favorites', favorite: false, songs: []);
      sharedPreferences.setString(favoritesKey, favoritesPlaylist.toJson());
      return favoritesPlaylist;
    }
  }

  void addToFavorites(SongItem song) {
    final playlist = favorites;
    if (playlist.songs.any((element) => element.id == song.id)) {
      playlist.songs.removeWhere((element) => element.id == song.id);
    } else {
      playlist.songs.add(song);
    }
    sharedPreferences.setString(favoritesKey, playlist.toJson()).then((_) {
      notifyListeners();
    });
  }

}