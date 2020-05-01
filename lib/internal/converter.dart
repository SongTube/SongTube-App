import 'dart:io';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:songtube/internal/songtube_classes.dart';

// Type of actions for FFmpegArgs and Converter
enum FFmpegArgs { argsToACC, argsToMP4, argsToOGG }
enum ActionType { convertAudio, convertVideo, encodeAudioToVideo }

class Converter {
  
  // Declare our FFmpeg instances
  final FlutterFFmpeg flutterFFmpeg = new FlutterFFmpeg();
  final FlutterFFprobe flutterFFprobe = new FlutterFFprobe();

  String _tempFolder;
  String lastConvertedVideo;
  String lastConvertedAudio;

  Converter() {
    _getTempFolder();
  }

  void _getTempFolder() async {
    _tempFolder = await ExternalPath().externalStorage;
    _tempFolder = _tempFolder + "/" + "tmp";
    if (!(await Directory(_tempFolder).exists())) {
      await Directory(_tempFolder).create();
    }
  }

  // Get the exact information about a provided Video file
  Future<String> getMediaFormat(String videoPath) async {
    var _info; String _codec;
    _info = await flutterFFprobe.getMediaInformation(videoPath);
    final streamsInfoArray = _info['streams'];
    _codec = "${streamsInfoArray[0]['codec']}";
    if (_codec == "aac") return _codec;
    if (_codec == "opus") return _codec;
    _info = "${_info['format']}";
    return _info;
  }

  // Get the data we need before declaring our Argument lists
  Future<List<String>> getArgumentsList(FFmpegArgs type, MediaMetaData metadata,
    ActionType downType, String filePath, String savePath, [String saveFormat, String audioPath]) async {

    List<String> _argsList;

    // Encode audio to Video, requires the audioPath to be provided
    if (downType == ActionType.encodeAudioToVideo && audioPath != null) {
      if (saveFormat == "matroska,webm") {
        _argsList = [
          "-y", "-i", "$filePath", "-i", "$audioPath",
          "-c", "copy", "-map", "0:v:0", "-map", "1:a:0",
          "$savePath.webm"
        ];
        return _argsList;
      }
      if (saveFormat == "mov,mp4,m4a,3gp,3g2,mj2") {
        _argsList = [
          "-y", "-i", "$filePath", "-i", "$audioPath",
          "-c", "copy", "-map", "0:v:0", "-map", "1:a:0",
          "$savePath.mp4"
        ];
        return _argsList;
      }
    }
    // Convert video to Specified format by FFmpegArgs
    if (downType == ActionType.convertVideo) {
      if (type == FFmpegArgs.argsToMP4) {
        _argsList = [
          "-y", "-i", "$filePath",
          "-q:v", "1", "$savePath.mp4"
        ];
        return _argsList;
      }
    }

    // Convert audio to Specified format by FFmpegArgs
    if (downType == ActionType.convertAudio) {
      if (type == FFmpegArgs.argsToACC) {
        _argsList = [
          "-y", "-i",
          "$filePath",
          "-c:a", "aac",
          "-profile:a", "aac_low",
          "-metadata", "title=${metadata.title}",
          "-metadata", "album=${metadata.album}",
          "-metadata", "artist=${metadata.artist}",
          "-metadata", "genre=${metadata.genre}",
          "-metadata", "date=${metadata.date}",
          "-metadata", "disk=${metadata.disk}",
          "-metadata", "track=${metadata.track}",
          "$savePath.m4a",
        ];
        return _argsList;
      }
      if (type == FFmpegArgs.argsToOGG) {
        _argsList = [
          "-y", "-i", "$filePath", "-c:a", "libopus",
          "-b:a", "128k", "-vbr", "on", "-compression_level", "10",
          "$savePath.ogg"
        ];
        return _argsList;
      }
    }
    return null;
  }

  // Functions to convert media
  Future<int> convert(List<String> arguments, ActionType downType) async {
    appdata.progressController.add(null);
    appdata.currentAction.add(CurrentAction.converting);
    if (downType == ActionType.convertAudio) lastConvertedAudio = arguments.last;
    if (downType == ActionType.convertVideo) lastConvertedVideo = arguments.last;
    if (downType == ActionType.encodeAudioToVideo) lastConvertedVideo = arguments.last;
    print("Converter: Starting audio file convertion...");
    int _result;
    await flutterFFmpeg.executeWithArguments(arguments).then(
      (value) {
        _result = value;
      }
    );
    appdata.progressController.add(0.0);
    appdata.currentAction.add(CurrentAction.none);
    return _result;
  }

}