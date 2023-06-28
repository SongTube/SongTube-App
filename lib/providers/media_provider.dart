import 'dart:async';
import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:audio_tagger/audio_tagger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:songtube/internal/artwork_manager.dart';
import 'package:songtube/internal/cache_utils.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/media_utils.dart';
import 'package:songtube/internal/models/colors_palette.dart';
import 'package:songtube/internal/models/song_item.dart';

class MediaProvider extends ChangeNotifier {

  MediaProvider() {
    songs = MediaUtils.fetchCachedSongsAsSongItems();
    // Check for permissions
    fetchMedia();
  }

  // Status for Storage Permission
  PermissionStatus? permissionStatus;

  // Status for the fetchMedia function
  bool fetchMediaRunning = false;

  // Refresh metadata of given song
  Future<void> refreshSong(String id) async {
    final index = songs.indexWhere((element) => element.id == id);
    if (index == -1) {
      return;
    }
    final metadata = await AudioTagger.extractAllTags(id);
    if (metadata != null) {
      final palette = await PaletteGenerator.fromImageProvider(FileImage(thumbnailFile(id))); 
      final stats = await FileStat.stat(id);
      final SongItem oldSong = songs[index];
      final SongItem newSong = SongItem(
        album: metadata.album,
        artist: metadata.artist,
        genre: metadata.genre,
        artworkPath: artworkFile(id),
        thumbnailPath: thumbnailFile(id),
        duration: oldSong.duration,
        id: id,
        modelId: metadata.title,
        title: metadata.title,
        palette: ColorsPalette(
          dominant: palette.dominantColor?.color,
          vibrant: palette.vibrantColor?.color,
        ),
        lastModified: stats.changed);
      _songs.removeAt(index);
      _songs.insert(index, newSong);
      // Save to cache
      CacheUtils.cacheSongs = _songs;
      notifyListeners();
    }
  }

  // Fetch Songs for this Provider
  Future<void> fetchMedia() async {
    permissionStatus = await Permission.storage.status;
    if (permissionStatus == PermissionStatus.granted) {
      if (kDebugMode) {
        print('Fetching device Media...');
      }
      fetchMediaRunning = true;
      notifyListeners();
      Timer timer = Timer.periodic(const Duration(seconds: 5), (_) {
        notifyListeners();
      });
      await MediaUtils.fetchDeviceSongs((newSong) {
        songs.add(newSong);
      });
      fetchMediaRunning = false;
      timer.cancel();
      notifyListeners();
    }
  }

  // Current Playlist Name
  String? _currentPlaylistName;
  String? get currentPlaylistName => _currentPlaylistName;
  set currentPlaylistName(String? name) {
    _currentPlaylistName = name;
    notifyListeners();
  }

  // User Songs
  List<SongItem> _songs = [];
  List<SongItem> get songs {
    final list = _songs.unique((element) => element.id)..sort(((a, b) => a.title.compareTo(b.title)));
    list.removeWhere((element) => element.id.contains('Android/media') || element.id.contains('Android/data') || element.id.contains('.mp4') || element.id.contains('.webm'));
    return list;
  }
  set songs(List<SongItem> items) {
    _songs = items;
    notifyListeners();
  }

  // Save song to our current list and cache
  void insertSong(SongItem song) {
    songs = songs..add(song)..unique((element) => element.id);
    CacheUtils.cacheSongs = songs;
  }

  Future<void> playSong(List<MediaItem> queue, int index) async {
    if (listEquals(queue, audioHandler.queue.value) == false) {
      await audioHandler.updateQueue(queue);
    }
    await audioHandler.skipToQueueItem(index);
  }

  // -------------------
  // Downloader Section
  // -------------------
  

}