// Dart
import 'dart:async';
import 'dart:io';

// Internal
import 'package:songtube/internal/download/audioFilters.dart';
import 'package:songtube/internal/randomString.dart';

// Packages
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';

/// Type of Actions that the [FFmpegConverter] can execute
enum FFmpegTask {
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
    return (await flutterFFprobe.getMediaInformation(mediaFile)).getMediaProperties()["duration"];
  }

  /// Gets the file Extension of any Media [File]
  Future<String> getMediaFormat(String mediaFile) async {
    assert(mediaFile != "" || mediaFile != null);
    String _codec; var _info;
    final streamsInfoArray = (await flutterFFprobe.getMediaInformation(mediaFile))
      .getAllProperties();
    _codec = "${streamsInfoArray['streams'][0]['codec_name']}";
    _info = "${streamsInfoArray['format']['format_name']}";
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
    List<String> _argsList = <String>[];
    String outDir = (await getExternalStorageDirectory()).path + "/";
    File output = File(outDir + RandomString.getRandomString(10));
    String audioFormat = await getMediaFormat(audioPath);
    if (videoFormat == "webm" && audioFormat == "ogg" || videoFormat == "mp4" && audioFormat == "m4a") {
      _argsList = [
        "-y", "-i", "$videoPath", "-i", "$audioPath",
        "-c", "copy", "-map", "0:v:0", "-map", "1:a:0",
        "${output.path}.$videoFormat"
      ];
      output = File(output.path + ".$videoFormat");
    } else if (videoFormat == "mp4") {
      _argsList = [
        "-y", "-i", "$videoPath", "-i", "$audioPath",
        "-c", "copy", "-map", "0:v:0", "-map", "1:a:0",
        "-c:a", "aac", "${output.path}.mp4"
      ];
      output = File(output.path + ".mp4");
    } else if (videoFormat == "webm") {
      _argsList = [
        "-y", "-i", "$videoPath", "-i", "$audioPath",
        "-c", "copy", "-map", "0:v:0", "-map", "1:a:0",
        "-c:a", "libopus", "${output.path}.webm"
      ];
      output = File(output.path + ".webm");
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
    // Try delete old files
    try {
      await File(videoPath).delete();
      await File(audioPath).delete();
    } catch (_) {}
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
    FFmpegTask task,
  }) async {
    assert(audioFile != "" || audioFile != null);
    assert(task != null);
    if (!await audioConversionRequired(task, audioFile)) {
      return File(audioFile);
    }
    List<String> _argsList;
    String outDir = (await getExternalStorageDirectory()).path + "/";
    File output = File(outDir + RandomString.getRandomString(10));
    if (task == FFmpegTask.ConvertToAAC) {
      _argsList = [
        "-y", "-i",
        "$audioFile",
        "-c:a", "aac",
        "-b:a", "256k",
        "${output.path}.m4a",
      ];
      output = File(output.path + ".m4a");
    }
    if (task == FFmpegTask.ConvertToOGG) {
      _argsList = [
        "-y", "-i", "$audioFile", "-c:a", "libopus",
        "-b:a", "256k", "-vbr", "on", "-compression_level", "10",
        "${output.path}.ogg"
      ];
      output = File(output.path + ".ogg");
    }
    if (task == FFmpegTask.ConvertToOGGVorbis) {
      _argsList = [
        "-y", "-i", "$audioFile",
        "-c:a", "libvorbis", "-b:a", "256k",
        "${output.path}.ogg"
      ];
      output = File(output.path + ".ogg");
    }
    if (task == FFmpegTask.ConvertToMP3) {
      _argsList = [
        "-y", "-i", "$audioFile",
        "-c:a", "libmp3lame", "-b:a", "256k",
        "${output.path}.mp3"
      ];
      output = File(output.path + ".mp3");
    }
    if (task == FFmpegTask.NONE) {
      return File(audioFile);
    }
    int _result = await flutterFFmpeg.executeWithArguments(_argsList);
    if (_result == 1)
      throw Exception(
        "An issue ocurred trying to convert audio File\n" +
        "audioFile: $audioFile\n" +
        "format: $task\n" +
        "argument list: $_argsList\n" +
        "output path: $output"
      );
    await File(audioFile).delete();
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
    AudioFilters audioModifiers
  ) async {
    assert(audioPath != "" || audioPath != null);
    assert(audioModifiers != null);
    if (audioModifiers == null) return File(audioPath);
    String outDir = (await getExternalStorageDirectory()).path + "/";
    String format = await getMediaFormat(audioPath);
    File output = File(outDir +
      RandomString.getRandomString(10) + ".$format");
    List<String> _argsList = [
      "-y", "-i",
      "$audioPath",
      "-filter_complex", "[0:a]volume=${audioModifiers.volume}[volume]; "+
      "[volume]bass=g=${audioModifiers.bassGain}[bass]; " +
      "[bass]treble=g=${audioModifiers.trebleGain}",
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
    await File(audioPath).delete();
    return output;
  }

  /// Return a [bool] indicating if the provided [Audio] file needs Conversion
  Future<bool> audioConversionRequired(
    FFmpegTask task,
    String audioFile
  ) async {
    assert(audioFile != "" || audioFile != null);
    assert(task != null);
    String format = await getMediaFormat(audioFile);
    if (task == FFmpegTask.ConvertToAAC)
      return format == "m4a" ? false : true;
    else if (task == FFmpegTask.ConvertToOGGVorbis)
      return format == "ogg" ? false : true;
    else if (task == FFmpegTask.NONE)
      return false;
    else
      return true;
  }

  /// Clear all [Metadata] of any provided [Audio] file, useful if you cannot
  /// write your own [Metadata] because the [Audio] file already contains an
  /// incompatible one
  Future<File> clearFileMetadata(String audioFile) async {
    assert(audioFile != "" || audioFile != null);
    String outDir = (await getExternalStorageDirectory()).path + "/";
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
    return output;
  }

  /// Normalize any [Audio] file using FFmpeg's dynaudnorm
  Future<File> normalizeAudio(String audioFile) async {
    assert(audioFile != "" || audioFile != null);
    String outDir = (await getExternalStorageDirectory()).path + "/";
    String fileFormat = await getMediaFormat(audioFile);
    File output = File(outDir + RandomString.getRandomString(10) + ".$fileFormat");
    List<String> _argsList = [
      "-y", "-i", "$audioFile", "-filter_complex",
      "[0:a]dynaudnorm", "${output.path}"
    ];
    int _result = await flutterFFmpeg.executeWithArguments(_argsList);
    if (_result == 1)
      throw Exception(
        "Audio Normalization Failed\n"
        "audioFile: $audioFile\n"
        "argument list: $_argsList\n"
        "output: $output"
      );
    await File(audioFile).delete();
    return output;
  }

  /// Extracts a specific part from any audio file from start to end duration
  /// and returns a new File
  Future<File> extractAudio(String audioFile, int start, int end) async {
    assert(audioFile != "" || audioFile != null);
    String outDir = (await getExternalStorageDirectory()).path + "/";
    String fileFormat = await getMediaFormat(audioFile);
    File output = File(outDir + RandomString.getRandomString(10) + ".$fileFormat");
    List<String> _argsList = [
      "-y", "-i", "$audioFile", "-ss", "$start", "-to",
      "$end", "-c", "copy", "${output.path}"
    ];
    int _result = await flutterFFmpeg.executeWithArguments(_argsList);
    if (_result == 1)
      throw Exception(
        "Audio Extraction Failed\n"
        "audioFile: $audioFile\n"
        "argument list: $_argsList\n"
        "output: $output"
      );
    return output;
  }

}