// Dart
import 'dart:io';

// Internal
import 'package:ext_storage/ext_storage.dart';

// Packages
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

// Type of actions for FFmpegArgs and Converter
enum FFmpegArgs { argsToACC, argsToMP4, argsToOGG, argsToOGGVorbis, argsToMP3 }
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
    _tempFolder = await ExtStorage.getExternalStorageDirectory();
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
  Future<List<String>> getArgumentsList({
    FFmpegArgs type, ActionType actionType, String filePath,
    String savePath, String saveFormat, String audioPath, List audioModifiers
  }) async {

    List<String> _argsList;

    // Encode audio to Video, requires the audioPath to be provided
    if (actionType == ActionType.encodeAudioToVideo && audioPath != null) {
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

    // Convert audio to Specified format by FFmpegArgs
    if (actionType == ActionType.convertAudio) {
      if (type == FFmpegArgs.argsToACC) {
        _argsList = [
          "-y", "-i",
          "$filePath",
          "-c:a", "aac",
          "-b:a", "256k",
          "-af", "volume=${audioModifiers[0]}, bass=g=${audioModifiers[1]}, treble=g=${audioModifiers[2]}",
          "$savePath.m4a",
        ];
        return _argsList;
      }
      if (type == FFmpegArgs.argsToOGG) {
        _argsList = [
          "-y", "-i", "$filePath", "-c:a", "libopus",
          "-b:a", "256k", "-vbr", "on", "-compression_level", "10",
          "$savePath.ogg"
        ];
        return _argsList;
      }
      if (type == FFmpegArgs.argsToOGGVorbis) {
        _argsList = [
          "-y", "-i", "$filePath",
          "-c:a", "libvorbis", "-b:a", "256k",
          "-af", "volume=${audioModifiers[0]}, bass=g=${audioModifiers[1]}, treble=g=${audioModifiers[2]}",
          "$savePath.ogg"
        ];
        return _argsList;
      }
      if (type == FFmpegArgs.argsToMP3) {
        _argsList = [
          "-y", "-i", "$filePath",
          "-c:a", "libmp3lame", "-b:a", "256k",
          "-af", "volume=${audioModifiers[0]}, bass=g=${audioModifiers[1]}, treble=g=${audioModifiers[2]}",
          "$savePath.mp3"
        ];
        return _argsList;
      }
    }
    return null;
  }

  // Functions to convert media
  Future<int> convert(List<String> arguments, ActionType downType) async {
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
    return _result;
  }

}