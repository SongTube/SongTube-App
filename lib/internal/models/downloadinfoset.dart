// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/internal/database/infoset_database.dart';
import 'package:songtube/internal/models/songFile.dart';

// Internal Models
import 'package:songtube/internal/models/metadata.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/internal/randomString.dart';
import 'package:songtube/internal/tagsManager.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

enum DownloadType { AUDIO, VIDEO }

class DownloadInfoSet {

  // Streams
  BehaviorSubject<String> currentAction;
  BehaviorSubject dataProgress;
  BehaviorSubject progressBar;

  // Classes
  MediaMetaData metadata;
  StreamInfo audioStreamInfo;
  StreamInfo videoStreamInfo;
  Video videoDetails;
  Converter converter;

  // Variables
  String downloadPath;
  DownloadType downloadType;
  AudioConvert convertFormat;
  List audioModifiers;
  bool downloaderClosed;
  bool _cancelDownload;
  bool get cancelDownload => _cancelDownload;
  set cancelDownload(bool value) {
    _cancelDownload = value;
    if (value == true) { 
      currentAction.add("Cancelled");
      dataProgress.add("Incompleted");
      progressBar.add(0.0);
    }
  }

  DownloadInfoSet({
    @required this.metadata,
    @required this.downloadType,
    @required this.convertFormat,
    @required this.downloadPath,
    @required this.audioModifiers,
    @required this.audioStreamInfo,
    @required this.videoDetails,
    this.videoStreamInfo
  }) {
    converter = new Converter();
    currentAction = new BehaviorSubject();
    dataProgress = new BehaviorSubject();
    progressBar = new BehaviorSubject();
    cancelDownload = false;
  }
  
  // ---------------------------------------------
  // Initialize this Media Download, automatically
  // Download, Convert, Write Metadata and Save
  // ---------------------------------------------
  Future<void> downloadMedia() async {
    var status = await Permission.storage.request();
    if (status != PermissionStatus.granted) {
      cancelDownload = true;
      currentAction.add("Access Denied");
      dataProgress.add("Can't Download");
      progressBar.add(0.0);
      return;
    }
    currentAction.add("Downloading...");
    currentAction.add(" ");
    // Check our Download Folder
    if (!await Directory(downloadPath).exists()) {
      await Directory(downloadPath).create();
    }
    // Download File
    File downloadedFile = await downloadStream();
    if (downloadedFile == null) return;
    // Rename File
    downloadedFile = await renameFile(downloadedFile, metadata.title);
    // Write All Metadata if its Audio
    if (downloadType == DownloadType.AUDIO) {
      currentAction.add("Writting Tags & Artwork...");
      await writeAllMetadata(downloadedFile.path);
    }
    // Move file to its Predefined Directory
    Permission.storage.request().then((value) async {
      if (value == PermissionStatus.granted) {
        if (!await Directory(downloadPath).exists()) {
          await Directory(downloadPath).create(recursive: true);
        }
        String fileName = downloadedFile.path.split("/").last;
        File finalFile = await downloadedFile.copy("$downloadPath/$fileName");
        await finishDownload(finalFile);
      }
    });
  }

  Future<void> finishDownload(File finalFile) async {
    final dbHelper = DatabaseService.instance;
    await dbHelper.insertDownload(new SongFile.toDatabase(
      title: metadata.title,
      album: metadata.album,
      author: metadata.artist,
      duration: videoDetails.duration.toString(),
      downloadType: downloadType == DownloadType.AUDIO
        ? "Audio"
        : "Video",
      fileSize: ((await finalFile.length()) * 0.000001).toStringAsFixed(2),
      coverUrl: metadata.coverurl,
      path: finalFile.path
    ));
    currentAction.add("Completed");
    progressBar.add(1.0);
    downloaderClosed = true;
    NativeMethod.registerFile(finalFile.path);
    currentAction.close();
    progressBar.close();
    dataProgress.close();
  }

  Future<File> downloadStream() async { 

    // Download
    File file = File((await getTemporaryDirectory()).path + "/" + RandomString.getRandomString(10));

    // StreamData
    YoutubeExplode yt = new YoutubeExplode();
    Stream<List<int>> streamData;
    if (videoStreamInfo == null) {
      streamData = yt.videos.streamsClient.get(audioStreamInfo);
      currentAction.add("Downloading Audio...");
    } else {
      streamData = yt.videos.streamsClient.get(videoStreamInfo);
      currentAction.add("Downloading Video...");
    }

    // Update Streams
    dataProgress.add("Starting...");
    progressBar.add(0.0);

    // Open the file in write.
    var _output = file.openWrite(mode: FileMode.write);

    // Local variables for file status
    var _count = 0;
    var _len;
    if (videoStreamInfo == null) {
      _len = audioStreamInfo.size.totalBytes;
    } else {
      _len = videoStreamInfo.size.totalBytes + audioStreamInfo.size.totalBytes;
    }

    // Start stream download, also update internal public
    // BehaviorSubject for external access
    await for (var data in streamData) {
      if (cancelDownload == true) {
        _output.close(); return null;
      }
      _count += data.length;
      dataProgress.add("${(_count * 0.000001).toStringAsFixed(2)} MB / ${(_len * 0.000001).toStringAsFixed(2)} MB");
      progressBar.add((_count / _len).toDouble());
      print("Downloading: " + _count.toString());
      _output.add(data);
    }
    await _output.flush();
    await _output.close();
    // Download and Paste Audio if the Previous Download was a Video
    if (downloadType == DownloadType.VIDEO) {
      _count = 0;
      currentAction.add("Downloading Audio...");
      File audioFile = File((await getTemporaryDirectory()).path + "/" + RandomString.getRandomString(10));
      var _outputAudio = audioFile.openWrite(mode: FileMode.write);
      Stream<List<int>> audioStreamData = yt.videos.streamsClient.get(audioStreamInfo);
      await for (var data in audioStreamData) {
        if (cancelDownload == true) {
          _outputAudio.close(); return null;
        }
        _count += data.length;
        dataProgress.add(
          "${((_count + videoStreamInfo.size.totalBytes) * 0.000001).toStringAsFixed(2)} MB" +
          " / ${(_len * 0.000001).toStringAsFixed(2)} MB"
        );
        progressBar.add(((_count + videoStreamInfo.size.totalBytes)/_len).toDouble());
        print("Downloading: " + _count.toString());
        _outputAudio.add(data);
      }
      await _outputAudio.flush();
      await _outputAudio.close();
      progressBar.add(null);
      currentAction.add("Patching Audio...");
      File finalFile = await converter.writeAudioToVideo(
        saveFormat: await converter.getMediaFormat(file.path),
        videoPath: file.path,
        audioPath: audioFile.path,
      );
      if (finalFile != null) file = finalFile;
    }
    // Convert Audio if enabled to Requested Format
    if (downloadType == DownloadType.AUDIO) {
      if (convertFormat != AudioConvert.NONE) {
        progressBar.add(null);
        currentAction.add("Converting...");
        File finalFile = await converter.convertAudio(
          audioPath: file.path,
          format: convertFormat,
          filters: audioModifiers
        );
        if (finalFile != null) file = finalFile;
      }
    }
    return file;
  }

  // Write Tags & Artwork
  Future<void> writeAllMetadata(String filePath) async {
    try {
      await TagsManager.writeAllTags(
        songPath: filePath,
        title: metadata.title,
        album: metadata.album,
        artist: metadata.artist,
        genre: metadata.genre,
        year: metadata.date,
        disc: metadata.disk,
        track: metadata.track
      );
      var response;
      File artwork = new File((await getTemporaryDirectory()).path +
        "/${RandomString.getRandomString(5)}");
      try {
        response = await http.get(videoDetails.thumbnails.maxResUrl);
        await artwork.writeAsBytes(response.bodyBytes);
      } catch (_) {
        response = await http.get(videoDetails.thumbnails.mediumResUrl);
        await artwork.writeAsBytes(response.bodyBytes);
      }
      // Crop Image before writting it to the Song
      File croppedImage = await NativeMethod.cropToSquare(artwork);
      await TagsManager.writeArtwork(
        songPath: filePath,
        artworkPath: croppedImage.path
      );
      // Copy our CoverArt to default folder
      await croppedImage.copy((await getApplicationDocumentsDirectory()).path +
        "${metadata.title}.jpg");
    } on Exception catch (e) {
      print(e);
    }
  }

  // Rename File to a new provided FileName this function
  // preserves the file path and file extension.
  Future<File> renameFile(File file, String newName) async {
    String filePath = file.path
      .replaceAll("/${file.path.split('/').last}", '');
    String fileFormat = file.path.split('.').last;
    return await file.rename("$filePath/$newName.$fileFormat");
  }

}