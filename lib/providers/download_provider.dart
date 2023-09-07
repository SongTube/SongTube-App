import 'dart:convert';
import 'dart:io';

import 'package:audio_tagger/audio_tagger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/internal/artwork_manager.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/colors_palette.dart';
import 'package:songtube/internal/models/download/download_info.dart';
import 'package:songtube/internal/models/download/download_item.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/providers/playlist_provider.dart';

class DownloadProvider extends ChangeNotifier {

  DownloadProvider() {
    fetchDownloads().then((value) {
      downloadedSongs = value;
      notifyListeners();
    });
  } 

  // Queued/Cancelled Downloads
  List<DownloadItem> queue = [];
  List<DownloadItem> canceled = [];

  // Downloaded List
  List<SongItem> downloadedSongs = [];

  // Max simultaneous downloads
  int maxSimultaneousDownloads = AppSettings.maxSimultaneousDownloads;

  // Refresh metadata of given song
  Future<void> refreshSong(String id) async {
    final index = downloadedSongs.indexWhere((element) => element.id == id);
    if (index == -1) {
      return;
    }
    final metadata = await AudioTagger.extractAllTags(id);
    if (metadata != null) {
      final palette = await PaletteGenerator.fromImageProvider(FileImage(thumbnailFile(id))); 
      final stats = await FileStat.stat(id);
      final SongItem oldSong = downloadedSongs[index];
      final SongItem newSong = SongItem(
        album: metadata.album,
        artist: metadata.artist,
        genre: metadata.genre,
        artworkPath: artworkFile(id),
        thumbnailPath: thumbnailFile(id),
        duration: oldSong.duration,
        id: id,
        videoId: oldSong.id,
        modelId: metadata.title,
        title: metadata.title,
        lastModified: stats.changed);
      newSong.palette = ColorsPalette(
        dominant: palette.dominantColor?.color,
        vibrant: palette.vibrantColor?.color,
      );
      downloadedSongs.removeAt(index);
      downloadedSongs.insert(index, newSong);
      // Save to cache
      final mapList = List<Map>.generate(downloadedSongs.length, (index) {
        return downloadedSongs[index].toMap();
      });
      sharedPreferences.setString('user-downloads', jsonEncode(mapList));
      notifyListeners();
    }
  }

  // Handle Single Video Download
  Future<void> handleDownloadItem({required DownloadInfo info}) async {
    queue.add(await DownloadItem.buildData(info: info)
      ..onDownloadCancelled = (id) {
        moveToCancelled(id);
      }
      ..onDownloadCompleted = (id, items) {
        for (final songItem in items) {
          handleNewDownload(song: songItem);
        }
        final index = queue.indexWhere((element) => element.id == id);
        // Create Music Playlist if enabled
        if (queue[index].downloadInfo.createMusicPlaylistFromSegments) {
          Provider.of<PlaylistProvider>(navigatorKey.currentState!.context, listen: false)
            .createGlobalPlaylist(queue[index].downloadInfo.name, songs: items);
        }
        queue.removeAt(index);
        notifyListeners();
        checkQueue();
      });
    checkQueue();
  }

  void checkQueue() {
    // Update simultaneous downloads size
    maxSimultaneousDownloads = AppSettings.maxSimultaneousDownloads;
    if (queue.isEmpty) return;
    final maxDownloads = queue.length <= maxSimultaneousDownloads
      ? queue.length : maxSimultaneousDownloads;
    for (int i = 0; i < maxDownloads; i++) {
      if (queue[i].downloadStatus.value == 'queued') {
        queue[i].initDownload();
      }
    }
    notifyListeners();
  }

  void moveToCancelled(String id) {
    int index = queue.indexWhere((element)
      => element.id == id);
    canceled.add(queue[index]);
    queue.removeAt(index);
    notifyListeners();
    checkQueue();
  }

  void retryDownload(String id) {
    final index = canceled.indexWhere((element)
      => element.id == id);
    canceled[index].resetStreams();
    queue.add(canceled[index]);
    canceled.removeAt(index);
    notifyListeners();
    checkQueue();
  }

  void cancelDownload(String id) async {
    final index = queue.indexWhere((element)
      => element.id == id);
    queue[index].canceled = true;
    canceled.add(queue[index]);
    queue.removeAt(index);
    notifyListeners();
    checkQueue();
  }

  void handleNewDownload({required SongItem song}) {
    // Update download songs list
    downloadedSongs.add(song);
    // Save song into sharedPreferences
    saveDownload(song);
    // Update MediaStore
    AudioTagger.updateMediaStore(song.id);
    // Save song into MediaProvider
    Provider.of<MediaProvider>(navigatorKey.currentState!.context, listen: false).insertSong(song);
  }

  // Fetch Downloaded Songs
  Future<List<SongItem>> fetchDownloads() async {
    final json = sharedPreferences.getString('user-downloads');
    if (json == null) {
      return [];
    } else {
      final List<SongItem> downloadList = [];
      final List<dynamic> mapList = jsonDecode(json);
      for (final element in mapList) {
        final item = SongItem.fromMap(element);
        if (await File(item.id).exists()) {
          downloadList.add(SongItem.fromMap(element));
        }
      }
      saveDownloads(downloadList);
      return downloadList;
    }
  }

  // Save song to downloads
  Future<void> saveDownload(SongItem song) async {
    final json = sharedPreferences.getString('user-downloads');
    final map = song.toMap();
    if (json == null) {
      List<dynamic> mapList = [map];
      sharedPreferences.setString('user-downloads', jsonEncode(mapList));
    } else {
      final List<dynamic> mapList = jsonDecode(json);
      mapList.add(map);
      await sharedPreferences.setString('user-downloads', jsonEncode(mapList));
    }
  }

  // Save list of songs to downloads
  Future<void> saveDownloads(List<SongItem> songs) async {
    final mapList = List.generate(songs.length , (index) {
      return songs[index].toMap();
    });
    final json = jsonEncode(mapList);
    await sharedPreferences.setString('user-downloads', json);
  }

  // Delete a Download
  Future<void> deleteDownload(SongItem item) async {
    try {
      await File(item.id).delete();
      downloadedSongs.removeWhere((element) => element.id == item.id);
      await saveDownloads(downloadedSongs);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

}