// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:audio_tagger/audio_tagger.dart';
import 'package:audio_tagger/audio_tags.dart';
import 'package:file_operations/file_operations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:newpipeextractor_dart/utils/httpClient.dart';
import 'package:newpipeextractor_dart/utils/url.dart';
import 'package:songtube/internal/languages.dart';

// Internal
import 'package:songtube/internal/database/databaseService.dart';
import 'package:songtube/internal/download/downloadItem.dart';
import 'package:songtube/internal/models/songFile.dart';
import 'package:songtube/internal/download/tags.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/models/streamSegmentTrack.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/internal/randomString.dart';

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

    // Download File by DownloadType
    File downloadedFile;

    // Our download is a Video
    if (downloadItem.downloadType == DownloadType.VIDEO) {
      if (downloadItem.videoStream == null) {
        YoutubeVideo video = await VideoExtractor.getStream(downloadItem.url);
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
        downloadItem.audioStream = (await VideoExtractor.getStream(downloadItem.url))
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
        downloadStatusStream.add(DownloadStatus.Converting);
        downloadedFile = await ffmpegConverter.normalizeAudio(downloadedFile.path);
        if (downloadedFile == null) return;
      }
      // Apply Audio Filters
      if (_applyFilters) {
        currentAction.add(language.labelPatchingAudio + (downloadItem.filters.normalizeAudio ? " (2/2)" : ""));
        downloadStatusStream.add(DownloadStatus.Converting);
        downloadedFile = await ffmpegConverter.applyAudioModifiers(downloadedFile.path, downloadItem.filters);
      }
      if (downloadedFile == null) return;
      // Check if Conversion is needed
      if (await ffmpegConverter.audioConversionRequired(downloadItem.ffmpegTask, downloadedFile.path)) {
        downloadStatusStream.add(DownloadStatus.Converting);
        downloadedFile = await _convertAudio(downloadItem.ffmpegTask, downloadedFile.path);
        if (downloadedFile == null) return;
      }
    }

    // Rename File
    downloadedFile = await renameFile(downloadedFile, downloadItem.tags.title);

    // If this download is segmented, we can now start splitting the audio file
    // into various files, in the contrary that this download is not segmented,
    // we will just write all the metadata to the original file and save it.
    if (!downloadItem.isDownloadSegmented) {
      // Process the original file
      downloadStatusStream.add(DownloadStatus.WrittingTags);
      if (downloadItem.downloadType == DownloadType.AUDIO) {
        currentAction.add(language.labelWrittingTagsAndArtwork);
        await writeAllMetadata(downloadedFile.path, downloadItem.tags);
      }

      // Check our formatSuffix
      downloadItem.formatSuffix = 
        await ffmpegConverter.getMediaFormat(downloadedFile.path);

      // Move file to its Predefined Directory
      currentAction.add(language.labelSavingFile);
      Permission.storage.request().then((value) async {
        if (value == PermissionStatus.granted) {
          String outputFileName = removeToxicSymbols("${downloadItem.tags.title}.${downloadItem.formatSuffix}");
          String outputFile = "${downloadItem.downloadPath}/$outputFileName";
          var finalFile = await FileOperations.moveFile(downloadedFile.path, outputFile);
          if (finalFile is File) {
            await finishDownload(finalFile, downloadItem.tags, downloadItem.duration);
            completedCallback(downloadId, converted);
          } else {
            errorReason = finalFile;
            _interruptDownload(finalFile);
            saveErrorCallback(downloadId);
            return;
          }
        }
      });
    } else {
      // Check our formatSuffix
      downloadStatusStream.add(DownloadStatus.WrittingTags);
      downloadItem.formatSuffix = 
        await ffmpegConverter.getMediaFormat(downloadedFile.path);
      // Process the segments of the original file
      List<SegmentFile> segmentFiles = [];
      // Split and add all SegmentFiles to our list
      for (int i = 0; i < downloadItem.segmentTracks.length; i++) {
        currentAction.add("Extracting audio files (${i+1}/${downloadItem.segmentTracks.length})");
        StreamSegmentTrack segmentTrack = downloadItem.segmentTracks[i];
        int segmentTracksLength = downloadItem.segmentTracks.length;
        int start = segmentTrack.segment.startTimeSeconds;
        int end = segmentTracksLength-1 == i
          ? downloadItem.duration
          : downloadItem.segmentTracks[i+1].segment.startTimeSeconds;
        File extractedAudio = await ffmpegConverter.extractAudio(
          downloadedFile.path, start, end);
        segmentFiles.add(
          SegmentFile(
            extractedAudio,
            DownloadTags(
              title: removeToxicSymbols(segmentTrack.tags.titleController.text),
              album: segmentTrack.tags.albumController.text,
              artist: segmentTrack.tags.artistController.text
                .replaceAll("- Topic", "").trim(),
              genre: segmentTrack.tags.genreController.text,
              coverurl: segmentTrack.tags.artworkController,
              date: segmentTrack.tags.dateController.text,
              disc: segmentTrack.tags.discController.text,
              track: segmentTrack.tags.trackController.text
            ),
            (end - start).abs(),
          ),
        );
      }
      // Write all the metadata to all our Segment files
      for (int i = 0; i < segmentFiles.length; i++) {
        currentAction.add("Writting audio tags (${i+1}/${segmentFiles.length})");
        segmentFiles[i].segmentFile = await ffmpegConverter
          .clearFileMetadata(segmentFiles[i].segmentFile.path);
        if (segmentFiles[i].segmentFile == null) return;
        await writeAllMetadata(segmentFiles[i].segmentFile.path, segmentFiles[i].tags);
      }
      // Save all our Segment files
      for (int i = 0; i < segmentFiles.length; i++) {
        currentAction.add("Saving audio file (${i+1}/${segmentFiles.length})");
        SegmentFile segment = segmentFiles[i];
        Permission.storage.request().then((value) async {
          if (value == PermissionStatus.granted) {
            String outputFileName = removeToxicSymbols("${segment.tags.title}.${downloadItem.formatSuffix}");
            String outputFile = "${downloadItem.downloadPath}/$outputFileName";
            var finalFile = await FileOperations.moveFile(segment.segmentFile.path, outputFile);
            if (finalFile is File) {
              await finishDownload(finalFile, segment.tags, segment.duration);
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
    }
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
    Stream<List<int>> streamData = ExtractorHttpClient.getStream(streamToDownload, headers: {
      'Keep-Alive': 'timeout=1, max=1000'
    });
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
  Future<void> writeAllMetadata(String filePath, DownloadTags tags) async {
    downloadStatusStream.add(DownloadStatus.WrittingTags);
    try {
      await AudioTagger.writeAllTags(
        songPath: filePath,
        tags: AudioTags(
          title: tags.title,
          album: tags.album,
          artist: tags.artist,
          genre: tags.genre,
          year: tags.date,
          disc: tags.disc,
          track: tags.track
        )
      );
      // Only add Artwork if song is in AAC Format
      if (downloadItem.formatSuffix == 'm4a') {
        File croppedImage = new File(
          (await getExternalStorageDirectory()).path +
          "/${RandomString.getRandomString(5)}"
        );
        if (isURL(tags.coverurl)) {
          http.Response response;
          File artwork = new File(
            (await getExternalStorageDirectory()).path +
            "/${RandomString.getRandomString(5)}"
          );
          try {
            response = await http.get(Uri.parse(tags.coverurl));
            await artwork.writeAsBytes(response.bodyBytes);
            var decodedImage = await decodeImageFromList(artwork.readAsBytesSync());
            if (decodedImage.width == 120 && decodedImage.height == 90)
              response = null;
          } catch (_) {}
          // If it doesnt exist try Getting MediumQuality Artwork
          if (response == null || response.bodyBytes == null) {
            try {
              String id = await YoutubeId.getIdFromStreamUrl(downloadItem.url);
              response = await http.get(Uri.parse("https://img.youtube.com/vi/$id/mqdefault.jpg"))
                .timeout(Duration(seconds: 30));
              await artwork.writeAsBytes(response.bodyBytes);
              downloadItem.tags.coverurl = "https://img.youtube.com/vi/$id/mqdefault.jpg";
            } catch (_) {}
          }
          await croppedImage.writeAsBytes(
            await AudioTagger.cropToSquare(artwork));
        } else {
          await croppedImage.writeAsBytes(
            await AudioTagger.cropToSquare(File(tags.coverurl)));
        }
        currentAction.add('Writting Artwork...');
        await AudioTagger.writeArtwork(
          songPath: filePath,
          artworkPath: croppedImage.path
        );
        // Copy our CoverArt to default folder
        await croppedImage.copy((await getApplicationDocumentsDirectory()).path +
          "${tags.title}.jpg");
      }
    } on Exception catch (_) {}
  }

  // Finish download by inserting it to the Database
  // and updating Android MediaStore
  Future<void> finishDownload(File finalFile, DownloadTags tags, int duration) async {
    final dbHelper = DatabaseService.instance;
    await dbHelper.insertDownload(new SongFile.toDatabase(
      title: tags.title,
      album: tags.album,
      author: tags.artist,
      duration: duration.toString(),
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

class SegmentFile {

  File segmentFile;
  DownloadTags tags;
  int duration;

  SegmentFile(
    this.segmentFile,
    this.tags,
    this.duration
  );

}