import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:songtube/internal/models/songFile.dart';

class MediaProvider extends ChangeNotifier {

  // Flutter Audio Query
  FlutterAudioQuery audioQuery;

  // List all Songs in Device
  List<SongFile> listSongs;

  // List MediaItems for AudioService
  List<MediaItem> listMediaItems;

  MediaProvider() {
    audioQuery = new FlutterAudioQuery();
    listSongs = new List<SongFile>();
    listMediaItems = new List<MediaItem>();
    loadSongList();
  }

  void loadSongList() async {
    List<SongInfo> songInfoList = await audioQuery.getSongs();
    for (SongInfo song in songInfoList) {
      File artworkFile = File((await getApplicationDocumentsDirectory()).path +
        "/${song.album.replaceAll("/", "_")}.jpg");
      if (!await artworkFile.exists()) {
        Uint8List artwork = await audioQuery.getArtwork(
          type: ResourceType.SONG,
          id: song.id
        );
        if (artwork.isNotEmpty) {
          await artworkFile.writeAsBytes(artwork);
        } else {
          var bytes = await rootBundle.load('assets/images/songPlaceholder.png');
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
          id:           null,
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
        )
      );
    }
    notifyListeners();
  }

}