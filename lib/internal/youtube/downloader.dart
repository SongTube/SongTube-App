// Dart
import 'dart:io';
import 'dart:async';

// Internal
import 'package:songtube/internal/models/enums.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:ext_storage/ext_storage.dart';

class Downloader {

  // Create Streams to track file download status
  final StreamController<double> progressBar = new StreamController<double>();
  final StreamController<String> dataProgress = new StreamController<String>();

  // Variables
  double fileSize = 0;
  bool cancelDownload = false;

  // Last Audio/Video successfully downloaded
  String lastAudioDownloaded;
  String lastVideoDownloaded;

  static List<VideoStreamInfo> extractVideoStreams(MediaStreamInfoSet list) {
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

  Future<int> downloadStream(MediaStreamInfoSet mediaStream, DownloadType type, [int videoIndex]) async { 

    // Check path to save Video
    String _directory = await ExtStorage.getExternalStorageDirectory() + "/" + "SongTube";
    if (!(await Directory(_directory).exists())) await Directory(_directory).create();
    _directory = _directory + "/tmp";
    if (!(await Directory(_directory).exists())) await Directory(_directory).create();

    // Get video to download
    var streamToDownload = type == DownloadType.video
      ? extractVideoStreams(mediaStream)[videoIndex]
      : mediaStream.audio.last;

    // Compose the file name removing the unallowed characters in windows.
    String _fileName = type == DownloadType.video 
    ? mediaStream.videoDetails.title.toString() + "-video"
    : mediaStream.videoDetails.title.toString() + "-audio"
      .replaceAll('Container.', '')
      .replaceAll(r'\', '')
      .replaceAll('/', '')
      .replaceAll('*', '')
      .replaceAll('?', '')
      .replaceAll('"', '')
      .replaceAll('<', '')
      .replaceAll('>', '')
      .replaceAll('|', '');
    File _filePath = File("$_directory/$_fileName");

    // Open the file in write.
    var _output = _filePath.openWrite(mode: FileMode.write);

    // Local variables for file status
    var _count = 0;
    var _oldProgress = -1;
    var _len = streamToDownload.size;
    fileSize = fileSize + double.parse((streamToDownload.size * 0.000001).toStringAsFixed(2));
    DateTime currentTime;
    DateTime now;

    // Start stream download, also update internal public
    // StreamController for external access
    await for (var data in streamToDownload.downloadStream()) {
      if (cancelDownload == true) { _output.close(); return null; }
      _count += data.length;
      now = DateTime.now();
      if (currentTime == null || 
        now.difference(currentTime) > Duration(milliseconds: 500)) {
        dataProgress.add((_count * 0.000001).toStringAsFixed(2));
        print("Downloading: " + _count.toString());
        currentTime = now;
      }
      var progress = ((_count / _len) * 100).round();
      if (progress != _oldProgress) {
        _oldProgress = progress;
        progressBar.add((progress * 0.01).toDouble());
      }
      _output.add(data);
    }
    await _output.close();
    type == DownloadType.video
      ? lastVideoDownloaded = "$_directory/$_fileName"
      : lastAudioDownloaded = "$_directory/$_fileName";
    return 0;
  }

}