// Dart
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

// Packages
import 'package:flutter/services.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';

/// Select which approach to use when extracting the [Artwork] of
/// the provided [AudioFile]
enum ArtworkExtractMethod {
  Automatic,
  AudioQuery,
  FFmpeg
}

/// Set of static functions design to Extract information from a given
/// media file, these functions can't modify the media file by any way
class FFmpegExtractor {

  static Future<File> getAudioArtwork({
    String audioFile,
    String audioId,
    ArtworkExtractMethod extractionMethod =
      ArtworkExtractMethod.Automatic,
    bool forceExtraction = false
  }) async {
    assert(audioFile != "" || audioFile != null);
    String artworkDir = (await getApplicationDocumentsDirectory()).path + "/Artworks/";
    if (!await Directory(artworkDir).exists())
      await Directory(artworkDir).create();
    File artwork = File("$artworkDir${audioFile.split("/").last.replaceAll("/", "_")}.jpg");
    if (await artwork.exists() && forceExtraction == false) return artwork;
    if (await artwork.exists()) await artwork.delete();
    // FFmpeg Arguments
    var _argsList = [
      "-y", "-i", "$audioFile", "-an",
      "-q:v", "1", "${artwork.path}"
    ];
    if (extractionMethod == ArtworkExtractMethod.Automatic) {
      // On Automatic, FFmpeg Method has priority
      // (Because Artwork quality will be better)
      int result = await FlutterFFmpeg().executeWithArguments(_argsList);
      // If it somehow failed, use AudioQuery native method, if id provided is
      // null or AudioQuery returns nothing, then return default Artwork
      // from Assets
      if (result == 255 || result == 1) {
        Uint8List bytes;
        try {
          Size size = Size(800,800);
          bytes =  await FlutterAudioQuery().getArtwork(
            type: ResourceType.SONG,
            id: audioId, size: size
          );
        } catch (_) {}
        if (bytes != null && bytes.isNotEmpty) {
          await artwork.writeAsBytes(bytes);
        } else {
          var assetBytes = await rootBundle
            .load('assets/images/artworkPlaceholder_big.png');
          await artwork.writeAsBytes(
            assetBytes.buffer
              .asUint8List(
                assetBytes.offsetInBytes,
                assetBytes.lengthInBytes
          ));
        }
      }
    } else if (extractionMethod == ArtworkExtractMethod.FFmpeg) {
      // On FFmpeg, Artwork will only be Extracted using FFmpeg and
      // if it fails, it will return default Artwork from Assets
      int result = await FlutterFFmpeg().executeWithArguments(_argsList);
      if (result == 255 || result == 1) {
        var assetBytes = await rootBundle
          .load('assets/images/artworkPlaceholder_big.png');
        await artwork.writeAsBytes(
          assetBytes.buffer
            .asUint8List(
              assetBytes.offsetInBytes,
              assetBytes.lengthInBytes
        ));
      }
    } else if (extractionMethod == ArtworkExtractMethod.AudioQuery) {
      // On AudioQuery, Artwork will only be Extracted using AudioQuery package
      // and if it fails, it will return default Artwork from Assets
      Uint8List bytes;
      try {
        Size size = Size(800,800);
        bytes =  await FlutterAudioQuery().getArtwork(
          type: ResourceType.SONG,
          id: audioId, size: size
        );
      } catch (_) {}
      if (bytes != null && bytes.isNotEmpty) {
        await artwork.writeAsBytes(bytes);
      } else {
        var assetBytes = await rootBundle
          .load('assets/images/artworkPlaceholder_big.png');
        await artwork.writeAsBytes(
          assetBytes.buffer
            .asUint8List(
              assetBytes.offsetInBytes,
              assetBytes.lengthInBytes
        ));
      }
    }
    return artwork;
  }

  static Future<File> getAudioThumbnail({
    String audioFile,
    String audioId,
    ArtworkExtractMethod extractionMethod =
      ArtworkExtractMethod.Automatic,
    bool forceExtraction = false
  }) async {
    assert(audioFile != "" || audioFile != null);
    String thumbnailDir = (await getApplicationDocumentsDirectory()).path + "/Thumbnails/";
    if (!await Directory(thumbnailDir).exists())
      await Directory(thumbnailDir).create();
    File thumbnail = File("$thumbnailDir${audioFile.split("/").last.replaceAll("/", "_")}thumbnail.jpg");
    if (await thumbnail.exists() && forceExtraction == false) return thumbnail;
    if (await thumbnail.exists()) await thumbnail.delete();
    // FFmpeg Arguments
    var _argsList = [
      "-y", "-i", "$audioFile", "-filter:v",
      "scale=-1:250", "-an", "${thumbnail.path}"
    ];
    if (extractionMethod == ArtworkExtractMethod.Automatic) {
      // On Automatic, FFmpeg Method has priority
      // (Because Artwork quality will be better)
      int result = await FlutterFFmpeg().executeWithArguments(_argsList);
      // If it somehow failed, use AudioQuery native method, if id provided is
      // null or AudioQuery returns nothing, then return default Artwork
      // from Assets
      if (result == 255 || result == 1) {
        Uint8List bytes;
        try {
          Size size = Size(250,250);
          bytes =  await FlutterAudioQuery().getArtwork(
            type: ResourceType.SONG,
            id: audioId, size: size
          );
        } catch (_) {}
        if (bytes != null && bytes.isNotEmpty) {
          await thumbnail.writeAsBytes(bytes);
        } else {
          var assetBytes = await rootBundle
            .load('assets/images/artworkPlaceholder_big.png');
          await thumbnail.writeAsBytes(
            assetBytes.buffer
              .asUint8List(
                assetBytes.offsetInBytes,
                assetBytes.lengthInBytes
          ));
        }
      }
    } else if (extractionMethod == ArtworkExtractMethod.FFmpeg) {
      // On FFmpeg, Artwork will only be Extracted using FFmpeg and
      // if it fails, it will return default Artwork from Assets
      int result = await FlutterFFmpeg().executeWithArguments(_argsList);
      if (result == 255 || result == 1) {
        var assetBytes = await rootBundle
          .load('assets/images/artworkPlaceholder_big.png');
        await thumbnail.writeAsBytes(
          assetBytes.buffer
            .asUint8List(
              assetBytes.offsetInBytes,
              assetBytes.lengthInBytes
        ));
      }
    } else if (extractionMethod == ArtworkExtractMethod.AudioQuery) {
      // On AudioQuery, Artwork will only be Extracted using AudioQuery package
      // and if it fails, it will return default Artwork from Assets
      Uint8List bytes;
      try {
        Size size = Size(250,250);
        bytes =  await FlutterAudioQuery().getArtwork(
          type: ResourceType.SONG,
          id: audioId, size: size
        );
      } catch (_) {}
      if (bytes != null && bytes.isNotEmpty) {
        await thumbnail.writeAsBytes(bytes);
      } else {
        var assetBytes = await rootBundle
          .load('assets/images/artworkPlaceholder_small.png');
        await thumbnail.writeAsBytes(
          assetBytes.buffer
            .asUint8List(
              assetBytes.offsetInBytes,
              assetBytes.lengthInBytes
        ));
      }
    }
    return thumbnail;
  }

  /// Gets video thumbnail of any Video Format on a [File]
  static Future<File> getVideoThumbnail(File videoFile) async {
    assert(videoFile.path != "" || videoFile != null);
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
    assert(video.path != "" || video != null);
    var json = await FlutterFFprobe().getMediaInformation(video.path);
    return json['duration'];
  }

  /// Get Audio Date
  static Future<String> getAudioDate(String audioPath) async {
    var json = await FlutterFFprobe().getMediaInformation(audioPath);
    return "${json["metadata"]["date"]}";
  }

  /// Get Audio Disc
  static Future<String> getAudioDisc(String audioPath) async {
    var json = await FlutterFFprobe().getMediaInformation(audioPath);
    return "${json["metadata"]["disc"]}";
  }

  /// Get Audio Track
  static Future<String> getAudioTrack(String audioPath) async {
    var json = await FlutterFFprobe().getMediaInformation(audioPath);
    return "${json["metadata"]["track"]}";
  }

}