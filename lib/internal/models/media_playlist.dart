// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:songtube/internal/models/media_set.dart';
import 'package:songtube/internal/models/song_item.dart';

class MediaPlaylist {

  String id;
  String? artworkPath;
  String name;
  bool favorite;
  List<SongItem> songs;
  MediaPlaylist({
    required this.id,
    this.artworkPath,
    required this.name,
    required this.favorite,
    required this.songs,
  });

  MediaSet toMediaSet() {
    return MediaSet(
      id: id,
      artwork: artworkPath,
      name: name,
      favorite: favorite,
      songs: songs
    );
  }

  MediaPlaylist copyWith({
    String? id,
    String? artworkPath,
    String? name,
    bool? favorite,
    List<SongItem>? songs,
  }) {
    return MediaPlaylist(
      id: id ?? this.id,
      artworkPath: artworkPath ?? this.artworkPath,
      name: name ?? this.name,
      favorite: favorite ?? this.favorite,
      songs: songs ?? this.songs,
    );
  }

  // Favorites
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'artworkPath': artworkPath,
      'name': name,
      'favorite': favorite,
      'songs': songs.map((x) => x.toMap()).toList(),
    };
  }

  factory MediaPlaylist.fromMap(Map<String, dynamic> map) {
    return MediaPlaylist(
      id: map['id'] as String,
      artworkPath: map['artworkPath'] != null ? map['artworkPath'] as String : null,
      name: map['name'] as String,
      favorite: map['favorite'] as bool,
      songs: List<SongItem>.from((map['songs'] as List<dynamic>).map<SongItem>((x) => SongItem.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaPlaylist.fromJson(String source) => MediaPlaylist.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MediaPlaylist(id: $id, artworkPath: $artworkPath, name: $name, favorite: $favorite, songs: $songs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MediaPlaylist &&
      other.id == id &&
      other.artworkPath == artworkPath &&
      other.name == name &&
      other.favorite == favorite &&
      listEquals(other.songs, songs);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      artworkPath.hashCode ^
      name.hashCode ^
      favorite.hashCode ^
      songs.hashCode;
  }
}
