import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'native.dart';
import 'songtube_classes.dart';
import 'downloader.dart';
import 'converter.dart';

class ActionHandler {

  Future<void> handleAudioDownload(appData, Downloader downloader, Converter converter, DownloadInfoSet infoset) async {
    if (appData.enableAudioConvertion == true) {
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
        _result = await downloader.downloadAudio(
          infoset.mediaStream,
          infoset.downloadProgress,
          infoset.dataProgress
        );
      } on Exception catch (e) {
        print(e.toString());
      } if (_result == null) return;
      // Build the Path for the Audio to be stored
      _audioSavePath = await appdata.getDefaultDownloadFolder;
      _audioSavePath = _audioSavePath + "/" + basename(downloader.lastAudioDownloaded);

      // Obtain the argument list to Convert our audio file to user Specified
      _args = await converter.getArgumentsList(
        FFmpegArgs.argsToACC,            // Convert to .ogg
        infoset.metadata,                // Use default/custom MetaData
        ActionType.convertAudio,         // Specify the convertion type
        downloader.lastAudioDownloaded,  // Path to the Audio
        _audioSavePath                   // Path to save the final Audio
      ); if (_args == null) return;

      // Start audio convertion using the obtained argument list for FFmpeg use
      infoset.downloadProgress.add(null);
      infoset.currentAction.add("Converting...");
      _result = await converter.convert(_args, ActionType.convertAudio);

      // Finish up by renaming the final Audio it's
      // original name and removing "tmp" folder
      await File(converter.lastConvertedAudio).rename(await appdata.getDefaultDownloadFolder + "/" + infoset.metadata.title + ".m4a");
      NativeMethod.registerFile(await appdata.getDefaultDownloadFolder + "/" + infoset.metadata.title + ".m4a");
      infoset.downloadProgress.add(1.0);
      infoset.currentAction.add("Done");
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
      _result = await downloader.downloadAudio(
        infoset.mediaStream,
        infoset.downloadProgress,
        infoset.dataProgress
      ); if (_result == null) return;

      // Get information about our downloaded Media
      _audioFormat = await converter.getMediaFormat(downloader.lastAudioDownloaded);

      // Use the appropiate codec extension based on the info from _audioFormat
      if (_audioFormat == "aac") _audioFormat = ".m4a";
      if (_audioFormat == "opus") _audioFormat = ".opus";

      // Finish up by renaming the final Audio it's
      // original name and removing "tmp" folder
      await File(downloader.lastAudioDownloaded).rename(await appdata.getDefaultDownloadFolder + "/" + infoset.metadata.title + _audioFormat);
      NativeMethod.registerFile(await appdata.getDefaultDownloadFolder + "/" + infoset.metadata.title + _audioFormat); // notice me senpai
    }
  }

  Future<void> handleVideoDownload(appData, Downloader downloader, Converter converter,
    DownloadInfoSet infoset, int index) async {
    Downloader downloader = new Downloader();
    Converter converter = new Converter();
    if (appData.enableVideoConvertion == true) {
      // ----------------------------
      // Video Download
      // With Video convertion
      // ----------------------------
      //
      // Declare our Variables
      // TODO: FIX THIS
      int _result;
      _result = await downloader.downloadAudio(
        infoset.mediaStream,
        infoset.downloadProgress,
        infoset.dataProgress
      );
      if (_result == null) return;
      String _savePath = await appdata.getDefaultDownloadFolder;
      List<String> _args = await converter.getArgumentsList(FFmpegArgs.argsToACC,
        defaultMetaData, ActionType.convertAudio, downloader.lastAudioDownloaded,
        _savePath + "/" + basename(downloader.lastAudioDownloaded));
      if (_args == null) return;
      _result = await converter.convert(_args, ActionType.convertAudio);
      _result = await downloader.downloadVideo(
        infoset.mediaStream,
        index,
        infoset.downloadProgress,
        infoset.dataProgress
      ); if (_result == null) return;
      
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
      _result = await downloader.downloadVideo(
        infoset.mediaStream,
        index,
        infoset.downloadProgress,
        infoset.dataProgress
      ); if (_result == null) return;
      infoset.currentAction.add("Downloading Audio...");
      _result = await downloader.downloadAudio(
        infoset.mediaStream,
        infoset.downloadProgress,
        infoset.dataProgress
      ); if (_result == null) return;

      // Get information about our downloaded Media
      _videoFormat = await converter.getMediaFormat(downloader.lastVideoDownloaded);

      // Build the Path for the Audio and final Video to be stored
      _videoSavePath = await appdata.getDefaultDownloadFolder;
      _videoSavePath = _videoSavePath + "/" + basename(downloader.lastVideoDownloaded);
      _audioSavePath = await appdata.getDefaultDownloadFolder;
      _audioSavePath = _audioSavePath + "/tmp/" + basename(downloader.lastAudioDownloaded);

      // Audio for the video
      _audioPath = downloader.lastAudioDownloaded;

      // Obtain the argument list to Convert our audio file to .ogg if needed
      if (_videoFormat == "matroska,webm") {
        _args = await converter.getArgumentsList(
          FFmpegArgs.argsToOGG,            // Convert to .ogg
          infoset.metadata,                // Use default/custom MetaData
          ActionType.convertAudio,         // Specifiy the convertion type
          downloader.lastAudioDownloaded,  // Path to the audio to be converted
          _audioSavePath                   // Path to be saved converted audio
        ); if (_args == null) return;      // Exit if something went wrong

        // Start audio convertion using the obtained argument list for FFmpeg use
        infoset.currentAction.add("Converting audio...");
        _result = await converter.convert(_args, ActionType.convertAudio);
        _audioPath = converter.lastConvertedAudio;
      }

      // Obtain the argument list to paste our
      // converted Audio to the downloaded Video
      _args = await converter.getArgumentsList(
        FFmpegArgs.argsToMP4,            // Handle Video
        infoset.metadata,                // Use default/custom MetaData
        ActionType.encodeAudioToVideo,   // Specify the convertion type
        downloader.lastVideoDownloaded,  // Path to the Video
        _videoSavePath,                  // Path to be saved final Video
        _videoFormat,                    // Video Format (Typically .webm)
        _audioPath                       // Audio to be encrusted to the video
      ); if (_args == null) return;

      // Patch our final video with the previously converted audio using
      // the obtained argument list for FFmpeg use
      infoset.downloadProgress.add(null);
      infoset.currentAction.add("Patching Audio...");
      _result = await converter.convert(_args, ActionType.encodeAudioToVideo);

      // Finish up by renaming the final Video it's
      // original name and removing "tmp" folder
      await File(converter.lastConvertedVideo).rename(await appdata.getDefaultDownloadFolder + "/" + infoset.metadata.title + ".webm");
      NativeMethod.registerFile(await appdata.getDefaultDownloadFolder + "/" + infoset.metadata.title + ".webm");
      infoset.downloadProgress.add(1.0);
      infoset.currentAction.add("Done");
      // ----------------------------
    }
  }
}