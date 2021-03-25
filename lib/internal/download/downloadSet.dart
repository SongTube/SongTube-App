// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:device_info/device_info.dart';
import 'package:file_operations/file_operations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:newpipeextractor_dart/models/streams/audioOnlyStream.dart';
import 'package:newpipeextractor_dart/models/streams/videoOnlyStream.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:newpipeextractor_dart/utils/httpClient.dart';
import 'package:newpipeextractor_dart/utils/url.dart';
import 'package:path/path.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/download/audioFilters.dart';

// Internal
import 'package:songtube/internal/database/databaseService.dart';
import 'package:songtube/internal/download/downloadItem.dart';
import 'package:songtube/internal/models/songFile.dart';
import 'package:songtube/internal/download/tags.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/internal/randomString.dart';
import 'package:songtube/internal/tagsManager.dart';

// Packages
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:string_validator/string_validator.dart';

enum DownloadType {
  AUDIO,
  VIDEO
}

enum DownloadStatus {
  Loading,
  Downloading,
  Converting,
  WrittingTags,
  Completed,
  Cancelled
}

class DownloadSet {

  // Class Initializers
  Languages language;
  String downloadId;
  int totalDownloaded = 0;
  Function(String, bool) completedCallback;
  Function(String) cancelledCallback;
  Function(String) convertingCallback;
  Function(String) saveErrorCallback;
  String errorReason;

  // Download Item
  DownloadItem downloadItem;

  // Download Lenth
  int totalDownloadLength = 0;

  DownloadSet({
    @required this.language,
    @required this.downloadItem,
    @required this.downloadId,
    @required this.completedCallback,
    @required this.cancelledCallback,
    @required this.convertingCallback,
    @required this.saveErrorCallback,
  }) {
    ffmpegConverter = new FFmpegConverter();
    downloadStatusStream = new BehaviorSubject<DownloadStatus>();
    currentAction = new BehaviorSubject<String>();
    dataProgress = new BehaviorSubject<String>();
    progressBar = new BehaviorSubject<double>();
    cancelDownload = false;
    downloadStatusStream.add(DownloadStatus.Loading);
    currentAction.add(language.labelQueued);
    progressBar.add(0.0);
  }

  // Streams
  BehaviorSubject<DownloadStatus> downloadStatusStream;
  BehaviorSubject<String> currentAction;
  BehaviorSubject<String> dataProgress;
  BehaviorSubject<double> progressBar;

  // FFmpeg FFmpegConverter
  bool converted = false;
  FFmpegConverter ffmpegConverter;

  // Cancel Download
  bool cancelDownload;

  // Interrupt Download
  void _interruptDownload(String reason) {
    currentAction.add(reason);
    dataProgress.add("");
    progressBar.add(0.0);
    downloadStatusStream.add(DownloadStatus.Cancelled);
    cancelledCallback(downloadId);
  } 

  // Check for Storage Permissions
  Future<bool> _appHasPermissions() async {
    var status = await Permission.storage.request();
    if (status == PermissionStatus.granted)
      return true;
    else
      return false;
  }

  // Reset Streams Values
  void _resetStreams() {
    currentAction.add("");
    dataProgress.add("");
    progressBar.add(0.0);
    cancelDownload = false;
    converted = false;
  }

  // Close Streams
  void _closeStreams() {
    downloadStatusStream.close();
    currentAction.close();
    dataProgress.close();
    progressBar.close();
  }

  // Check our Download Path
  Future<void> _checkDownloadPath() async {
    Directory path = Directory(downloadItem.downloadPath);
    if (!await path.exists()) {
      try {
        await path.create(recursive: true);
      } catch (_) {
        _interruptDownload("Couldn't access or create download path");
      }
    }
  }

  bool get _applyFilters =>
    downloadItem.filters.volume != 1.0 ||
    downloadItem.filters.bassGain != 0 ||
    downloadItem.filters.trebleGain != 0
      ? true : false;

  // ---------------------------------------------
  // Initialize this Media Download, automatically
  // Download, Convert, Write Metadata and Save
  // ---------------------------------------------
  Future<void> downloadMedia() async {

    // Check Storage Permissions
    if (!await _appHasPermissions()) {
      _interruptDownload(language.labelDownloadAcesssDenied);
      cancelledCallback(downloadId);
      return;
    }

    // Reset Streams to default values
    _resetStreams();

    // Check our Download Folder
    await _checkDownloadPath();

    // Download File by DownloadType
    File downloadedFile;

    // Our download is a Video
    if (downloadItem.downloadType == DownloadType.VIDEO) {
      if (downloadItem.videoStream == null) {
        YoutubeVideo video = await VideoExtractor.getVideoInfoAndStreams(downloadItem.url);
        downloadItem.videoStream = video.videoOnlyStreams.firstWhere((element) =>
          element.resolution.split("p").first == downloadItem.downloadQuality,
          orElse: () => video.videoOnlyStreams.first);
        downloadItem.audioStream = video.getAudioStreamWithBestMatchForVideoStream(downloadItem.videoStream);
      }
      // Download specified VideoStream
      if (downloadItem.videoStream.size == null) {
        downloadItem.videoStream.size = await getContentSize(downloadItem.videoStream.url);
      }
      if (downloadItem.audioStream.size == null) {
        downloadItem.audioStream.size = await getContentSize(downloadItem.audioStream.url);
      }
      totalDownloadLength = downloadItem.videoStream.size + downloadItem.audioStream.size;
      downloadedFile = await _downloadStream(downloadItem.videoStream);
      if (downloadedFile == null) return;
      // Download best Audio file and slam
      // it into the video using FFmpeg
      File audioFile = await _downloadStream(downloadItem.audioStream);
      if (audioFile == null) return;
      // Path downloaded Audio file to our Video
      downloadedFile = await _pathAudioToVideo(downloadedFile.path, audioFile.path);
    }

    // Our Download is an Audio
    if (downloadItem.downloadType == DownloadType.AUDIO) {
      if (downloadItem.audioStream == null) {
        downloadItem.audioStream = (await VideoExtractor.getVideoInfoAndStreams(downloadItem.url))
          .audioWithBestAacQuality;
      }
      // Download specified AudioStream
      if (downloadItem.audioStream.size == null) {
        downloadItem.audioStream.size = await getContentSize(downloadItem.audioStream.url);
      }
      totalDownloadLength = downloadItem.audioStream.size;
      downloadedFile = await _downloadStream(downloadItem.audioStream);
      if (downloadedFile == null) return;
      // Remove Existing Metadata
      currentAction.add(language.labelClearingExistingMetadata);
      downloadedFile = await ffmpegConverter.clearFileMetadata(downloadedFile.path);
      if (downloadedFile == null) return;
      // Apply Audio Normalizer
      if (downloadItem.filters.normalizeAudio) {
        currentAction.add(language.labelPatchingAudio + (_applyFilters ? " (1/2)" : ""));
        downloadedFile = await ffmpegConverter.normalizeAudio(downloadedFile.path);
        if (downloadedFile == null) return;
      }
      // Apply Audio Filters
      if (_applyFilters) {
        currentAction.add(language.labelPatchingAudio + (downloadItem.filters.normalizeAudio ? " (2/2)" : ""));
        downloadedFile = await ffmpegConverter.applyAudioModifiers(downloadedFile.path, downloadItem.filters);
      }
      if (downloadedFile == null) return;
      // Check if Conversion is needed
      if (await ffmpegConverter.audioConversionRequired(downloadItem.ffmpegTask, downloadedFile.path)) {
        downloadedFile = await _convertAudio(downloadItem.ffmpegTask, downloadedFile.path);
        if (downloadedFile == null) return;
      }
    }

    // Rename File
    downloadedFile = await renameFile(downloadedFile, downloadItem.tags.title);

    // Write All Metadata if its Audio
    if (downloadItem.downloadType == DownloadType.AUDIO) {
      downloadedFile = await ffmpegConverter.clearFileMetadata(downloadedFile.path);
      if (downloadedFile == null) return;
      currentAction.add(language.labelWrittingTagsAndArtwork);
      await writeAllMetadata(downloadedFile.path);
    }

    // Check our download has formatSuffix
    if (downloadItem.formatSuffix == null) {
      downloadItem.formatSuffix = 
        await ffmpegConverter.getMediaFormat(downloadedFile.path);
    }

    // Move file to its Predefined Directory
    currentAction.add(language.labelSavingFile);
    Permission.storage.request().then((value) async {
      if (value == PermissionStatus.granted) {
        String outputFileName = removeToxicSymbols("${downloadItem.tags.title}.${downloadItem.formatSuffix}");
        String outputFile = "${downloadItem.downloadPath}/$outputFileName";
        var finalFile = await FileOperations.moveFile(downloadedFile.path, outputFile);
        if (finalFile is File) {
          await finishDownload(finalFile);
          completedCallback(downloadId, converted);
        } else {
          errorReason = finalFile;
          _interruptDownload(finalFile);
          saveErrorCallback(downloadId);
          return;
        }
      }
    });
    
  }

  // Start Downloading our Stream
  Future<File> _downloadStream(dynamic stream) async {
    // Download
    File download = File(
      (await getExternalStorageDirectory()).path +
      "/" + RandomString.getRandomString(10)
    );
    // Update Streams
    if (totalDownloaded == 0) {
      downloadStatusStream.add(DownloadStatus.Loading);
      currentAction.add(language.labelDownloading);
    }
    // Stream to Download
    dynamic streamToDownload = stream;
    if (streamToDownload.size == null) {
      streamToDownload.size = await getContentSize(streamToDownload.url);
    }
    // StreamData
    Stream<List<int>> streamData = ExtractorHttpClient.getStream(streamToDownload);
    // Update Streams
    if (totalDownloaded == 0) {
      dataProgress.add(language.labelDownloadStarting);
      progressBar.add(0.0);
    }
    // Open the file in write.
    var _output = download.openWrite(mode: FileMode.write);
    downloadStatusStream.add(DownloadStatus.Downloading);
    // Start stream download while updating internal
    // BehaviorSubject for external access
    await for (var data in streamData) {
      if (cancelDownload == true) {
        _output.close();
        downloadStatusStream.add(DownloadStatus.Cancelled);
        _interruptDownload(language.labelDownloadCancelled);
        return null;
      }
      totalDownloaded += data.length;
      dataProgress.add(
        "${(totalDownloaded * 0.000001).toStringAsFixed(2)} MB " + 
        "/ ${(totalDownloadLength * 0.000001).toStringAsFixed(2)} MB");
      progressBar.add((totalDownloaded / totalDownloadLength).toDouble());
      _output.add(data);
    }
    await _output.flush();
    await _output.close();
    return download;
  }

  // Convert Audio with FFmpeg
  Future<File> _convertAudio(FFmpegTask task, String path) async {
    downloadStatusStream.add(DownloadStatus.Converting);
    progressBar.add(null);
    currentAction.add(language.labelConverting);
    convertingCallback(downloadId);
    converted = true;
    File convertedAudio = await ffmpegConverter.convertAudio(
      audioFile: path,
      task: task,
    );
    if (convertedAudio == null) {
      _interruptDownload(language.labelAnIssueOcurredConvertingAudio);
      return null;
    }
    return convertedAudio;
  }

  // Path Audio to video
  Future<File> _pathAudioToVideo(String videoPath, String audioPath) async {
    currentAction.add(language.labelPatchingAudio);
    convertingCallback(downloadId);
    converted = true;
    File patchedVideo = await ffmpegConverter.writeAudioToVideo(
      videoFormat: await ffmpegConverter.getMediaFormat(videoPath),
      videoPath: videoPath,
      audioPath: audioPath,
    );
    // If convertion failed notify the User
    if (patchedVideo == null) {
      _interruptDownload(language.labelAnIssueOcurredConvertingAudio);
      return null;
    }
    return patchedVideo;
  }

  // Rename File to a new provided FileName this function
  // preserves the file path and file extension.
  Future<File> renameFile(File file, String newName) async {
    String filePath = file.path
      .replaceAll("/${file.path.split('/').last}", '');
    String fileFormat = await ffmpegConverter.getMediaFormat(file.path);
    return await file.rename("$filePath/$newName.$fileFormat");
  }

  // Write Tags & Artwork
  Future<void> writeAllMetadata(String filePath) async {
    downloadStatusStream.add(DownloadStatus.WrittingTags);
    try {
      await TagsManager.writeAllTags(
        songPath: filePath,
        title: downloadItem.tags.title,
        album: downloadItem.tags.album,
        artist: downloadItem.tags.artist,
        genre: downloadItem.tags.genre,
        year: downloadItem.tags.date,
        disc: downloadItem.tags.disc,
        track: downloadItem.tags.track
      );
      // Only add Artwork if song is in AAC Format
      if (downloadItem.ffmpegTask == FFmpegTask.ConvertToAAC) {
        File croppedImage;
        if (isURL(downloadItem.tags.coverurl)) {
          http.Response response;
          File artwork = new File(
            (await getExternalStorageDirectory()).path +
            "/${RandomString.getRandomString(5)}"
          );
          try {
            response = await http.get(downloadItem.tags.coverurl)
              .timeout(Duration(seconds: 120));
            await artwork.writeAsBytes(response.bodyBytes);
            var decodedImage = await decodeImageFromList(artwork.readAsBytesSync());
            if (decodedImage.width == 120 && decodedImage.height == 90)
              response = null;
          } catch (_) {}
          // If it doesnt exist try Getting MediumQuality Artwork
          if (response == null || response.bodyBytes == null) {
            try {
              String id = await YoutubeId.getIdFromStreamUrl(downloadItem.url);
              response = await http.get("https://img.youtube.com/vi/$id/mqdefault.jpg")
                .timeout(Duration(seconds: 30));
              await artwork.writeAsBytes(response.bodyBytes);
              downloadItem.tags.coverurl = "https://img.youtube.com/vi/$id/mqdefault.jpg";
            } catch (_) {}
          }
          croppedImage = await NativeMethod.cropToSquare(artwork);
        } else {
          croppedImage = await NativeMethod.cropToSquare(File(downloadItem.tags.coverurl));
        }
        await TagsManager.writeArtwork(
          songPath: filePath,
          artworkPath: croppedImage.path
        );
        // Copy our CoverArt to default folder
        await croppedImage.copy((await getApplicationDocumentsDirectory()).path +
          "${downloadItem.tags.title}.jpg");
      }
    } on Exception catch (_) {}
  }

  // Finish download by inserting it to the Database
  // and updating Android MediaStore
  Future<void> finishDownload(File finalFile) async {
    final dbHelper = DatabaseService.instance;
    await dbHelper.insertDownload(new SongFile.toDatabase(
      title: downloadItem.tags.title,
      album: downloadItem.tags.album,
      author: downloadItem.tags.artist,
      duration: downloadItem.duration.toString(),
      downloadType: downloadItem.downloadType == DownloadType.AUDIO
        ? "Audio"
        : "Video",
      fileSize: ((await finalFile.length()) * 0.000001).toStringAsFixed(2),
      coverUrl: downloadItem.tags.coverurl,
      path: finalFile.path
    ));
    downloadStatusStream.add(DownloadStatus.Completed);
    currentAction.add(language.labelCompleted);
    progressBar.add(1.0);
    NativeMethod.registerFile(finalFile.path);
    _closeStreams();
  }

  Future<int> getContentSize(String url) async {
    int size;
    while (size == null) {
      try {
        size = await ExtractorHttpClient.getContentLength(url);
      } catch (_) {}
    }
    return size;
  }

  String removeToxicSymbols(String string) {
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

}