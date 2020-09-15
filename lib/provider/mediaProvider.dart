// Dart
import 'dart:io';
import 'dart:typed_data';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Internal
import 'package:songtube/internal/models/folder.dart';
import 'package:songtube/internal/models/songFile.dart';
import 'package:songtube/internal/models/videoFile.dart';

// Packages
import 'package:ext_storage/ext_storage.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaProvider extends ChangeNotifier {

  // Flutter Audio Query
  FlutterAudioQuery audioQuery;

  // List all Songs in Device
  List<SongFile> listSongs;

  // List MediaItems for AudioService
  List<MediaItem> listMediaItems;

  // List all Videos
  List<VideoFile> listVideos;

  // List Video Folders
  List<FolderItem> listFolders;

  // Do we have storage Permission?
  bool _storagePermission;
  bool get storagePermission => _storagePermission;
  set storagePermission(bool value) {
    _storagePermission = value;
    notifyListeners();
  }

  MediaProvider() {
    audioQuery = new FlutterAudioQuery();
    listSongs = new List<SongFile>();
    listMediaItems = new List<MediaItem>();
    listVideos = new List<VideoFile>();
    listFolders = new List<FolderItem>();
    storagePermission = true;
  }

  void loadSongList() async {
    var storageStatus = await Permission.storage.status;
    if (storageStatus != PermissionStatus.granted) {
      storagePermission = false;
      return;
    }
    List<SongInfo> songInfoList = await audioQuery.getSongs();
    for (SongInfo song in songInfoList) {
      File artworkFile = File((await getApplicationDocumentsDirectory()).path +
        "/${song.title.replaceAll("/", "_")}MQ.jpg");
      if (!await artworkFile.exists()) {
        Uint8List artwork = await audioQuery.getArtwork(
          type: ResourceType.SONG,
          id: song.id,
          size: Size(128,128)
        );
        if (artwork.isNotEmpty) {
          await artworkFile.writeAsBytes(artwork);
        } else {
          var bytes = await rootBundle.load('assets/images/artworkPlaceholder_small.png');
          await artworkFile.writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
        }
      }
      listSongs.add(
        SongFile(
          title:        song.title,
          album:        song.album,
          author:       song.artist,
          coverPath:    artworkFile.path,
          path:         song.filePath,
          fileSize:     song.fileSize,
          duration:     song.duration,
          id:           song.id,
          downloadType: null,
          coverUrl:     null,
        )
      );
      listMediaItems.add(
        MediaItem(
          id:       song.filePath,
          album:    song.album,
          title:    song.title,
          artist:   song.artist,
          duration: Duration(milliseconds: int.parse(song.duration)),
          artUri:   "file://${artworkFile.path}",
          extras:   { "albumId": song.id }
        )
      );
    }
    notifyListeners();
  }

  // Load list of Videos from device
  Future<void> loadVideoList() async {
    var storageStatus = await Permission.storage.status;
    if (storageStatus != PermissionStatus.granted) {
      storagePermission = false;
      return;
    }
    String extPath = await ExtStorage.getExternalStorageDirectory();
    Directory(extPath).list(recursive: true).map((file) => file.path)
      .where((item) =>
        // Scan for these Video files with these
        // specific video extensions
        item.endsWith(".mp4") ||
        item.endsWith(".mkv") ||
        item.endsWith(".mov") ||
        item.endsWith(".flv") ||
        item.endsWith(".avi") ||
        item.endsWith(".wmv") ||
        item.endsWith(".avi") ||
        item.endsWith(".webm")
      ).listen((event) {
        if (
          // Filters, do not process this video
          // if any of these matches
          !event.contains("/.") &&
          !event.contains("0/Android/") &&
          !RegExp(r'\d{6,}').hasMatch(event)
        ) {
          VideoFile videoItem = VideoFile(
            name: event.split("/").last,
            path: event,
            size: (File(event).lengthSync()).toString(),
            lastModified: FileStat.statSync(event).modified
          );
          listVideos.add(videoItem);
          if (listFolders.firstWhere((element) => element.path == dirname(videoItem.path), orElse: () => null) == null) {
            listFolders.add(FolderItem(
              name: dirname(videoItem.path).split("/").last,
              path: dirname(videoItem.path)
            ));
            listFolders.sort((a, b) => a.name.compareTo(b.name));
          }
          listFolders.forEach((element) {
            if (element.path == dirname(videoItem.path)) {
              element.videos.add(videoItem);
            }
          });
        }
      },
        onDone: () {
          // Order Alphabetically Videos on all FolderItems
          listFolders.forEach((element) {
            element.videos.sort((a,b) => a.name.compareTo(b.name));
          });
          notifyListeners();
        }
      );
  }
}