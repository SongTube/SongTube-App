// Dart
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

// Packages
import 'package:audio_tagger/audio_tagger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';

/// Select which approach to use when extracting the [Artwork] of
/// the provided [AudioFile]
enum ArtworkExtractMethod {
  Automatic,
  AudioTaggers,
  AudioQuery,
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
    assert(audioFile != "");
    String artworkDir = (await getExternalStorageDirectory()).path + "/Artworks/";
    if (!await Directory(artworkDir).exists())
      await Directory(artworkDir).create();
    File artwork = File("$artworkDir${audioFile != null ? audioFile.split("/").last.replaceAll("/", "_") : "default"}.jpg");
    if (await artwork.exists() && forceExtraction == false) return artwork;
    if (await artwork.exists()) await artwork.delete();
    if (audioFile == null) {
      var assetBytes = await rootBundle
        .load('assets/images/artworkPlaceholder_big.png');
      return await artwork.writeAsBytes(
        assetBytes.buffer
          .asUint8List(
            assetBytes.offsetInBytes,
            assetBytes.lengthInBytes
      ));
    }
    // FFmpeg Arguments
    var _argsList = [
      "-y", "-i", "$audioFile", "-an",
      "-q:v", "1", "${artwork.path}"
    ];
    if (extractionMethod == ArtworkExtractMethod.Automatic) {
      // On Automatic, AudioTagger Method has priority
      // (Because Artwork quality will be better)
      Uint8List bytes = await AudioTagger.extractArtwork(audioFile);
      if (bytes != null && bytes.isNotEmpty) {
        artwork.writeAsBytes(bytes);
      } else {
        try {
          Size size = Size(800,800);
          bytes = await FlutterAudioQuery().getArtwork(
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
    } else if (extractionMethod == ArtworkExtractMethod.AudioTaggers) {
      Uint8List bytes = await AudioTagger.extractArtwork(audioFile);
      if (bytes != null && bytes.isNotEmpty) {
        artwork.writeAsBytes(bytes);
      } else {
        try {
          Size size = Size(800,800);
          bytes = await FlutterAudioQuery().getArtwork(
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
    }
    return artwork;
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
      "-y", "-i", "${videoFile.path}", "-vcodec", "mjpeg", "-ss", "00:00:03.000", "-vframes", "1", "$coverPath"
    ];
    await FlutterFFmpeg().executeWithArguments(ffmpegArgs);
    if (await File(coverPath).exists()) { 
      return File(coverPath);
    } else {
      return null;
    }
  }

  /// Get Video Duration in [Milliseconds]
  static Future<int> getVideoDuration(File video) async {
    assert(video.path != "" || video != null);
    var json = await FlutterFFprobe().getMediaInformation(video.path);
    return double.parse(json.getMediaProperties()['duration']).round();
  }

  /// Get Audio Date
  static Future<String> getAudioDate(String audioPath) async {
    var json = await FlutterFFprobe().getMediaInformation(audioPath);
    return "${json.getMediaProperties()["tags"]["date"]}";
  }

  /// Get Audio Disc
  static Future<String> getAudioDisc(String audioPath) async {
    var json = await FlutterFFprobe().getMediaInformation(audioPath);
    return "${json.getMediaProperties()["tags"]["disc"]}";
  }

  /// Get Audio Track
  static Future<String> getAudioTrack(String audioPath) async {
    var json = await FlutterFFprobe().getMediaInformation(audioPath);
    return "${json.getMediaProperties()["tags"]["track"]}";
  }

  /// Get Audio Genre
  static Future<String> getAudioGenre(String audioPath) async {
    var json = await FlutterFFprobe().getMediaInformation(audioPath);
    var mediaProperties = json.getMediaProperties();
    if (
      mediaProperties != null &&
      mediaProperties.containsKey("tags") &&
      mediaProperties["tags"].containsKey("genre"))
    {
      return "${mediaProperties["tags"]["genre"]}";
    }
    return null;
  }

}