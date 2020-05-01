import 'dart:io';
import 'dart:async';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'songtube_classes.dart';

class Downloader {

  String lastAudioDownloaded;
  String lastVideoDownloaded;

  List<VideoStreamInfo> extractVideoStreams(MediaStreamInfoSet list) {
    List<VideoStreamInfo> videoList = [];
    list.video.sort((a, b) => int.parse(
      a.videoQualityLabel.replaceAll("p", "")).compareTo(int.parse(
      b.videoQualityLabel.replaceAll("p", ""))));
    int _size = list.video.length;
    for (int i = 0; i <= _size; i++){
      if (_size-1 == i) {
        videoList.add(list.video[i]);
        break;
      }
      if (list.video[i].videoQualityLabel != list.video[i+1].videoQualityLabel) {
        videoList.add(list.video[i]);
      }
    }
    return videoList;
  }

  static Future<MediaMetaData> getInfo(url) async {
    print("Downloader: Getting link info");
    appdata.progressController.add(null);
    appdata.currentAction.add(CurrentAction.loading);
    MediaMetaData metadata;
    YoutubeExplode yt = YoutubeExplode();
    String _id = YoutubeExplode.parseVideoId(url); // Returns `OpQFFLBMEPI`
    var mediaStream;

    if (_id == null) {
      print("Downloader: Invalid ID: " + url.toString());
      return null;
    }
    try {
      mediaStream = await yt.getVideoMediaStream(_id);
    } on Exception catch (e) {
      appdata.currentAction.add(CurrentAction.none);
      print("Downloader: " + e.toString());
      yt.close();
      appdata.progressController.add(0.0);
      return null;
    }

    // Load video information onto our AppData instance
    appdata.audio = mediaStream.audio.last;
    appdata.audioTitle = mediaStream.videoDetails.title;
    appdata.audioArtist = mediaStream.videoDetails.author;
    appdata.audioDuration = mediaStream.videoDetails.duration;
    appdata.audioSize = double.parse(((appdata.audio.size / 1024) / 1024).toStringAsFixed(1));
    appdata.videoId = _id;

    // Load our local MediaMetaData instance with video information
    metadata = MediaMetaData(
      mediaStream.videoDetails.title,
      mediaStream.videoDetails.author,
      mediaStream.videoDetails.author,
      "Any",
      mediaStream.videoDetails.thumbnailSet.mediumResUrl,
      mediaStream.videoDetails.uploadDate.toString(),
      "Any",
      "Any"
    );
    appdata.id = _id;
    appdata.mediaStream = mediaStream;
    yt.close();
    appdata.progressController.add(0.0);
    appdata.currentAction.add(CurrentAction.none);
    return metadata;
  }

  Future<int> downloadVideo(MediaStreamInfoSet mediaStream, int index, progressBar, dataProgress) async {
    appdata.currentAction.add(CurrentAction.downloading);
    // Get the video media stream.
    print("Downloader: Getting video info...");
    String directory = await appdata.getDefaultDownloadFolder;
    if (!(await Directory(directory).exists())) await Directory(directory).create();
    directory = directory + "/tmp";
    if (!(await Directory(directory).exists())) await Directory(directory).create();

    var videoToDownload = extractVideoStreams(mediaStream)[index];

    // Compose the file name removing the unallowed characters in windows.
    var fileName;
    var len;
    fileName = mediaStream.videoDetails.title.toString() + "-video"
      .replaceAll('Container.', '')
      .replaceAll(r'\', '')
      .replaceAll('/', '')
      .replaceAll('*', '')
      .replaceAll('?', '')
      .replaceAll('"', '')
      .replaceAll('<', '')
      .replaceAll('>', '')
      .replaceAll('|', '');
    len = videoToDownload.size;
    var file = File("$directory/$fileName");
    lastVideoDownloaded = "$directory/$fileName";
    print("Downloader: File name: $fileName");
    // Create the StreamedRequest to track the download status.

    // Open the file in write.
    var output = file.openWrite(mode: FileMode.write);

    // Track the file download status.
    var count = 0;
    var oldProgress = -1;

    // Listen for data received.
    print("Downloader: Starting Download...");
    await for (var data in videoToDownload.downloadStream()) {
      count += data.length;
      if (!dataProgress.isClosed) {
        dataProgress.add(double.parse(((count / 1024) / 1024).toStringAsFixed(2)));
      }
      if (dataProgress.isClosed) {
        output.close();
        return null;
      }
      var progress = ((count / len) * 100).round();
      if (progress != oldProgress) {
        oldProgress = progress;
        progressBar.add((progress * 0.01).toDouble());
      }
      output.add(data);
    }
    await output.close();
    appdata.currentAction.add(CurrentAction.none);
    print("Downloader: All done");
    return 0;
  }

  Future<int> downloadAudio(MediaStreamInfoSet mediaStream, StreamController progressBar, StreamController dataProgress) async {
    appdata.currentAction.add(CurrentAction.downloading);
    // Get the video media stream.
    print("Downloader: Getting audio info...");
    String directory = await appdata.getDefaultDownloadFolder;
    if (!(await Directory(directory).exists())) await Directory(directory).create();
    directory = directory + "/tmp";
    if (!(await Directory(directory).exists())) await Directory(directory).create();

    var audioToDownload = mediaStream.audio.last;

    // Compose the file name removing the unallowed characters in windows.
    var fileName;
    var len;
    fileName = mediaStream.videoDetails.title.toString() + "-audio"
      .replaceAll('Container.', '')
      .replaceAll(r'\', '')
      .replaceAll('/', '')
      .replaceAll('*', '')
      .replaceAll('?', '')
      .replaceAll('"', '')
      .replaceAll('<', '')
      .replaceAll('>', '')
      .replaceAll('|', '');
    len = audioToDownload.size;
    lastAudioDownloaded = "$directory/$fileName";
    var file = File("$directory/$fileName");
    print("Downloader: File name: $fileName");
    // Create the StreamedRequest to track the download status.

    // Open the file in write.
    var output = file.openWrite(mode: FileMode.write);

    // Track the file download status.
    var count = 0;
    var oldProgress = -1;

    // Listen for data received.
    print("Downloader: Starting Download...");
    await for (var data in audioToDownload.downloadStream()) {
      count += data.length;
      if (!dataProgress.isClosed) {
        dataProgress.add(double.parse(((count / 1024) / 1024).toStringAsFixed(2)));
      }
      if (dataProgress.isClosed) {
        output.close();
        return null;
      }
      var progress = ((count / len) * 100).round();
      if (progress != oldProgress) {
        oldProgress = progress;
        progressBar.add((progress * 0.01).toDouble());
      }
      output.add(data);
    }
    await output.close();
    appdata.currentAction.add(CurrentAction.none);
    print("Downloader: All done");
    return 0;
  }
}