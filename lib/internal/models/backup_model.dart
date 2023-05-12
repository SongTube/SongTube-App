// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:pick_or_save/pick_or_save.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/cache_utils.dart';

import 'package:songtube/internal/models/channel_subscription.dart';
import 'package:songtube/internal/models/media_playlist.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/download_provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/providers/playlist_provider.dart';

class BackupModel {

  // Favorite Videos
  final List<StreamInfoItem> favorites;

  // Watch History
  final List<StreamInfoItem> watchHistory;

  // Playlists
  final List<YoutubePlaylist> playlists;

  // Subscriptions
  final List<ChannelSubscription> subscriptions;

  // Downloads
  final List<SongItem> downloads;

  // Music Playlists
  final List<MediaPlaylist> musicPlaylists;
  BackupModel({
    required this.favorites,
    required this.watchHistory,
    required this.playlists,
    required this.subscriptions,
    required this.downloads,
    required this.musicPlaylists,
  });

  /// Generate a backup json [File]
  static Future<File?> generateBackup(BuildContext context) async {
    final contentProvider = Provider.of<ContentProvider>(context, listen: false);
    final downloadProvider = Provider.of<DownloadProvider>(context, listen: false);
    final playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    final backup = BackupModel(
      favorites: contentProvider.favoriteVideos,
      watchHistory: CacheUtils.watchHistory,
      playlists: contentProvider.streamPlaylists,
      subscriptions: contentProvider.channelSubscriptions,
      downloads: downloadProvider.downloadedSongs,
      musicPlaylists: playlistProvider.globalPlaylists,
    ).toJson();
    String fileName = 'songtube_backup-${DateTime.now().toString()}.json';
    final result = await PickOrSave().fileSaver(params: FileSaverParams(
      saveFiles: [
        SaveFileInfo(
          fileData: Uint8List.fromList(utf8.encode(backup)),
          fileName: fileName,
        )
      ],
      mimeTypesFilter: [
        'application/json',
        'charset=utf-8'
      ],
    ));
    if (result != null) {
      return File(result.first);
    } else {
      return null;
    }
  }

  /// Returns [false] in an error occurred while restoring backup
  static Future<bool> restoreBackup(BuildContext context) async {
    try {
      // Fetch backup data
      final path = await PickOrSave().filePicker(params: FilePickerParams(
        mimeTypesFilter: [
          'application/json',
        ],
      ));
      if (path != null) {
        final json = await File(path.first).readAsString();
        final BackupModel backup = BackupModel.fromJson(json);
        // Restore data
        // ignore: use_build_context_synchronously
        final contentProvider = Provider.of<ContentProvider>(context, listen: false);
        contentProvider.favoriteVideos = backup.favorites;
        contentProvider.streamPlaylists = backup.playlists;
        contentProvider.channelSubscriptions = backup.subscriptions;
        CacheUtils.watchHistory = backup.watchHistory;
        // ignore: use_build_context_synchronously
        final playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
        playlistProvider.globalPlaylists = backup.musicPlaylists;
        // ignore: use_build_context_synchronously
        final downloadProvider = Provider.of<DownloadProvider>(context, listen: false);
        downloadProvider.saveDownloads(backup.downloads);
        downloadProvider.downloadedSongs = backup.downloads;
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  BackupModel copyWith({
    List<StreamInfoItem>? favorites,
    List<StreamInfoItem>? watchHistory,
    List<YoutubePlaylist>? playlists,
    List<ChannelSubscription>? subscriptions,
    List<SongItem>? downloads,
    List<MediaPlaylist>? musicPlaylists,
  }) {
    return BackupModel(
      favorites: favorites ?? this.favorites,
      watchHistory: watchHistory ?? this.watchHistory,
      playlists: playlists ?? this.playlists,
      subscriptions: subscriptions ?? this.subscriptions,
      downloads: downloads ?? this.downloads,
      musicPlaylists: musicPlaylists ?? this.musicPlaylists,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'favorites': favorites.map((x) => x.toMap()).toList(),
      'watchHistory': watchHistory.map((x) => x.toMap()).toList(),
      'playlists': playlists.map((x) => x.toMap()).toList(),
      'subscriptions': subscriptions.map((x) => x.toMap()).toList(),
      'downloads': downloads.map((x) => x.toMap()).toList(),
      'musicPlaylists': musicPlaylists.map((x) => x.toMap()).toList(),
    };
  }

  factory BackupModel.fromMap(Map<String, dynamic> map) {
    return BackupModel(
      favorites: List<StreamInfoItem>.from((map['favorites'] as List<dynamic>).map<StreamInfoItem>((x) => StreamInfoItem.fromMap(x as Map<String,dynamic>),),),
      watchHistory: List<StreamInfoItem>.from((map['watchHistory'] as List<dynamic>).map<StreamInfoItem>((x) => StreamInfoItem.fromMap(x as Map<String,dynamic>),),),
      playlists: List<YoutubePlaylist>.from((map['playlists'] as List<dynamic>).map<YoutubePlaylist>((x) => YoutubePlaylist.fromMap(x as Map<String,dynamic>),),),
      subscriptions: List<ChannelSubscription>.from((map['subscriptions'] as List<dynamic>).map<ChannelSubscription>((x) => ChannelSubscription.fromMap(x as Map<String,dynamic>),),),
      downloads: List<SongItem>.from((map['downloads'] as List<dynamic>).map<SongItem>((x) => SongItem.fromMap(x as Map<String,dynamic>),),),
      musicPlaylists: List<MediaPlaylist>.from((map['musicPlaylists'] as List<dynamic>).map<MediaPlaylist>((x) => MediaPlaylist.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory BackupModel.fromJson(String source) => BackupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BackupModel(favorites: $favorites, watchHistory: $watchHistory, playlists: $playlists, subscriptions: $subscriptions, downloads: $downloads, musicPlaylists: $musicPlaylists)';
  }

  @override
  bool operator ==(covariant BackupModel other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.favorites, favorites) &&
      listEquals(other.watchHistory, watchHistory) &&
      listEquals(other.playlists, playlists) &&
      listEquals(other.subscriptions, subscriptions) &&
      listEquals(other.downloads, downloads) &&
      listEquals(other.musicPlaylists, musicPlaylists);
  }

  @override
  int get hashCode {
    return favorites.hashCode ^
      watchHistory.hashCode ^
      playlists.hashCode ^
      subscriptions.hashCode ^
      downloads.hashCode ^
      musicPlaylists.hashCode;
  }
}
