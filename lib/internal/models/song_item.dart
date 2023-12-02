// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:audio_service/audio_service.dart';

import 'package:songtube/internal/artwork_manager.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/colors_palette.dart';

class SongItem {

  /// File path.
  final String id;

  /// A unique id (Commonly used for Artwork & Thumbnails).
  final String modelId;

  /// The title of this media item.
  final String title;

  /// The album this media item belongs to.
  final String? album;

  /// The artist of this media item.
  final String? artist;

  /// The genre of this media item.
  final String? genre;

  /// The duration of this media item.
  final Duration? duration;

  /// The artwork for this media item as a File.
  final File? artworkPath;

  /// Artwork URL for this media item as Uri
  final Uri? artworkUrl;

  /// The thumbnail for this media item as a File.
  final File? thumbnailPath;

  /// Whether this is playable (i.e. not a folder).
  final bool? playable;

  /// Override the default title for display purposes.
  final String? displayTitle;

  /// Override the default subtitle for display purposes.
  final String? displaySubtitle;

  /// Override the default description for display purposes.
  final String? displayDescription;

  /// Last Modified
  final DateTime lastModified;

  /// Video Id
  final String? videoId;

  // Is Video Check
  bool get isVideo {
    final format = id.split('/').last.split('.').last;
    if (format == 'mp4' || format == 'webm') {
      return true;
    } else {
      return false;
    }
  }

  /// Transform this object to MediaItem for MediaPlayer
  MediaItem get mediaItem => MediaItem(
    id: id,
    title: title,
    album: album,
    artist: artist,
    genre: genre,
    duration: duration,
    artUri: Uri.parse('file://${thumbnailFile(id).path}'),
    playable: playable,
    displayTitle: displayTitle,
    displaySubtitle: displaySubtitle,
    displayDescription: displayDescription,
    extras: {
      'artwork': artworkFile(id).path,
      'modelId': modelId,
    }
  );

  // Play Count
  int get playCount => sharedPreferences.getInt('$id-playcount') ?? 0;

  // Add a Play Count
  void addPlayCount() => sharedPreferences.setInt('$id-playcount', playCount+1);

  factory SongItem.fromMediaItem(MediaItem item) {
    FileStat stats = FileStat.statSync(item.id);
    return SongItem(
      id: item.id,
      modelId: item.extras != null ? item.extras!['modelId'] : '',
      title: item.title,
      album: item.album,
      artist: item.artist,
      genre: item.genre,
      duration: item.duration,
      artworkPath: artworkFile(item.id),
      thumbnailPath: thumbnailFile(item.id),
      playable: item.playable,
      displayTitle: item.displayTitle,
      displaySubtitle: item.displaySubtitle,
      displayDescription: item.displayDescription,
      lastModified: stats.changed,
    );
  }

  SongItem({
    required this.id,
    required this.modelId,
    required this.title,
    this.album,
    this.artist,
    this.genre,
    this.duration,
    this.artworkPath,
    this.artworkUrl,
    this.thumbnailPath,
    this.playable,
    this.displayTitle,
    this.displaySubtitle,
    this.displayDescription,
    required this.lastModified,
    this.videoId,
  });

  SongItem copyWith({
    String? id,
    String? modelId,
    String? title,
    String? album,
    String? artist,
    String? genre,
    Duration? duration,
    File? artworkPath,
    Uri? artworkUrl,
    File? thumbnailPath,
    bool? playable,
    String? displayTitle,
    String? displaySubtitle,
    String? displayDescription,
    DateTime? lastModified,
    ColorsPalette? palette,
    String? videoId,
  }) {
    return SongItem(
      id: id ?? this.id,
      modelId: modelId ?? this.modelId,
      title: title ?? this.title,
      album: album ?? this.album,
      artist: artist ?? this.artist,
      genre: genre ?? this.genre,
      duration: duration ?? this.duration,
      artworkPath: artworkPath ?? this.artworkPath,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      playable: playable ?? this.playable,
      displayTitle: displayTitle ?? this.displayTitle,
      displaySubtitle: displaySubtitle ?? this.displaySubtitle,
      displayDescription: displayDescription ?? this.displayDescription,
      lastModified: lastModified ?? this.lastModified,
      videoId: videoId ?? this.videoId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'modelId': modelId,
      'title': title,
      'album': album,
      'artist': artist,
      'genre': genre,
      'duration': duration?.inSeconds,
      'artworkUrl': artworkUrl?.toString(),
      'playable': playable,
      'displayTitle': displayTitle,
      'displaySubtitle': displaySubtitle,
      'displayDescription': displayDescription,
      'lastModified': lastModified.toString(),
      'videoId': videoId,
    };
  }

  factory SongItem.fromMap(Map<String, dynamic> map) {
    final path = map['id'] ?? '';
    return SongItem(
      id: map['id'] ?? '',
      modelId: map['modelId'] ?? '',
      title: map['title'] ?? '',
      album: map['album'],
      artist: map['artist'],
      genre: map['genre'],
      duration: map['duration'] != null ? Duration(seconds: map['duration']) : null,
      artworkPath: path != null ? artworkFile(path) : null,
      artworkUrl: map['artworkUrl'] != null ? Uri.parse(map['artworkUrl']) : null,
      thumbnailPath: path != null ? thumbnailFile(path) : null,
      playable: map['playable'],
      displayTitle: map['displayTitle'],
      displaySubtitle: map['displaySubtitle'],
      displayDescription: map['displayDescription'],
      lastModified: DateTime.parse(map['lastModified']),
      videoId: map['videoId'] != null ? map['videoId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SongItem.fromJson(String source) => SongItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SongItem(id: $id, modelId: $modelId, title: $title, album: $album, artist: $artist, genre: $genre, duration: $duration, artworkPath: $artworkPath, artworkUrl: $artworkUrl, thumbnailPath: $thumbnailPath, playable: $playable, displayTitle: $displayTitle, displaySubtitle: $displaySubtitle, displayDescription: $displayDescription, lastModified: $lastModified, videoId: $videoId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SongItem &&
      other.id == id &&
      other.modelId == modelId &&
      other.title == title &&
      other.album == album &&
      other.artist == artist &&
      other.genre == genre &&
      other.duration == duration &&
      other.artworkPath == artworkPath &&
      other.artworkUrl == artworkUrl &&
      other.thumbnailPath == thumbnailPath &&
      other.playable == playable &&
      other.displayTitle == displayTitle &&
      other.displaySubtitle == displaySubtitle &&
      other.displayDescription == displayDescription &&
      other.lastModified == lastModified &&
      other.videoId == videoId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      modelId.hashCode ^
      title.hashCode ^
      album.hashCode ^
      artist.hashCode ^
      genre.hashCode ^
      duration.hashCode ^
      artworkPath.hashCode ^
      artworkUrl.hashCode ^
      thumbnailPath.hashCode ^
      playable.hashCode ^
      displayTitle.hashCode ^
      displaySubtitle.hashCode ^
      displayDescription.hashCode ^
      lastModified.hashCode ^
      videoId.hashCode;
  }
}
