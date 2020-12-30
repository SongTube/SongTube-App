// Dart
import 'dart:io';
import 'package:http/http.dart' as http;

// Flutter
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:songtube/internal/database/databaseService.dart';
import 'package:songtube/internal/ffmpeg/extractor.dart';
import 'package:songtube/internal/lyricsProviders.dart';

// Internal
import 'package:songtube/internal/models/folder.dart';
import 'package:songtube/internal/models/songFile.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/internal/models/videoFile.dart';

// Packages
import 'package:ext_storage/ext_storage.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/internal/randomString.dart';
import 'package:songtube/internal/tagsManager.dart';
import 'package:string_validator/string_validator.dart';

class MediaProvider extends ChangeNotifier {

  MediaProvider() {
    audioQuery = new FlutterAudioQuery();
    listMediaItems = new List<MediaItem>();
    listVideos = new List<VideoFile>();
    listFolders = new List<FolderItem>();
    storagePermission = true;
    panelController = new PanelController();
    slidingPanelOpen = false;
    databaseSongs = new List<MediaItem>();
    getDatabase();
  }

  // Flutter Audio Query
  FlutterAudioQuery audioQuery;

  // List MediaItems for AudioService
  List<MediaItem> listMediaItems;

  // List Songs on Database
  List<MediaItem> databaseSongs;

  // List all Videos
  List<VideoFile> listVideos;

  // List Video Folders
  List<FolderItem> listFolders;

  // Panel Controller
  PanelController panelController;

  // SlidingPanel Open/Closed Status
  bool slidingPanelOpen;

  // Status for Music and Downloads
  bool loadingMusic = true;
  bool loadingDownloads = true;
  bool loadingVideos = true;

  // --------
  // Database
  // --------
  final dbHelper = DatabaseService.instance;
  Future<void> getDatabase() async {
    List<SongFile> tmp = await dbHelper.getDownloadList();
    databaseSongs = convertToMediaItem(tmp);
    loadingDownloads = false;
    notifyListeners();
  }

  // Convert any List<SongFile> to a List<MediaItem>
  List<MediaItem> convertToMediaItem(List<SongFile> songList) {
    List<MediaItem> list = [];
    songList.forEach((SongFile element) {
      int hours = 0;
      int minutes = 0;
      int micros;
      List<String> parts = element.duration.split(':');
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
      list.add(
        new MediaItem(
          id: element.path,
          title: element.title,
          album: element.album,
          artist: element.author,
          artUri: "file://${element.coverPath}",
          duration: duration,
          extras: {
            "downloadType": element.downloadType,
            "artwork": element.coverPath
          }
        )
      );
    });
    return list;
  }

  // Show Current Song Lyrics
  bool _showLyrics = false;
  bool get showLyrics => _showLyrics;
  set showLyrics(bool value) {
    _showLyrics = value;
    notifyListeners();
    if (value == true && currentLyrics == null)
      getLyrics();
  }
  var currentLyrics;

  void getLyrics() async {
    // First try use LyricsOvh
    currentLyrics = await LyricsProviders.lyricsOvh(
      author: mediaItem.artist,
      title: mediaItem.title
    );
    // Second try use HappiDev
    if (currentLyrics == "") {
      currentLyrics = await LyricsProviders.lyricsHappiDev(
        title: mediaItem.artist + mediaItem.title
      );
    }
    notifyListeners();
  }

  // MusicPlayer Current Values
  MediaItem _mediaItem;
  File artwork;
  Color dominantColor;
  Color vibrantColor;

  MediaItem get mediaItem => _mediaItem;
  set mediaItem(MediaItem newMediaItem) {
    _mediaItem = newMediaItem;
    currentLyrics = null;    
    updateUIElements();
  }

  Future<void> updateUIElements() async {
    if (AudioService.currentMediaItem == null) return;
    String currentAlbumId = await AudioService.currentMediaItem.extras["albumId"];
    artwork = await FFmpegExtractor.getAudioArtwork(
      audioFile: mediaItem.id,
      audioId: currentAlbumId,
    );
    PaletteGenerator palette = await PaletteGenerator
      .fromImageProvider(
        FileImage(File(AudioService.currentMediaItem.artUri
          .replaceAll("file://", ""))));
    dominantColor = palette.dominantColor.color;
    if (palette.vibrantColor == null) {
      vibrantColor = dominantColor;
    } else { vibrantColor = palette.vibrantColor.color; }
    showLyrics = false;
    notifyListeners();
    // Preload Previous and Next Artwork
    List<int> indexes = [
      // Previous
      AudioService.queue.indexOf(AudioService.currentMediaItem)-1,
      // Next
      AudioService.queue.indexOf(AudioService.currentMediaItem)+1,
    ];
    FFmpegExtractor.getAudioArtwork(
      audioFile: AudioService.queue[indexes[0]].id,
      audioId: AudioService.queue[indexes[0]].extras["albumId"],
    );
    FFmpegExtractor.getAudioArtwork(
      audioFile: AudioService.queue[indexes[1]].id,
      audioId: AudioService.queue[indexes[1]].extras["albumId"],
    );
  }

  // Do we have storage Permission?
  bool _storagePermission;
  bool get storagePermission => _storagePermission;
  set storagePermission(bool value) {
    _storagePermission = value;
    notifyListeners();
  }

  void loadSongList() async {
    var storageStatus = await Permission.storage.status;
    if (storageStatus != PermissionStatus.granted) {
      storagePermission = false;
      return;
    }
    List<SongInfo> songInfoList = await audioQuery.getSongs();
    for (SongInfo song in songInfoList) {
      File artworkFile = await FFmpegExtractor.getAudioThumbnail(
        audioFile: song.filePath,
        audioId: song.id
      );
      // Avoid this Method from stopping this function on
      // exception (Most probably because a corrupted audio)
      try {
        listMediaItems.add(
          MediaItem(
            id:       song.filePath,
            album:    song.album,
            title:    song.title,
            artist:   song.artist,
            duration: Duration(milliseconds: int.parse(song.duration)),
            artUri:   "file://${artworkFile.path}",
            extras:   {
              "albumId": song.id,
              "artwork": artworkFile.path
            }
          )
        );
      } catch (_) {}
    }
    loadingMusic = false;
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
          loadingVideos = false;
          notifyListeners();
        }
      );
  }

  Future<void> deleteSong(MediaItem song) async {
    await File(song.id).delete();
    NativeMethod.registerFile(song.id);
    if (databaseSongs.contains(song)) {
      databaseSongs.removeWhere((element) => element == song);
    }
    if (listMediaItems.contains(song)) {
      listMediaItems.removeWhere((element) => element == song);
    }
    notifyListeners();
  }

  void setState() {
    notifyListeners();
  }

  Future<void> replaceTags(MediaItem song, TagsControllers tags) async {
    await TagsManager.writeAllTags(
      songPath: song.id,
      title: tags.titleController.text,
      album: tags.albumController.text,
      artist: tags.artistController.text,
      genre: tags.genreController.text,
      year: tags.dateController.text,
      disc: tags.discController.text,
      track: tags.trackController.text
    );
    // Only add Artwork if song is in AAC Format
    File croppedImage;
    if (isURL(tags.artworkController)) {
      http.Response response;
      File artwork = new File(
        (await getTemporaryDirectory()).path +
        "/${RandomString.getRandomString(5)}"
      );
      try {
        response = await http.get(tags.artworkController)
          .timeout(Duration(seconds: 30));
        await artwork.writeAsBytes(response.bodyBytes);
      } catch (_) {}
      croppedImage = await NativeMethod.cropToSquare(artwork);
    } else {
      croppedImage = await NativeMethod
        .cropToSquare(File(tags.artworkController));
    }
    await TagsManager.writeArtwork(
      songPath: song.id,
      artworkPath: croppedImage.path
    );
    // Create New Artwork
    await FFmpegExtractor.getAudioArtwork(
      audioFile: song.id,
      audioId: song.extras["albumId"],
      forceExtraction: true
    );
    File thumbnail = await FFmpegExtractor.getAudioThumbnail(
      audioFile: song.id,
      audioId: song.extras["albumId"],
      forceExtraction: true
    );
    MediaItem newSong = MediaItem(
      id: song.id,
      title: tags.titleController.text,
      album: tags.albumController.text,
      artist: tags.artistController.text,
      genre: tags.genreController.text,
      duration: song.duration,
      artUri: "file://" + thumbnail.path,
      extras: {
        "artwork": thumbnail.path,
        "albumId": song.extras["albumId"]
      }
    );
    if (databaseSongs.contains(song)) {
      int index = databaseSongs.indexWhere((element) => element == song);
      databaseSongs.removeAt(index);
      databaseSongs.insert(index, newSong);
    }
    if (listMediaItems.contains(song)) {
      int index = listMediaItems.indexWhere((element) => element == song);
      listMediaItems.removeAt(index);
      listMediaItems.insert(index, newSong);
    }
    imageCache.clear();
    imageCache.clearLiveImages();
    notifyListeners();
  }

}