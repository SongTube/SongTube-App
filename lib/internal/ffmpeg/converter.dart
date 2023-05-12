// Dart
import 'dart:async';
import 'dart:io';

// Packages
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:songtube/internal/ffmpeg/filters.dart';
import 'package:songtube/internal/media_utils.dart';

/// Type of Actions that the [FFmpegConverter] can execute
enum FFmpegTask {
  convertToAAC,
  convertToOGG,
  convertToOGGVorbis,
  convertToMP3,
  appendAudioOnVideo,
  none
}

// Declare our FFmpeg instances
FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
FlutterFFprobe flutterFFprobe = FlutterFFprobe();
FlutterFFmpegConfig ffconfig = FlutterFFmpegConfig();

/// FFmpeg Converter which can convert any given Audio file to another desired
/// format or append any given Audio file to a Video
class FFmpegConverter {

  /// Gets the [Duration] of the Audio file provided
  static Future<String?> getMediaDuration(String mediaFile) async {
    assert(mediaFile != "");
    if (!await File(mediaFile).exists()) return null;
    return (await flutterFFprobe.getMediaInformation(mediaFile)).getMediaProperties()!["duration"];
  }

  /// Gets the file Extension of any Media [File]
  static Future<String?> getMediaFormat(String mediaFile) async {
    assert(mediaFile != "");
    String? codec;
    final streamsInfoArray = (await flutterFFprobe.getMediaInformation(mediaFile))
      .getAllProperties();
    if (streamsInfoArray == null) {
      return null;
    }
    codec = "${streamsInfoArray['streams'][0]['codec_name']}";
    final info = "${streamsInfoArray['format']['format_name']}";
    if (codec == "aac") return "m4a";
    if (codec == "opus") return "ogg";
    if (codec == "mp3") return "mp3";
    if (info == "matroska,webm") return "webm";
    if (info == "mov,mp4,m4a,3gp,3g2,mj2") return "mp4";
    return info;
  }

  /// Append any [Audio] to any [Video], this Function automatically
  /// converts the [Audio] to the compatible format of the [Video]
  /// (only if it's needed)
  static Future<File> writeAudioToVideo({
    required String videoPath,
    required String audioPath,
  }) async {
    assert(videoPath != "");
    assert(audioPath != "");
    List<String> argsList = <String>[];
    String outDir = "${(await getExternalStorageDirectory())!.path}/";
    File output = File(outDir + MediaUtils.getRandomString(10));
    String videoFormat = (await getMediaFormat(videoPath))!;
    String? audioFormat = await getMediaFormat(audioPath);
    if (videoFormat == "webm" && audioFormat == "ogg" || videoFormat == "mp4" && audioFormat == "m4a") {
      argsList = [
        "-y", "-i", videoPath, "-i", audioPath,
        "-c", "copy", "-map", "0:v:0", "-map", "1:a:0",
        "${output.path}.$videoFormat"
      ];
      output = File("${output.path}.$videoFormat");
    } else if (videoFormat == "mp4") {
      argsList = [
        "-y", "-i", videoPath, "-i", audioPath,
        "-c", "copy", "-map", "0:v:0", "-map", "1:a:0",
        "-c:a", "aac", "${output.path}.mp4"
      ];
      output = File("${output.path}.mp4");
    } else if (videoFormat == "webm") {
      argsList = [
        "-y", "-i", videoPath, "-i", audioPath,
        "-c", "copy", "-map", "0:v:0", "-map", "1:a:0",
        "-c:a", "libopus", "${output.path}.webm"
      ];
      output = File("${output.path}.webm");
    }
    int? result = await flutterFFmpeg.executeWithArguments(argsList);
    if (result == 1) {
      throw Exception(
        "An issue ocurred trying to append audio to video\nvideoFile: $videoPath\naudioFile: $audioPath\nformat: $videoFormat\nargument list: $argsList\noutput path: $output"
      );
    }
    // Delete old files
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
  static Future<File> convertAudio({
    required String audioFile,
    required FFmpegTask task,
  }) async {
    assert(audioFile != "");
    if (!await audioConversionRequired(task, audioFile)) {
      return File(audioFile);
    }
    List<String> argsList = [];
    String outDir = "${(await getExternalStorageDirectory())!.path}/";
    File output = File(outDir + MediaUtils.getRandomString(10));
    if (task == FFmpegTask.convertToAAC) {
      argsList = [
        "-y", "-i",
        audioFile,
        "-c:a", "aac",
        "-b:a", "256k",
        "${output.path}.m4a",
      ];
      output = File("${output.path}.m4a");
    }
    if (task == FFmpegTask.convertToOGG) {
      argsList = [
        "-y", "-i", audioFile, "-c:a", "libopus",
        "-b:a", "256k", "-vbr", "on", "-compression_level", "10",
        "${output.path}.ogg"
      ];
      output = File("${output.path}.ogg");
    }
    if (task == FFmpegTask.convertToOGGVorbis) {
      argsList = [
        "-y", "-i", audioFile,
        "-c:a", "libvorbis", "-b:a", "256k",
        "${output.path}.ogg"
      ];
      output = File("${output.path}.ogg");
    }
    if (task == FFmpegTask.convertToMP3) {
      argsList = [
        "-y", "-i", audioFile,
        "-c:a", "libmp3lame", "-b:a", "256k",
        "${output.path}.mp3"
      ];
      output = File("${output.path}.mp3");
    }
    if (task == FFmpegTask.none) {
      return File(audioFile);
    }
    int? result = await flutterFFmpeg.executeWithArguments(argsList);
    if (result == 1) {
      throw Exception(
        "An issue ocurred trying to convert audio File\naudioFile: $audioFile\nformat: $task\nargument list: $argsList\noutput path: $output"
      );
    }
    await File(audioFile).delete();
    return output;
  }

  /// Apply the provided [AudioModifiers] to any provided [Audio] file,
  /// these changes can be Volume, Bass or Treble, if the provided
  /// [AudioModifiers] is null, no changes will be made and this
  /// function will return the provided [AudioPath]
  /// 
  /// On failure this function will return [null]
  static Future<File> applyAudioModifiers(
    String audioPath,
    AudioFilters audioModifiers
  ) async {
    assert(audioPath != "");
    String outDir = "${(await getExternalStorageDirectory())!.path}/";
    String? format = await getMediaFormat(audioPath);
    File output = File("${outDir +
      MediaUtils.getRandomString(10)}.$format");
    List<String> argsList = [
      "-y", "-i",
      audioPath,
      "-filter_complex", "[0:a]volume=${audioModifiers.volume+1}[volume]; [volume]bass=g=${audioModifiers.bassGain}[bass]; [bass]treble=g=${audioModifiers.trebleGain}",
       (output.path),
    ];
    int? result = await flutterFFmpeg.executeWithArguments(argsList);
    if (result == 1) {
      throw Exception(
        "Cannot apply AudioModifiers\naudioFile: $audioPath\naudioModifiers: v=${audioModifiers.volume} b=${audioModifiers.bassGain} t=${audioModifiers.trebleGain}\nargument list: $argsList\noutput: $output",
      );
    }
    await File(audioPath).delete();
    return output;
  }

  /// Return a [bool] indicating if the provided [Audio] file needs Conversion
  static Future<bool> audioConversionRequired(
    FFmpegTask task,
    String audioFile
  ) async {
    assert(audioFile != "");
    String? format = await getMediaFormat(audioFile);
    if (task == FFmpegTask.convertToAAC) {
      return format == "m4a" ? false : true;
    } else if (task == FFmpegTask.convertToOGGVorbis) {
      return format == "ogg" ? false : true;
    } else if (task == FFmpegTask.none) {
      return false;
    } else {
      return true;
    }
  }

  /// Clear all [Metadata] of any provided [Audio] file, useful if you cannot
  /// write your own [Metadata] because the [Audio] file already contains an
  /// incompatible one
  static Future<File> clearFileMetadata(String audioFile) async {
    assert(audioFile != "");
    String outDir = "${(await getExternalStorageDirectory())!.path}/";
    String? fileFormat = await getMediaFormat(audioFile);
    File output = File("${outDir + MediaUtils.getRandomString(10)}.$fileFormat");
    List<String> argsList = [
      "-i", audioFile, "-map", "0:a", "-codec:a",
      "copy", "-map_metadata", "-1", (output.path),
    ];
    int? result = await flutterFFmpeg.executeWithArguments(argsList);
    if (result == 1) {
      throw Exception(
        "Cannot Clear Metadata\naudioFile: $audioFile\nargument list: $argsList\noutput: $output",
      );
    }
    await File(audioFile).delete();
    return output;
  }

  /// Normalize any [Audio] file using FFmpeg's dynaudnorm
  static Future<File> normalizeAudio(String audioFile) async {
    assert(audioFile != "");
    String outDir = "${(await getExternalStorageDirectory())!.path}/";
    String? fileFormat = await getMediaFormat(audioFile);
    File output = File("${outDir + MediaUtils.getRandomString(10)}.$fileFormat");
    List<String> argsList = [
      "-y", "-i", audioFile, "-filter_complex",
      "[0:a]dynaudnorm", (output.path)
    ];
    int? result = await flutterFFmpeg.executeWithArguments(argsList);
    if (result == 1) {
      throw Exception(
        "Audio Normalization Failed\n"
        "audioFile: $audioFile\n"
        "argument list: $argsList\n"
        "output: $output"
      );
    }
    await File(audioFile).delete();
    return output;
  }

  /// Extracts a specific part from any audio file from start to end duration
  /// and returns a new File
  static Future<File> extractAudio(String audioFile, int start, int end) async {
    assert(audioFile != "");
    String outDir = "${(await getExternalStorageDirectory())!.path}/";
    String? fileFormat = await getMediaFormat(audioFile);
    File output = File("${outDir + MediaUtils.getRandomString(10)}.$fileFormat");
    List<String> argsList = [
      "-y", "-i", audioFile, "-ss", "$start", "-to",
      "$end", "-c", "copy", (output.path)
    ];
    int? result = await flutterFFmpeg.executeWithArguments(argsList);
    if (result == 1) {
      throw Exception(
        "Audio Extraction Failed\n"
        "audioFile: $audioFile\n"
        "argument list: $argsList\n"
        "output: $output"
      );
    }
    return output;
  }

}