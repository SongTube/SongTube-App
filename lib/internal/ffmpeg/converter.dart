// Dart
import 'dart:async';
import 'dart:io';

// Internal
import 'package:songtube/internal/models/audioModifiers.dart';
import 'package:songtube/internal/randomString.dart';

// Packages
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';

/// Type of Actions that the [FFmpegConverter] can execute
enum FFmpegActionType {
  ConvertToAAC,
  ConvertToOGG,
  ConvertToOGGVorbis,
  ConvertToMP3,
  AppendAudioOnVideo,
  NONE
}

/// FFmpeg Converter which can convert any given Audio file to another desired
/// format or append any given Audio file to a Video
class FFmpegConverter {
  
  // Declare our FFmpeg instances
  FlutterFFmpeg flutterFFmpeg;
  FlutterFFprobe flutterFFprobe;
  FlutterFFmpegConfig ffconfig;
  // Initialize FFmpegConverter
  FFmpegConverter() {
    flutterFFmpeg = new FlutterFFmpeg();
    flutterFFprobe = new FlutterFFprobe();
    ffconfig = new FlutterFFmpegConfig();
  }

  /// Gets the [Duration] of the Audio file provided
  Future<String> getMediaDuration(String mediaFile) async {
    assert(mediaFile != "" || mediaFile != null);
    if (!await File(mediaFile).exists()) return null;
    return (await flutterFFprobe.getMediaInformation(mediaFile))["duration"];
  }

  /// Gets the file Extension of any Media [File]
  Future<String> getMediaFormat(String mediaFile) async {
    assert(mediaFile != "" || mediaFile != null);
    var _info; String _codec;
    _info = await flutterFFprobe.getMediaInformation(mediaFile);
    final streamsInfoArray = _info['streams'];
    _codec = "${streamsInfoArray[0]['codec']}";
    _info = "${_info['format']}";
    if (_codec == "aac") return "m4a";
    if (_codec == "opus") return "ogg";
    if (_codec == "mp3") return "mp3";
    if (_info == "matroska,webm") return "webm";
    if (_info == "mov,mp4,m4a,3gp,3g2,mj2") return "mp4";
    return _info;
  }

  /// Append any [Audio] to any [Video], this Function automatically
  /// converts the [Audio] to the compatible format of the [Video]
  /// (only if it's needed)
  Future<File> writeAudioToVideo({
    String videoFormat,
    String videoPath,
    String audioPath,
  }) async {
    assert(videoFormat != "" || videoFormat != null);
    assert(videoPath != "" || videoPath != null);
    assert(audioPath != "" || audioPath != null);
    List<String> _argsList;
    String outDir = (await getTemporaryDirectory()).path + "/";
    File output = File(outDir + RandomString.getRandomString(10));
    if (videoFormat == "matroska,webm") {
      _argsList = [
        "-y", "-i", "$videoPath", "-i", "$audioPath",
        "-c:v", "copy", "-c:a", "libopus", "-map", "0:v:0", "-map", "1:a:0",
        "${output.path}.webm"
      ];
      output = File(output.path + ".webm");
    }
    if (videoFormat == "mov,mp4,m4a,3gp,3g2,mj2") {
      _argsList = [
        "-y", "-i", "$videoPath", "-i", "$audioPath",
        "-c:v", "copy", "-c:a", "aac", "-map", "0:v:0", "-map", "1:a:0",
        "${output.path}.mp4"
      ];
      output = File(output.path + ".mp4");
    }
    int _result = await flutterFFmpeg.executeWithArguments(_argsList);
    if (_result == 1)
      throw Exception(
        "An issue ocurred trying to append audio to video\n" +
        "videoFile: $videoPath\n"
        "audioFile: $audioPath\n" +
        "format: $videoFormat\n" +
        "argument list: $_argsList\n" +
        "output path: $output"
      );
    return output;
  }

  /// Converts [Audio] to any provided [FFmpegFormatType], if the [Audio] and
  /// the [FFmpegFormatType] both have the same Format, no changes will be done
  /// and the Function will return the same [audioPath] provided
  /// 
  /// Converting to anything provided will set the conversion bitrate to 256k
  /// to avoid any quality loss
  Future<File> convertAudio({
    String audioFile,
    FFmpegActionType format,
  }) async {
    assert(audioFile != "" || audioFile != null);
    assert(format != null);
    if (!await audioConversionRequired(format, audioFile)) {
      return File(audioFile);
    }
    List<String> _argsList;
    String outDir = (await getTemporaryDirectory()).path + "/";
    File output = File(outDir + RandomString.getRandomString(10));
    if (format == FFmpegActionType.ConvertToAAC) {
      _argsList = [
        "-y", "-i",
        "$audioFile",
        "-c:a", "aac",
        "-b:a", "256k",
        "${output.path}.m4a",
      ];
      output = File(output.path + ".m4a");
    }
    if (format == FFmpegActionType.ConvertToOGG) {
      _argsList = [
        "-y", "-i", "$audioFile", "-c:a", "libopus",
        "-b:a", "256k", "-vbr", "on", "-compression_level", "10",
        "${output.path}.ogg"
      ];
      output = File(output.path + ".ogg");
    }
    if (format == FFmpegActionType.ConvertToOGGVorbis) {
      _argsList = [
        "-y", "-i", "$audioFile",
        "-c:a", "libvorbis", "-b:a", "256k",
        "${output.path}.ogg"
      ];
      output = File(output.path + ".ogg");
    }
    if (format == FFmpegActionType.ConvertToMP3) {
      _argsList = [
        "-y", "-i", "$audioFile",
        "-c:a", "libmp3lame", "-b:a", "256k",
        "${output.path}.mp3"
      ];
      output = File(output.path + ".mp3");
    }
    int _result = await flutterFFmpeg.executeWithArguments(_argsList);
    if (_result == 1)
      throw Exception(
        "An issue ocurred trying to convert audio File\n" +
        "audioFile: $audioFile\n" +
        "format: $format\n" +
        "argument list: $_argsList\n" +
        "output path: $output"
      );
    return output;
  }

  /// Apply the provided [AudioModifiers] to any provided [Audio] file,
  /// these changes can be Volume, Bass or Treble, if the provided
  /// [AudioModifiers] is null, no changes will be made and this
  /// function will return the provided [AudioPath]
  /// 
  /// On failure this function will return [null]
  Future<File> applyAudioModifiers(
    String audioPath,
    AudioModifiers audioModifiers
  ) async {
    assert(audioPath != "" || audioPath != null);
    assert(audioModifiers != null);
    if (audioModifiers == null) return File(audioPath);
    String outDir = (await getTemporaryDirectory()).path + "/";
    String format = await getMediaFormat(audioPath);
    File output = File(outDir +
      RandomString.getRandomString(10) + ".$format");
    List<String> _argsList = [
      "-y", "-i",
      "$audioPath",
      "-af", "volume=${audioModifiers.volume}, "+
      "bass=g=${audioModifiers.bassGain}, " +
      "treble=g=${audioModifiers.trebleGain}",
      "${output.path}",
    ];
    int _result = await flutterFFmpeg.executeWithArguments(_argsList);
    if (_result == 1)
      throw Exception(
        "Cannot apply AudioModifiers\n" +
        "audioFile: $audioPath\n" +
        "audioModifiers: v=${audioModifiers.volume} " +
        "b=${audioModifiers.bassGain} t=${audioModifiers.trebleGain}\n" +
        "argument list: $_argsList\n" +
        "output: $output",
      );
    return output;
  }

  /// Return a [bool] indicating if the provided [Audio] file needs Conversion
  Future<bool> audioConversionRequired(
    FFmpegActionType convertFormat,
    String audioFile
  ) async {
    assert(audioFile != "" || audioFile != null);
    assert(convertFormat != null);
    String format = await getMediaFormat(audioFile);
    if (convertFormat == FFmpegActionType.ConvertToAAC)
      return format == "m4a" ? false : true;
    else if (convertFormat == FFmpegActionType.ConvertToOGGVorbis)
      return format == "ogg" ? false : true;
    else
      return true;
  }

  /// Clear all [Metadata] of any provided [Audio] file, useful if you cannot
  /// write your own [Metadata] because the [Audio] file already contains an
  /// incompatible one
  Future<File> clearFileMetadata(String audioFile) async {
    assert(audioFile != "" || audioFile != null);
    String outDir = (await getTemporaryDirectory()).path + "/";
    String fileFormat = await getMediaFormat(audioFile);
    File output = File(outDir + RandomString.getRandomString(10) + ".$fileFormat");
    List<String> _argsList = [
      "-i", "$audioFile", "-map", "0:a", "-codec:a",
      "copy", "-map_metadata", "-1", "${output.path}",
    ];
    int _result = await flutterFFmpeg.executeWithArguments(_argsList);
    if (_result == 1)
      throw Exception(
        "Cannot Clear Metadata\n" +
        "audioFile: $audioFile\n" +
        "argument list: $_argsList\n" +
        "output: $output",
      );
    await File(audioFile).delete();
    output = await output.rename(audioFile);
    return output;
  }

}