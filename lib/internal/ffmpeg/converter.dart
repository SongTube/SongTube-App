// Dart
import 'dart:async';
import 'dart:io';

// Internal
import 'package:songtube/internal/models/audioModifiers.dart';
import 'package:songtube/internal/randomString.dart';

// Packages
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';

// Type of actions for FFmpegArgs and Converter
enum AudioConvert { ToAAC, ToOGG, ToOGGVorbis, ToMP3, WriteAudio, NONE }

class Converter {
  
  // Declare our FFmpeg instances
  FlutterFFmpeg flutterFFmpeg;
  FlutterFFprobe flutterFFprobe;
  FlutterFFmpegConfig ffconfig;
  // Initialize Converter
  Converter() {
    flutterFFmpeg = new FlutterFFmpeg();
    flutterFFprobe = new FlutterFFprobe();
    ffconfig = new FlutterFFmpegConfig();
  }

  String lastConvertedVideo;
  String lastConvertedAudio;

  // Get duration of the Media provided
  Future<String> getMediaDuration(String mediaPath) async {
    if (!await File(mediaPath).exists()) return null;
    return (await flutterFFprobe.getMediaInformation(mediaPath))["duration"];
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

  // Encode Audio to Video
  Future<File> writeAudioToVideo({
    String saveFormat,
    String videoPath,
    String audioPath,
  }) async {
    List<String> _argsList;
    String outDir = (await getTemporaryDirectory()).path + "/";
    File output = File(outDir + RandomString.getRandomString(10));
    if (saveFormat == "matroska,webm") {
      _argsList = [
        "-y", "-i", "$videoPath", "-i", "$audioPath",
        "-c:v", "copy", "-c:a", "libopus", "-map", "0:v:0", "-map", "1:a:0",
        "${output.path}.webm"
      ];
      output = File(output.path + ".webm");
    }
    if (saveFormat == "mov,mp4,m4a,3gp,3g2,mj2") {
      _argsList = [
        "-y", "-i", "$videoPath", "-i", "$audioPath",
        "-c:v", "copy", "-c:a", "aac", "-map", "0:v:0", "-map", "1:a:0",
        "${output.path}.mp4"
      ];
      output = File(output.path + ".mp4");
    }
    int _result = await flutterFFmpeg.executeWithArguments(_argsList);
    if (_result == 1) return null;
    return output;
  }

  // Convert Audio
  Future<File> convertAudio({
    String audioPath,
    AudioConvert format,
    AudioModifiers audioModifiers
  }) async {
    List<String> _argsList;
    String outDir = (await getTemporaryDirectory()).path + "/";
    File output = File(outDir + RandomString.getRandomString(10));
    if (format == AudioConvert.ToAAC) {
      _argsList = [
        "-y", "-i",
        "$audioPath",
        "-c:a", "aac",
        "-b:a", "256k",
        "-af", "volume=${audioModifiers.volume}, "+
        "bass=g=${audioModifiers.bassGain}, " +
        "treble=g=${audioModifiers.trebleGain}",
        "${output.path}.m4a",
      ];
      output = File(output.path + ".m4a");
    }
    if (format == AudioConvert.ToOGG) {
      _argsList = [
        "-y", "-i", "$audioPath", "-c:a", "libopus",
        "-b:a", "256k", "-vbr", "on", "-compression_level", "10",
        "${output.path}.ogg"
      ];
      output = File(output.path + ".ogg");
    }
    if (format == AudioConvert.ToOGGVorbis) {
      _argsList = [
        "-y", "-i", "$audioPath",
        "-c:a", "libvorbis", "-b:a", "256k",
        "-af", "volume=${audioModifiers.volume}, "+
        "bass=g=${audioModifiers.bassGain}, " +
        "treble=g=${audioModifiers.trebleGain}",
        "${output.path}.ogg"
      ];
      output = File(output.path + ".ogg");
    }
    if (format == AudioConvert.ToMP3) {
      _argsList = [
        "-y", "-i", "$audioPath",
        "-c:a", "libmp3lame", "-b:a", "256k",
        "-af", "volume=${audioModifiers.volume}, "+
        "bass=g=${audioModifiers.bassGain}, " +
        "treble=g=${audioModifiers.trebleGain}",
        "${output.path}.mp3"
      ];
      output = File(output.path + ".mp3");
    }
    int _result = await flutterFFmpeg.executeWithArguments(_argsList);
    if (_result == 1) return null;
    return output;
  }

  // Check if audio needs Conversion
  Future<bool> audioConversionRequired(AudioConvert convertFormat, String audioPath) async {
    String format = await getMediaFormat(audioPath);
    if (convertFormat == AudioConvert.ToAAC)
      return format == "aac" ? false : true;
    else if (convertFormat == AudioConvert.ToOGGVorbis)
      return format == "opus" ? false : true;
    else
      return true;
  }

}