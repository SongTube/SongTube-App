import 'dart:async';
import 'dart:io';
import 'package:ext_storage/ext_storage.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Downloader downloader;
AppStreams appdata;

class Downloader {
  String id;

  Downloader() {
    appdata.isDownloading.add(false);
  }

  Future<int> getInfo(url) async {
    print("Downloader: Getting link info");
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
    id = _id;
    yt.close();
    return 1;
  }

  Future<void> download() async {
    YoutubeExplode yt = YoutubeExplode();
    appdata.isDownloading.add(true);
    // Get the video media stream.
    print("Downloader: Getting video info...");
    var mediaStream = await yt.getVideoMediaStream(id);
    String directory = await ExternalPath().externalMusic;
    // Get the last audio track (the one with the highest bitrate).
    var audio = mediaStream.audio.last;

    // Compose the file name removing the unallowed characters in windows.
    var fileName = '${mediaStream.videoDetails.title}.m4a'
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
    var output = file.openWrite(mode: FileMode.writeOnlyAppend);

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
  StreamController progressController = new StreamController.broadcast();
  StreamController<bool> isDownloading = new StreamController.broadcast();
  StreamController<bool> linkReady = new StreamController.broadcast();
  StreamController<int> audioSize = new StreamController.broadcast();
  StreamController<Duration> audioDuration = new StreamController.broadcast();
  StreamController<String> audioTitle = new StreamController.broadcast();
  StreamController<String> audioArtist = new StreamController.broadcast();

  void unloadStreams() {
    audioSize.add(null);
    audioDuration.add(null);
    audioArtist.add(null);
    audioTitle.add(null);
    linkReady.add(null);
    isDownloading.add(null);
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
