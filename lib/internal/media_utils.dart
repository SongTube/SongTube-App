import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:audio_tagger/audio_tagger.dart' as tagger;
import 'package:audio_tagger/audio_tags.dart' as tags;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:http/http.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:songtube/internal/artwork_manager.dart';
import 'package:songtube/internal/cache_utils.dart';
import 'package:songtube/internal/enums/download_type.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/audio_tags.dart';
import 'package:songtube/internal/models/colors_palette.dart';
import 'package:songtube/internal/models/download/download_info.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:validators/validators.dart';

class MediaUtils {

  // Apply Tags and Metadata to a Song
  static Future<String?> writeMetadata(String path, AudioTags userTags) async {
      // Create a temporal file from the original one
      final tmp = await File(path).copy("${(await getExternalStorageDirectory())!.path}/${path.split('/').last}");
      // Check if audio file is AAC format TODO
      // Apply all Tags
      await tagger.AudioTagger.writeAllTags(
        songPath: tmp.path,
        tags: tags.AudioTags(
          title: userTags.titleController.text,
          album: userTags.albumController.text,
          artist: userTags.artistController.text,
          genre: userTags.genreController.text,
          year: userTags.dateController.text,
          disc: userTags.discController.text,
          track: userTags.trackController.text
        )
      );
      // Apply Artwork if non null
      if (userTags.artwork != null) {
        File image = File("${(await getExternalStorageDirectory())!.path}/${MediaUtils.getRandomString(5)}");
        if (userTags.artwork is File || (userTags.artwork is String && !isURL(userTags.artwork))) {
          final bytes = await tagger.AudioTagger.cropToSquare(userTags.artwork is File ? userTags.artwork : File(userTags.artwork));
          if (bytes != null) {
            image.writeAsBytes(bytes.toList());
          }
        } else if (userTags.artwork is Uint8List) {
          image.writeAsBytes(userTags.artwork);
        } else if (userTags.artwork is String && isURL(userTags.artwork)) {
          final response = await get(Uri.parse(userTags.artwork));
          image.writeAsBytes(response.bodyBytes);
        }
        if (await image.exists()) {
          await ArtworkManager.writeArtwork(tmp.path, artwork: image, forceRefresh: true, embedToSong: true);
          await ArtworkManager.writeThumbnail(tmp.path, artwork: image, forceRefresh: true);
          // Delete the original file and copy the new (modified) one
          await File(path).delete();
          await tmp.copy(path);
          // Delete temporal file
          await tmp.delete();
          // Clear images cache
          imageCache.clear();
          imageCache.clearLiveImages();
        }
      }
    return null;
  }

  static Future<void> fetchDeviceSongs(Function(SongItem) onUpdateTrigger) async {
    // New songs found on device
    List<SongInfo> userSongs = await FlutterAudioQuery()
      .getSongs(sortType: SongSortType.DISPLAY_NAME);
    // Cached Songs
    List<MediaItem> cachedSongs = fetchCachedSongsAsMediaItems();
    // Filter out non needed songs from this process
    // ignore: avoid_function_literals_in_foreach_calls
    cachedSongs.forEach((item) {
      if (userSongs.any((element) => element.filePath == item.id)) {
        userSongs.removeWhere((element) => element.filePath == item.id);
      }
    });
    // Build Thumbnails
    Stopwatch thumbnailsStopwatch = Stopwatch()..start();
    for (final song in userSongs) {
      await ArtworkManager.writeThumbnail(song.filePath!);
    }
    thumbnailsStopwatch.stop();
    if (kDebugMode) {
      print('Thumbnails spent a total of ${thumbnailsStopwatch.elapsed.inSeconds}s');
    }
    final List<SongItem> songs = [];
    for (final element in userSongs) {
      try {
        final song = await MediaUtils.convertToSongItem(element);
        songs.add(song);
        onUpdateTrigger(song);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    CacheUtils.cacheSongs = fetchCachedSongsAsSongItems()..addAll(songs);
  }

  static MediaItem fromMap(Map<String, dynamic> map) {
    return MediaItem(
      id: map['id'],
      title: map['title'],
      album: map['album'],
      artist: map['artist'],
      genre: map['genre'],
      duration: Duration(milliseconds: int.parse(map['duration'])),
      artUri: Uri.parse(map['artUri']),
      displayTitle: map['displayTitle'],
      displaySubtitle: map['displaySubtitle'],
      displayDescription: map['displayDescription'],
      extras: {
        'lastModified': map['lastModified'] == ''
          ? null : map['lastModified']
      }
    );
  }

  static Map<String, dynamic> toMap(MediaItem item) {
    return {
      'id': item.id,
      'title': item.title,
      'album': item.album,
      'artist': item.artist,
      'genre': item.genre,
      'duration': item.duration!.inMilliseconds.toString(),
      'artUri': item.artUri.toString(),
      'displayTitle': item.displayTitle,
      'displaySubtitle': item.displaySubtitle,
      'displayDescription': item.displayDescription,
      'lastModified': item.extras?['lastModified'] ?? ''
    };
  } 

  static List<MediaItem> fromMapList(List<dynamic> list) {
    return List<MediaItem>.generate(list.length, (index) {
      return fromMap(list[index]);
    });
  }

  static List<Map<String, dynamic>> toMapList(List<MediaItem> list) {
    return List<Map<String, dynamic>>.generate(list.length, (index) {
      return toMap(list[index]);
    });
  }

  // Convert any List<SongFile> to a List<MediaItem>
  static Future<SongItem> convertToSongItem(SongInfo element) async {
    int hours = 0;
    int minutes = 0;
    int? micros;
    List<String> parts = element.duration!.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    Duration duration = Duration(
      milliseconds: Duration(
        hours: hours, 
        minutes: minutes,
        microseconds: micros
      ).inMilliseconds
    );
    FileStat stats = await FileStat.stat(element.filePath!);
    PaletteGenerator palette;
    try {
      palette = await PaletteGenerator.fromImageProvider(FileImage(thumbnailFile(element.filePath!)));
    } catch (e) {
      await ArtworkManager.writeDefaultThumbnail(element.filePath!);
      palette = await PaletteGenerator.fromImageProvider(FileImage(thumbnailFile(element.filePath!)));
    }
    return SongItem(
      id: element.filePath!,
      modelId: element.id,
      title: element.title!,
      album: element.album,
      artist: element.artist,
      artworkPath: artworkFile(element.filePath!),
      thumbnailPath: thumbnailFile(element.filePath!),
      duration: duration,
      lastModified: stats.changed,
      palette: ColorsPalette(
        dominant: palette.dominantColor?.color,
        vibrant: palette.vibrantColor?.color,
      )
    );
  }

  static Future<SongItem> downloadToSongItem(DownloadInfo info, String path) async {
    Duration duration = Duration(
      seconds: info.duration
    );
    FileStat stats = await FileStat.stat(path);
    PaletteGenerator? palette;
    if (info.downloadType == DownloadType.audio) { 
    await ArtworkManager.writeThumbnail(path);
      try {
        palette = await PaletteGenerator.fromImageProvider(FileImage(thumbnailFile(path)));
      } catch (e) {
        await ArtworkManager.writeDefaultThumbnail(path);
        palette = await PaletteGenerator.fromImageProvider(FileImage(thumbnailFile(path)));
      }
    }
    return SongItem(
      id: path,
      modelId: info.tags.titleController.text,
      title: info.tags.titleController.text,
      album: info.tags.albumController.text,
      artist: info.tags.artistController.text,
      artworkPath: artworkFile(path),
      artworkUrl: info.tags.artwork is String
        ? Uri.parse(info.tags.artwork) : null,
      thumbnailPath: thumbnailFile(path),
      duration: duration,
      lastModified: stats.changed,
      videoId: info.url,
      palette: palette != null ? ColorsPalette(
        dominant: palette.dominantColor?.color,
        vibrant: palette.vibrantColor?.color,
      ) : null
    );
  }

  static List<SongItem> fetchCachedSongsAsSongItems() {
    final songString = sharedPreferences.getString('deviceSongs');
    if (songString != null) {
      final List<dynamic> songsMap = jsonDecode(songString);
      final songs = List<SongItem>.generate(songsMap.length, (index) {
        return SongItem.fromMap(songsMap[index]);
      });
      return songs;
    } else {
      return [];
    }
  }

  static List<MediaItem> fetchCachedSongsAsMediaItems() {
    final items = fetchCachedSongsAsSongItems();
    return List<MediaItem>.generate(items.length, (index) => items[index].mediaItem);
  }

  static String removeToxicSymbols(String string) {
    return string
      .replaceAll('Container.', '')
      .replaceAll(r'\', '')
      .replaceAll('/', '')
      .replaceAll('*', '')
      .replaceAll('?', '')
      .replaceAll('"', '')
      .replaceAll('<', '')
      .replaceAll('>', '')
      .replaceAll('|', '')
      .replaceAll(':', '')
      .replaceAll('!', '')
      .replaceAll('[', '')
      .replaceAll(']', '')
      .replaceAll('¡', '');
  }

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static const _letters = 'qwertyuiopasdfghjlcvbnm';
  static String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(Random().nextInt(_chars.length))));
  static String getRandomLetter() => String.fromCharCodes(Iterable.generate(
    1, (_) => _letters
    .codeUnitAt(Random().nextInt(_letters.length))
  ));

  static Future<int?> getContentSize(String url, {int? timeout}) async {
    try {
      var response = await head(Uri.parse(url), headers: const {}).timeout(Duration(seconds: timeout ?? 3));
      final size = int.tryParse(response.headers['content-length']!);
      return size;
    } catch (_) {}
    return null;
  }
  
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}