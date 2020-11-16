// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/audioModifiers.dart';

// Internal
import 'package:songtube/internal/database/databaseService.dart';
import 'package:songtube/internal/models/songFile.dart';
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
import 'package:string_validator/string_validator.dart';

enum DownloadType { AUDIO, VIDEO }
enum DownloadStatus { Loading, Downloading, Converting, WrittingTags, Completed, Cancelled }

class DownloadInfoSet {

  // Class Initializers
  Languages language;
  DownloadMetaData metadata;
  DownloadType downloadType;
  FFmpegActionType convertFormat;
  String downloadPath;
  AudioModifiers audioModifiers;
  StreamInfo audioStreamInfo;
  StreamInfo videoStreamInfo;
  Video videoDetails;
  String downloadId;
  Function(String, bool) completedCallback;
  Function(String) cancelledCallback;
  Function(String) convertingCallback;
  Function(String) saveErrorCallback;

  DownloadInfoSet({
    @required this.language,
    @required this.metadata,
    @required this.downloadType,
    @required this.convertFormat,
    @required this.downloadPath,
    @required this.audioModifiers,
    @required this.audioStreamInfo,
    @required this.videoDetails,
    @required this.downloadId,
    @required this.completedCallback,
    @required this.cancelledCallback,
    @required this.convertingCallback,
    @required this.saveErrorCallback,
    this.videoStreamInfo,
  }) {
    ffmpegConverter = new FFmpegConverter();
    downloadStatus = new BehaviorSubject<DownloadStatus>();
    currentAction = new BehaviorSubject<String>();
    dataProgress = new BehaviorSubject<String>();
    progressBar = new BehaviorSubject<double>();
    cancelDownload = false;
    downloadStatus.add(DownloadStatus.Loading);
    currentAction.add(language.labelQueued);
    progressBar.add(0.0);
  }

  // Streams
  BehaviorSubject<DownloadStatus> downloadStatus;
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
    downloadStatus.add(DownloadStatus.Cancelled);
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
    downloadStatus.close();
    currentAction.close();
    dataProgress.close();
    progressBar.close();
  }

  // Check our Download Path
  Future<void> _checkDownloadPath() async {
    Directory path = Directory(downloadPath);
    if (!await path.exists())
      await path.create(recursive: true);
  }

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
    // Reset to Default values
    _resetStreams();
    // Check our Download Folder
    await _checkDownloadPath();
    // Download File by DownloadType
    File downloadedFile;
    // Our download is a Video
    if (downloadType == DownloadType.VIDEO) {
      // Download specified VideoStream
      downloadedFile = await _downloadStream(videoStreamInfo, downloadType);
      // Download best Audio file and slam
      // it into the video using FFmpeg
      File audioFile = await _downloadStream(audioStreamInfo, DownloadType.AUDIO);
      if (audioFile == null) return;
      // Path downloaded Audio file to our Video
      downloadedFile = await _pathAudioToVideo(downloadedFile.path, audioFile.path);
      if (downloadedFile == null) return;
    // Our Download is an Audio
    } else if (downloadType == DownloadType.AUDIO) {
      // Download specified AudioStream
      downloadedFile = await _downloadStream(audioStreamInfo, downloadType);
      // Remove Existing Metadata
      currentAction.add(language.labelClearingExistingMetadata);
      downloadedFile = await ffmpegConverter.clearFileMetadata(downloadedFile.path);
      if (downloadedFile == null) return;
      // Check if Conversion is needed
      if (await ffmpegConverter.audioConversionRequired(convertFormat, downloadedFile.path)) {
        downloadedFile = await _convertAudio(convertFormat, downloadedFile.path);
        if (downloadedFile == null) return;
      }
    }
    // Rename File
    downloadedFile = await renameFile(downloadedFile, metadata.title);
    downloadedFile = await ffmpegConverter.clearFileMetadata(downloadedFile.path);
    if (downloadedFile == null) return;
    // Write All Metadata if its Audio
    if (downloadType == DownloadType.AUDIO) {
      currentAction.add(language.labelWrittingTagsAndArtwork);
      await writeAllMetadata(downloadedFile.path);
    }
    // Move file to its Predefined Directory
    currentAction.add(language.labelSavingFile);
    Permission.storage.request().then((value) async {
      if (value == PermissionStatus.granted) {
        if (!await Directory(downloadPath).exists()) {
          await Directory(downloadPath).create(recursive: true);
        }
        String fileName = downloadedFile.path.split("/").last;
        File finalFile;
        try {
          finalFile = await downloadedFile.copy("$downloadPath/$fileName");
        } on Exception catch (_) {
          AndroidDeviceInfo deviceInfo = await DeviceInfoPlugin().androidInfo;
          int sdkNumber = deviceInfo.version.sdkInt;
          if (sdkNumber > 28) {
            _interruptDownload(language.labelAndroid11FixNeeded);
          } else {
            _interruptDownload(language.labelErrorSavingDownload);
          }
          saveErrorCallback(downloadId);
          return;
        }
        await finishDownload(finalFile);
        completedCallback(downloadId, converted);
      }
    });
  }

  // Start Downloading our Stream
  Future<File> _downloadStream(StreamInfo streamToDownload, DownloadType type) async {
    // Download
    File download = File(
      (await getTemporaryDirectory()).path +
      "/" + RandomString.getRandomString(10)
    );
    // YoutubeExplode Instance
    YoutubeExplode yt = new YoutubeExplode();
    downloadStatus.add(DownloadStatus.Loading);
    // StreamData
    Stream<List<int>> streamData;
    if (streamToDownload != null) {
      streamData = yt.videos.streamsClient.get(streamToDownload);
      if (type == DownloadType.VIDEO)
        currentAction.add(language.labelDownloadingVideo);
      else
        currentAction.add(language.labelDownloadingAudio);
    } else {
      int retryCount = 0;
      currentAction.add(language.labelGettingAudioStream);
      StreamManifest audioManifest;
      while (retryCount < 3) {
        try {
          audioManifest = await yt.videos.streamsClient.getManifest(videoDetails.id)
            .timeout(Duration(seconds: 30));
          break;
        } catch (_) {
          retryCount++;
        }
      }
      if (audioManifest == null) {
        currentAction.add(language.labelAudioNoDataRecieved);
        yt.close();
        return null;
      }
      audioStreamInfo = audioManifest.audioOnly.withHighestBitrate();
      streamData = yt.videos.streamsClient.get(audioStreamInfo);
      currentAction.add(language.labelDownloadingAudio);
    }
    // Update Streams
    dataProgress.add(language.labelDownloadStarting);
    progressBar.add(0.0);
    // Open the file in write.
    var _output = download.openWrite(mode: FileMode.write);
    // Local variables for File Download Status
    var _count = 0;
    var _len;
    if (videoStreamInfo == null) {
      _len = audioStreamInfo.size.totalBytes;
    } else {
      _len = videoStreamInfo.size.totalBytes + audioStreamInfo.size.totalBytes;
    }
    downloadStatus.add(DownloadStatus.Downloading);
    // Start stream download while updating internal
    // BehaviorSubject for external access
    await for (var data in streamData) {
      if (cancelDownload == true) {
        _output.close();
        downloadStatus.add(DownloadStatus.Cancelled);
        _interruptDownload(language.labelDownloadCancelled);
        yt.close();
        return null;
      }
      _count += data.length;
      dataProgress.add("${(_count * 0.000001).toStringAsFixed(2)} MB / ${(_len * 0.000001).toStringAsFixed(2)} MB");
      progressBar.add((_count / _len).toDouble());
      print(language.labelDownloading+": " + _count.toString());
      _output.add(data);
    }
    await _output.flush();
    await _output.close();
    yt.close();
    return download;
  }

  // Convert Audio with FFmpeg
  Future<File> _convertAudio(FFmpegActionType format, String path) async {
    downloadStatus.add(DownloadStatus.Converting);
    progressBar.add(null);
    currentAction.add(language.labelConverting);
    convertingCallback(downloadId);
    converted = true;
    File convertedAudio = await ffmpegConverter.convertAudio(
      audioFile: path,
      format: convertFormat,
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
    downloadStatus.add(DownloadStatus.WrittingTags);
    try {
      await TagsManager.writeAllTags(
        songPath: filePath,
        title: metadata.title,
        album: metadata.album,
        artist: metadata.artist,
        genre: metadata.genre,
        year: metadata.date,
        disc: metadata.disc,
        track: metadata.track
      );
      // Only add Artwork if song is in AAC Format
      if (convertFormat == FFmpegActionType.ConvertToAAC) {
        File croppedImage;
        if (isURL(metadata.coverurl)) {
          http.Response response;
          File artwork = new File(
            (await getTemporaryDirectory()).path +
            "/${RandomString.getRandomString(5)}"
          );
          if (metadata.coverurl == videoDetails.thumbnails.mediumResUrl) {
            // Try getting FullQuality Artwork
            try {
              response = await http.get(videoDetails.thumbnails.maxResUrl)
                .timeout(Duration(seconds: 10));
              await artwork.writeAsBytes(response.bodyBytes);
              var decodedImage = await decodeImageFromList(artwork.readAsBytesSync());
              if (decodedImage.width == 120 && decodedImage.height == 90)
                response = null;
            } catch (_) {}
            // If it doesnt exist try Getting MediumQuality Artwork
            if (response == null || response.bodyBytes == null) {
              try {
                response = await http.get(videoDetails.thumbnails.mediumResUrl)
                  .timeout(Duration(seconds: 10));
                await artwork.writeAsBytes(response.bodyBytes);
              } catch (_) {}
            }
          } else {
            try {
              response = await http.get(metadata.coverurl)
                .timeout(Duration(seconds: 10));
              await artwork.writeAsBytes(response.bodyBytes);
            } catch (_) {}
          }
          croppedImage = await NativeMethod.cropToSquare(artwork);
        } else {
          croppedImage = await NativeMethod.cropToSquare(File(metadata.coverurl));
        }
        await TagsManager.writeArtwork(
          songPath: filePath,
          artworkPath: croppedImage.path
        );
        // Copy our CoverArt to default folder
        await croppedImage.copy((await getApplicationDocumentsDirectory()).path +
          "${metadata.title}.jpg");
      }
    } on Exception catch (_) {}
  }

  // Finish download by inserting it to the Database
  // and updating Android MediaStore
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
      coverUrl: videoDetails.thumbnails.mediumResUrl,
      path: finalFile.path
    ));
    downloadStatus.add(DownloadStatus.Completed);
    currentAction.add(language.labelCompleted);
    progressBar.add(1.0);
    NativeMethod.registerFile(finalFile.path);
    _closeStreams();
  }
}