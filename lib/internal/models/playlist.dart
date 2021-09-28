import 'dart:convert';
import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';

class LocalPlaylist {

  String id;
  String name;
  List<MediaItem> songs;

  LocalPlaylist({
    this.id,
    this.name,
    this.songs,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'songs': songs.map((e) {
          return {
            'id': e.id,
            'title': e.title,
            'album': e.album,
            'artist': e.artist,
            'genre': e.genre,
            'duration': e.duration.inSeconds.toString(),
            'artUri': e.artUri.toString(),
            "artwork": e.extras['artwork'],
            "albumId": e.extras["albumId"]
          };
        }).toList(),
    };
  }

  static LocalPlaylist fromMap(Map<dynamic, dynamic> map) {
    return LocalPlaylist(
      id: map['id'],
      name: map['name'],
      songs: List.generate(map['songs'].length, (index) {
        Map<dynamic, dynamic> song = map['songs'][index];
        return MediaItem(
          id: song['id'],
          title: song['title'],
          album: song['album'],
          artist: song['artist'],
          genre: song['genre'],
          duration: Duration(seconds: int.parse(song['duration'])),
          artUri: Uri.parse(song['artUri']),
          extras: {
            'artwork': song['artwork'],
            'albumId': song['albumId']
          }
        );
      }),
    );
  }

  static String listToJson(List<LocalPlaylist> list) {
    if (list == null || list.isEmpty) return "";
    return jsonEncode(List.generate(list.length, (index) {
      return list[index].toMap();
    }).toList());
  }

  static List<LocalPlaylist> fromJsonList(String json) {
    if (json == null || json == "") return [];
    var map = jsonDecode(json);
    return List.generate(map.length, (index) {
      Map<dynamic, dynamic> playlist = map[index];
      return LocalPlaylist(
        id: playlist['id'],
        name: playlist['name'],
        songs: List.generate(playlist['songs'].length, (index) {
          Map<dynamic, dynamic> song = playlist['songs'][index];
          return MediaItem(
            id: song['id'],
            title: song['title'],
            album: song['album'],
            artist: song['artist'],
            genre: song['genre'],
            duration: Duration(seconds: int.parse(song['duration'])),
            artUri: Uri.parse(song['artUri']),
            extras: {
              'artwork': song['artwork'],
              'albumId': song['albumId']
            }
          );
        }),
      );
    });
  }

}

class StreamPlaylist {

  String name;
  String author;
  List<StreamInfoItem> streams;
  bool favorited;

  StreamPlaylist({
    this.name,
    this.author,
    this.streams,
    this.favorited
  });

  Map<dynamic, dynamic> toMap(StreamPlaylist playlist) {
    return {
      'name': name,
      'author': author,
      'streams': StreamInfoItem.listToJson(streams),
      'favorited': favorited.toString()
    };
  }

  static StreamPlaylist fromMap(Map<dynamic, dynamic> map) {
    return StreamPlaylist(
      name: map['name'],
      author: map['author'],
      streams: StreamInfoItem.fromJsonString(map['streams']),
      favorited: map['favorited'] == "true" ? true : false
    );
  }

  static String listToJson(List<StreamPlaylist> list) {
    if (list == null || list.isEmpty) return "";
    return jsonEncode(List.generate(list.length, (index) {
      StreamPlaylist playlist = list[index];
      return {
        'name': playlist.name,
        'author': playlist.author,
        'streams': StreamInfoItem?.listToJson(playlist.streams)??"",
        'favorited': playlist.favorited.toString()
      };
    }));
  }

  static List<StreamPlaylist> fromJsonList(String json) {
    if (json == null || json == "") return [];
    var map = jsonDecode(json);
    return List.generate(map.length, (index) {
      Map<dynamic, dynamic> playlist = map[index];
      return StreamPlaylist(
        name: playlist['name'],
        author: playlist['author'],
        streams: StreamInfoItem?.fromJsonString(playlist['streams'])??[],
        favorited: playlist['favorited'] == "true" ? true : false
      );
    });
  }

}