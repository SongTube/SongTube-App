// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:ext_storage/ext_storage.dart';
import 'package:path/path.dart';

// Internal
import 'package:songtube/internal/models/downloadinfoset.dart';
import 'package:songtube/internal/native.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/models/enums.dart';
import 'package:songtube/internal/tags_manager.dart';

class DownloadManager {

  final DownloadInfoSet infoset;
  final bool enableConvertion;

  DownloadManager({
    @required this.enableConvertion,
    @required this.infoset,
  });

  Future<int> handleDownload() async {
    String _downloadPath = await ExtStorage.getExternalStorageDirectory() + "/" + "SongTube";
    // -------
    // Audio
    // -------
    if (infoset.downloadType == DownloadType.audio) {
      if (enableConvertion == true) {
        // ----------------------------
        // Audio-Only Download
        // With Audio convertion
        // ----------------------------
        //
        // Declare our Variables
        int _result; String _audioSavePath;
        List<String> _args; 

        // Download raw Audio file
        infoset.currentAction.add("Downloading...");
        try {
          _result = await infoset.downloader.downloadStream(
            infoset.mediaStream,
            DownloadType.audio
          );
        } on Exception catch (_) {
          print(_.toString());
        } if (_result == null) return 1;
        // Build the Path for the Audio to be stored
        _audioSavePath = _downloadPath;
        _audioSavePath = _audioSavePath + "/" + basename(infoset.downloader.lastAudioDownloaded);

        // Obtain the argument list to Convert our audio file to user Specified
        _args = await infoset.converter.getArgumentsList(
          FFmpegArgs.argsToACC,            // Convert to .ogg
          infoset.metadata,                // Use default/custom MetaData
          ActionType.convertAudio,         // Specify the convertion type
          infoset.downloader.lastAudioDownloaded,  // Path to the Audio
          _audioSavePath                   // Path to save the final Audio
        ); if (_args == null) return 1;

        // Start audio convertion using the obtained argument list for FFmpeg use
        infoset.downloader.progressBar.add(null);
        infoset.currentAction.add("Converting...");
        _result = await infoset.converter.convert(_args, ActionType.convertAudio);

        // Move the audio file to the download folder
        // and write all Metadata
        infoset.currentAction.add("Setting Tags & Artwork...");
        String renamedFilePath = _downloadPath + "/" + infoset.metadata.title + ".m4a";
        await File(infoset.converter.lastConvertedAudio).rename(renamedFilePath);
        await writeAllMetadata(renamedFilePath);

        // Finish up
        NativeMethod.registerFile(renamedFilePath);
        infoset.downloadPath = renamedFilePath;
        closeDownload(0);
        return 0;
        // ----------------------------
      } else {
        // ----------------------------
        // Audio-Only Download
        // No Audio convertion
        // ----------------------------
        //
        // Declare our Variables
        int _result; String _audioFormat;

        // Download raw Audio file
        _result = await infoset.downloader.downloadStream(
          infoset.mediaStream,
          DownloadType.audio
        ); if (_result == null) return 1;

        // Get information about our downloaded Media
        _audioFormat = await infoset.converter.getMediaFormat(infoset.downloader.lastAudioDownloaded);

        // Use the appropiate codec extension based on the info from _audioFormat
        if (_audioFormat == "aac") _audioFormat = ".m4a";
        if (_audioFormat == "opus") _audioFormat = ".ogg";

        // Finish up by renaming the final Audio it's
        // original name and removing "tmp" folder
        await File(infoset.downloader.lastAudioDownloaded).rename(_downloadPath + "/" + infoset.metadata.title + _audioFormat);
        NativeMethod.registerFile(_downloadPath + "/" + infoset.metadata.title + _audioFormat); // notice me senpai
        infoset.downloadPath = _downloadPath + "/" + infoset.metadata.title + _audioFormat;
        closeDownload(0);
        return 0;
      }
    }
    // -------
    // Audio
    // -------
    if (infoset.downloadType == DownloadType.video) {
      if (enableConvertion == true) {
        // ----------------------------
        // Video Download
        // With Video convertion
        // ----------------------------
        //
        // Declare our Variables
        // TODO: FIX THIS
        int _result;
        _result = await infoset.downloader.downloadStream(
          infoset.mediaStream,
          DownloadType.audio
        );
        if (_result == null) return 1;
        String _savePath = _downloadPath;
        List<String> _args = await infoset.converter.getArgumentsList(FFmpegArgs.argsToACC,
          infoset.metadata, ActionType.convertAudio, infoset.downloader.lastAudioDownloaded,
          _savePath + "/" + basename(infoset.downloader.lastAudioDownloaded));
        if (_args == null) return 1;
        _result = await infoset.converter.convert(_args, ActionType.convertAudio);
        _result = await infoset.downloader.downloadStream(
          infoset.mediaStream,
          DownloadType.video,
          infoset.videoIndex
        ); if (_result == null) return 1;
        return 0;
      } else {
        // ----------------------------
        // Video Download
        // No video convertion
        // ----------------------------
        //
        // Declare our Variables
        int _result; String _videoFormat;
        List<String> _args; String _audioSavePath;
        String _videoSavePath; String _audioPath;

        // Download raw Video and Audio separately
        infoset.currentAction.add("Downloading Video...");
        // Video
        _result = await infoset.downloader.downloadStream(
          infoset.mediaStream,
          DownloadType.video,
          infoset.videoIndex
        ); if (_result == null) return 1;
        infoset.downloader.downloadFinished = false;
        infoset.downloader.fileSize = infoset.downloader.fileSize + _result;
        infoset.currentAction.add("Downloading Audio...");
        // Audio
        _result = await infoset.downloader.downloadStream(
          infoset.mediaStream,
          DownloadType.audio
        ); if (_result == null) return 1;
        infoset.downloader.fileSize = infoset.downloader.fileSize + _result;

        // Get information about our downloaded Media
        _videoFormat = await infoset.converter.getMediaFormat(infoset.downloader.lastVideoDownloaded);

        // Build the Path for the Audio and final Video to be stored
        _videoSavePath = _downloadPath;
        _videoSavePath = _videoSavePath + "/" + basename(infoset.downloader.lastVideoDownloaded);
        _audioSavePath = _downloadPath;
        _audioSavePath = _audioSavePath + "/tmp/" + basename(infoset.downloader.lastAudioDownloaded);

        // Audio for the video
        _audioPath = infoset.downloader.lastAudioDownloaded;

        // Obtain the argument list to Convert our audio file to .ogg if needed
        if (_videoFormat == "matroska,webm") {
          _args = await infoset.converter.getArgumentsList(
            FFmpegArgs.argsToOGG,                    // Convert to .ogg
            infoset.metadata,                        // Use default/custom MetaData
            ActionType.convertAudio,                 // Specifiy the convertion type
            infoset.downloader.lastAudioDownloaded,  // Path to the audio to be converted
            _audioSavePath                           // Path to be saved converted audio
          ); if (_args == null) return 1;            // Exit if something went wrong

          // Start audio convertion using the obtained argument list for FFmpeg use
          infoset.downloader.progressBar.add(null);
          infoset.currentAction.add("Converting audio...");
          _result = await infoset.converter.convert(_args, ActionType.convertAudio);
          _audioPath = infoset.converter.lastConvertedAudio;
        }

        // Obtain the argument list to paste our
        // converted Audio to the downloaded Video
        _args = await infoset.converter.getArgumentsList(
          FFmpegArgs.argsToMP4,                    // Handle Video
          infoset.metadata,                        // Use default/custom MetaData
          ActionType.encodeAudioToVideo,           // Specify the convertion type
          infoset.downloader.lastVideoDownloaded,  // Path to the Video
          _videoSavePath,                          // Path to be saved final Video
          _videoFormat,                            // Video Format (Typically .webm)
          _audioPath                               // Audio to be encrusted to the video
        ); if (_args == null) return 1;

        // Patch our final video with the previously converted audio using
        // the obtained argument list for FFmpeg use
        infoset.downloader.progressBar.add(null);
        infoset.currentAction.add("Patching Audio...");
        _result = await infoset.converter.convert(_args, ActionType.encodeAudioToVideo);

        // Finish up by renaming the final Video it's
        // original name and removing "tmp" folder
        await File(infoset.converter.lastConvertedVideo).rename(_downloadPath + "/" + infoset.metadata.title + ".webm");
        NativeMethod.registerFile(_downloadPath + "/" + infoset.metadata.title + ".webm");
        infoset.downloadPath = _downloadPath + "/" + infoset.metadata.title + ".webm";
        closeDownload(0);
        return 0;
        // ----------------------------
      }
    }
    return null;
  }

  // Clean up after download
  void closeDownload(int result) {
    if (result == 1) {
      // Download failed


    } else if (result == 0) {
      // Download finished
      infoset.downloader.progressBar.add(1.0);
      infoset.currentAction.add("Done");
      infoset.downloader.progressBar.close();
      infoset.currentAction.close();
      infoset.downloader.dataProgress.close();
    }
  }

  // Write Tags & Artwork
  Future<void> writeAllMetadata(filePath) async {
    await TagsManager.writeAllTags(
      songPath: filePath,
      title: infoset.metadata.title,
      album: infoset.metadata.album,
      artist: infoset.metadata.artist,
      genre: infoset.metadata.genre,
      year: infoset.metadata.date,
      disc: infoset.metadata.disk,
      track: infoset.metadata.track
    );
    await TagsManager.writeArtwork(
      songPath: filePath,
      artworkUrl: infoset.mediaStream.videoDetails.thumbnailSet.maxResUrl
    );
  }
}