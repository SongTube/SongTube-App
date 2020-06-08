// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:ext_storage/ext_storage.dart';
import 'package:path/path.dart';
import 'package:songtube/internal/database/infoset_database.dart';
import 'package:songtube/internal/database/models/downloaded_file.dart';

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
    String tmpPath = await ExtStorage.getExternalStorageDirectory() + "/SongTube/tmp";
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
            DownloadType.audio,
          );
        } on Exception catch (_) {
          print(_.toString());
        } if (_result == null) {closeDownload(1); return 1;}

        // Build the Path for the Audio to be stored
        _audioSavePath = infoset.downloadPath + "/" + basename(infoset.downloader.lastAudioDownloaded);

        // Obtain the argument list to Convert our audio file to user Specified
        _args = await infoset.converter.getArgumentsList(
          type: infoset.convertFormat,                      // Convert to specified format
          actionType: ActionType.convertAudio,              // Specify the convertion type
          filePath: infoset.downloader.lastAudioDownloaded, // Path to the Audio
          savePath: _audioSavePath,                         // Path to save the final Audio
          audioModifiers: infoset.audioModifiers            // Audio Volume/Bass/Treble Modifiers
        ); if (_args == null) return 1;

        // Start audio convertion using the obtained argument list for FFmpeg use
        infoset.downloader.progressBar.add(null);
        infoset.currentAction.add("Converting...");
        _result = await infoset.converter.convert(_args, ActionType.convertAudio);

        // Get format extension
        String format;
        if (infoset.convertFormat == FFmpegArgs.argsToACC) format = ".m4a";
        if (infoset.convertFormat == FFmpegArgs.argsToOGGVorbis) format = ".ogg";
        if (infoset.convertFormat == FFmpegArgs.argsToMP3) format = ".mp3";

        // Move the audio file to the download folder
        // and write all Metadata
        infoset.currentAction.add("Setting Tags & Artwork...");
        String renamedFilePath = infoset.downloadPath + "/" + infoset.metadata.title + format;
        await File(infoset.converter.lastConvertedAudio).rename(renamedFilePath);
        await writeAllMetadata(renamedFilePath);

        // Finish up
        NativeMethod.registerFile(renamedFilePath);
        infoset.downloadPath = renamedFilePath;
        infoset.downloadFinished = true;
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
          DownloadType.audio,
        ); if (_result == null) {closeDownload(1); return 1;}

        // Get information about our downloaded Media
        _audioFormat = await infoset.converter.getMediaFormat(infoset.downloader.lastAudioDownloaded);

        // Use the appropiate codec extension based on the info from _audioFormat
        if (_audioFormat == "aac") _audioFormat = ".m4a";
        if (_audioFormat == "opus") _audioFormat = ".ogg";

        // Finish up by renaming the final Audio it's
        // original name and removing "tmp" folder
        String downloadPath = infoset.downloadPath + "/" + infoset.metadata.title + _audioFormat;
        await File(infoset.downloader.lastAudioDownloaded).rename(downloadPath);
        NativeMethod.registerFile(downloadPath); // notice me senpai
        infoset.downloadPath = downloadPath;
        infoset.downloadFinished = true;
        closeDownload(0);
        return 0;
      }
    }
    // -------
    // Video
    // -------
    if (infoset.downloadType == DownloadType.video) {
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
      ); if (_result == null) {closeDownload(1); return 1;}
      infoset.downloader.downloadFinished = false;
      infoset.downloader.fileSize = infoset.downloader.fileSize + _result;
      infoset.currentAction.add("Downloading Audio...");
      // Audio
      _result = await infoset.downloader.downloadStream(
        infoset.mediaStream,
        DownloadType.audio,
      ); if (_result == null) {closeDownload(1); return 1;}
      infoset.downloader.fileSize = infoset.downloader.fileSize + _result;

      // Get information about our downloaded Media
      _videoFormat = await infoset.converter.getMediaFormat(infoset.downloader.lastVideoDownloaded);

      // Build the Path for the Audio and final Video to be stored
      _videoSavePath = infoset.downloadPath + "/" + basename(infoset.downloader.lastVideoDownloaded);
      _audioSavePath = tmpPath + basename(infoset.downloader.lastAudioDownloaded);

      // Audio for the video
      _audioPath = infoset.downloader.lastAudioDownloaded;

      // Obtain the argument list to Convert our audio file to .ogg if needed
      if (_videoFormat == "matroska,webm") {
        _args = await infoset.converter.getArgumentsList(
          type: FFmpegArgs.argsToOGG,                       // Convert to .ogg
          actionType: ActionType.convertAudio,              // Specifiy the convertion type
          filePath: infoset.downloader.lastAudioDownloaded, // Path to the audio to be converted
          savePath: _audioSavePath,                         // Path to be saved converted audio
          audioModifiers: infoset.audioModifiers            // Audio Volume/Bass/Treble Modifiers
        ); if (_args == null) return 1;                     // Exit if something went wrong
      }
      if (_videoFormat == "mov,mp4,m4a,3gp,3g2,mj2") {
        _args = await infoset.converter.getArgumentsList(
          type: FFmpegArgs.argsToACC,
          actionType: ActionType.convertAudio,
          filePath: infoset.downloader.lastAudioDownloaded,
          savePath: _audioSavePath,
          audioModifiers: infoset.audioModifiers            // Audio Volume/Bass/Treble Modifiers
        ); if (_args == null) return 1;
      }
      // Start audio convertion using the obtained argument list for FFmpeg use
      infoset.downloader.progressBar.add(null);
      infoset.currentAction.add("Converting audio...");
      _result = await infoset.converter.convert(_args, ActionType.convertAudio);
      _audioPath = infoset.converter.lastConvertedAudio;

      // Obtain the argument list to paste our
      // converted Audio to the downloaded Video
      _args = await infoset.converter.getArgumentsList(
        type: FFmpegArgs.argsToMP4,                       // Handle Video
        actionType: ActionType.encodeAudioToVideo,        // Specify the convertion type
        filePath: infoset.downloader.lastVideoDownloaded, // Path to the Video
        savePath: _videoSavePath,                         // Path to be saved final Video
        saveFormat: _videoFormat,                         // Video Format (Typically .webm)
        audioPath: _audioPath                             // Audio to be encrusted to the video
      ); if (_args == null) return 1;

      // Patch our final video with the previously converted audio using
      // the obtained argument list for FFmpeg use
      infoset.downloader.progressBar.add(null);
      infoset.currentAction.add("Patching Audio...");
      _result = await infoset.converter.convert(_args, ActionType.encodeAudioToVideo);

      // Finish up by renaming the final Video it's
      // original name and removing "tmp" folder
      String downloadPath = infoset.downloadPath + "/" + infoset.metadata.title + ".webm";
      await File(infoset.converter.lastConvertedVideo).rename(downloadPath);
      NativeMethod.registerFile(downloadPath);
      infoset.downloadPath = downloadPath;
      infoset.downloadFinished = true;
      closeDownload(0);
      return 0;
      // ----------------------------
    }
    return null;
  }

  // Clean up after download
  void closeDownload(int result) async {
    if (result == 1) {
      // Download failed
      infoset.downloader.progressBar.add(0.0);
      infoset.currentAction.add("Cancelled");
      infoset.downloader.progressBar.close();
      infoset.currentAction.close();
      infoset.downloader.dataProgress.close();
    } else if (result == 0) {
      // Download finished
      final dbHelper = DatabaseService.instance;
      await dbHelper.insertDownload(new DownloadedFile.toDatabase(
        title: infoset.metadata.title,
        author: infoset.metadata.artist,
        downloadType: infoset.downloadType == DownloadType.audio
          ? "Audio"
          : "Video",
        fileSize: infoset.downloader.fileSize.toString(),
        coverUrl: infoset.metadata.coverurl,
        path: infoset.downloadPath
      ));
      infoset.downloader.progressBar.add(1.0);
      infoset.currentAction.add("Done");
      infoset.downloader.progressBar.close();
      infoset.currentAction.close();
      infoset.downloader.dataProgress.close();
    }
  }

  // Write Tags & Artwork
  Future<void> writeAllMetadata(filePath) async {
    try {
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
    } on Exception catch (e) {
      print(e);
    }
  }
}