// Dart
import 'dart:io';

// Packages
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';

/// Set of static functions design to Extract information from a given
/// media file, these functions can't modify the media file by any way
class FFmpegExtractor {

  /// Gets video thumbnail of any Video Format on a [File]
  static Future<File> getVideoThumbnail(File videoFile) async {
    String videoTitle = videoFile.path.substring(videoFile.path.lastIndexOf('/')).substring(1)
      .replaceAll(".webm", '')
      .replaceAll(".mp4", '')
      .replaceAll(".avi", '')
      .replaceAll(".3gpp", '')
      .replaceAll(".flv", '')
      .replaceAll(".mkv", '');
    Directory appDir = await getApplicationDocumentsDirectory();
    String dir = appDir.path + "/Thumbnails/";
    if (!await Directory(dir).exists()) await Directory(dir).create(recursive: true);
    String coverPath;
    coverPath = dir + videoTitle
      .replaceAll(" ", '_')
      .replaceAll("'", '_')
      .replaceAll("\"", '_')+ ".png";
    if (await File(coverPath).exists()) {
      return File(coverPath);
    }
    List<String> ffmpegArgs = [
      "-y", "-i", "${videoFile.path}", "-ss", "00:00:01.000", "-vframes", "1", "$coverPath"
    ];
    await FlutterFFmpeg().executeWithArguments(ffmpegArgs);
    return File(coverPath);
  }
  
  /// Get Video Duration in [Milliseconds]
  static Future<int> getVideoDuration(File video) async {
    var json = await FlutterFFprobe().getMediaInformation(video.path);
    return json['duration'];
  }

}