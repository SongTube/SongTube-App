import 'dart:async';
import 'dart:io';
import 'package:ext_storage/ext_storage.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'native.dart';

Downloader downloader;
AppStreams appdata;
Converter converter;

enum FFmpegArgs { argsToACC }

class Converter {
  
  // Declare our FFmpeg instances
  final FlutterFFmpeg flutterFFmpeg = new FlutterFFmpeg();
  final FlutterFFprobe flutterFFprobe = new FlutterFFprobe();
  
  // Get the data we need before declaring our Argument lists
  Future<List<String>> getArgumentsList(FFmpegArgs type, MediaMetaData metadata, [String path]) async {

    List<String> _argsList;
    String _path;
    String _finalPath;

    if (path != null) _path = path;
    if (path == null) _path = await appdata.getDefaultDownloadFolder;
    _finalPath = _path + "/" + metadata.title;
    if (type == FFmpegArgs.argsToACC) {
      _argsList = [
        "-y", "-i",
        appdata.getLastFilePath,
        "-c:a", "aac",
        "-profile:a", "aac_low",
        "-metadata", "title=${metadata.title}",
        "-metadata", "album=${metadata.album}",
        "-metadata", "artist=${metadata.artist}",
        "-metadata", "genre=${metadata.genre}",
        "-metadata", "date=${metadata.date}",
        "-metadata", "disk=${metadata.disk}",
        "-metadata", "track=${metadata.track}",
        "$_finalPath.m4a",
      ];
    }
    print("Full path: " + _argsList.last);
    return _argsList;

  }

  // Functions to convert media
  Future<int> convertAudio(List<String> arguments) async {
    appdata.progressController.add(null);
    print("Converter: Starting audio file convertion...");
    int _result;
    await flutterFFmpeg.executeWithArguments(arguments).then(
      (value) {
        File(appdata.getLastFilePath).delete();
        method.registerFile(arguments.last);
        _result = value;
      }
    );
    print("Converter: Done, result: " + _result.toString());
    appdata.progressController.add(0.0);
    return _result;
  }

}

class MediaMetaData {

  String title;
  String album;
  String artist;
  String genre;
  String coverurl;
  String date;
  String disk;
  String track;

  MediaMetaData(this.title, this.album, this.artist, this.genre,
    this.coverurl, this.date, this.disk, this.track);

}

class Downloader {
  String id;
  MediaMetaData defaultMetaData;

  Downloader() {
    appdata.isDownloading.add(false);
  }

  Future<void> getInfo(url) async {
    print("Downloader: Getting link info");
    appdata.progressController.add(null);
    YoutubeExplode yt = YoutubeExplode();
    String _id = YoutubeExplode.parseVideoId(url); // Returns `OpQFFLBMEPI`
    if (_id == null) {
      print("Downloader: Invalid ID: " + url.toString());
      return 0;
    }
    var mediaStream = await yt.getVideoMediaStream(_id);
    AudioStreamInfo audio = mediaStream.audio.last;
    appdata.audioTitle.add(mediaStream.videoDetails.title);
    appdata.audioArtist.add(mediaStream.videoDetails.author);
    appdata.audioDuration.add(mediaStream.videoDetails.duration);
    appdata.audioSize.add(audio.size);
    appdata.linkReady.add(true);
    appdata.videoId.add(_id);
    defaultMetaData = MediaMetaData(mediaStream.videoDetails.title, mediaStream.videoDetails.author,
      mediaStream.videoDetails.author, "Any", mediaStream.videoDetails.thumbnailSet.maxResUrl,
      mediaStream.videoDetails.uploadDate.toString(),
      "Any", "Any");
    id = _id;
    yt.close();
    appdata.progressController.add(0.0);
  }

  Future<void> download() async {
    YoutubeExplode yt = YoutubeExplode();
    appdata.isDownloading.add(true);
    // Get the video media stream.
    print("Downloader: Getting video info...");
    var mediaStream = await yt.getVideoMediaStream(id);
    String directory = await appdata.getDefaultDownloadFolder;
    if (!(await Directory(directory).exists())) {
      await Directory(directory).create();
    }
    // Get the last audio track (the one with the highest bitrate).
    var audio = mediaStream.audio.last;

    // Compose the file name removing the unallowed characters in windows.
    var fileName = '${mediaStream.videoDetails.title}'
        .replaceAll('Container.', '')
        .replaceAll(r'\', '')
        .replaceAll('/', '')
        .replaceAll('*', '')
        .replaceAll('?', '')
        .replaceAll('"', '')
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('|', '');
    var file = File("$directory/$fileName");
    print("Downloader: File name: $fileName");
    // Create the StreamedRequest to track the download status.

    // Open the file in appendMode.
    var output = file.openWrite(mode: FileMode.write);

    // Track the file download status.
    var len = audio.size;
    var count = 0;
    var oldProgress = -1;

    // Listen for data received.
    print("Downloader: Starting Download...");
    await for (var data in audio.downloadStream()) {
      count += data.length;
      var progress = ((count / len) * 100).round();
      if (progress != oldProgress) {
        oldProgress = progress;
        appdata.progressController.add((progress * 0.01).toDouble());
      }
      output.add(data);
    }
    await output.close();
    appdata.getLastFilePath = "$directory/$fileName";
    appdata.getFileName = "$fileName";
    appdata.isDownloading.add(false);
    print("Downloader: All done");
  }
}

class ExternalPath {
  // Path for external storage
  Future<String> get externalStorage async =>
      await ExtStorage.getExternalStorageDirectory();

  // Path for external storage "Downloads" folder
  Future<String> get externalDownloads async =>
      await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);

  // Path for external storage "Music" folder
  Future<String> get externalMusic async =>
      await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_MUSIC);
}

class AppStreams {
  StreamController progressController = new StreamController();
  StreamController<bool> isDownloading = new StreamController.broadcast();
  StreamController<bool> linkReady = new StreamController.broadcast();
  StreamController<String> videoId = new StreamController.broadcast();
  StreamController<int> audioSize = new StreamController.broadcast();
  StreamController<Duration> audioDuration = new StreamController.broadcast();
  StreamController<String> audioTitle = new StreamController.broadcast();
  StreamController<String> audioArtist = new StreamController.broadcast();

  String getFileName;
  String getLastFilePath;
  Future<String> get getDefaultDownloadFolder async {
    String path = await ExternalPath().externalStorage;
    path = path + "/" + "SongTube";
    return path;
  }

  void unloadStreams() {
    audioSize.add(null);
    audioDuration.add(null);
    audioArtist.add(null);
    audioTitle.add(null);
    linkReady.add(null);
    isDownloading.add(null);
    progressController.add(0.0);
  }

  void dispose() {
    progressController.close();
    isDownloading.close();
    linkReady.close();
    audioSize.close();
    audioDuration.close();
    audioTitle.close();
    audioArtist.close();
  }
}
