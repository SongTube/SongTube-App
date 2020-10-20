// Dart
import 'dart:io';
import 'dart:typed_data';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Packages
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';

class ArtworkGenerator {

  // Automatically decides which Method use to generate Artwork
  static Future<File> generateArtwork(File song, [String id]) async {
    if (!await Directory((await getApplicationDocumentsDirectory()).path + "/Artworks/").exists())
      await Directory((await getApplicationDocumentsDirectory()).path + "/Artworks/").create();
    File artwork = File((await getApplicationDocumentsDirectory()).path +
      "/Artworks/${song.path.split("/").last.replaceAll("/", "_")}HQ.jpg");
    if (!await artwork.exists()) {
      int result = await FlutterFFmpeg().executeWithArguments([
        "-y", "-i", "${song.path}", "-an",
        "-q:v", "1", "${artwork.path}"
      ]);
      if (result == 255 || result == 1) {
        Uint8List bytes =  await FlutterAudioQuery().getArtwork(
        type: ResourceType.SONG,
        id: id,
        size: Size(500,500)
        );
        if (bytes.isNotEmpty) {
          await artwork.writeAsBytes(bytes);
        } else {
          var assetBytes = await rootBundle.load('assets/images/artworkPlaceholder_big.png');
          await artwork.writeAsBytes(assetBytes.buffer.asUint8List(assetBytes.offsetInBytes, assetBytes.lengthInBytes));
        }
      }
    }
    return artwork;
  }

  // Use FFmpeg method to generate Artwork
  static Future<File> generateArtworkWithFFmpeg(File song) async {
    File artwork = File((await getApplicationDocumentsDirectory()).path +
      "/Artworks/${song.path.split("/").last.replaceAll("/", "_")}HQ.jpg");
    await FlutterFFmpeg().executeWithArguments([
      "-y", "-i", "${song.path}", "-an",
      "-q:v", "1", "${artwork.path}"
    ]);
    return artwork;
  }

  // Use FFmpeg method to generate Artwork
  static Future<File> generateThumbnailWithFFmpeg(File song) async {
    Directory dir = Directory((await getApplicationDocumentsDirectory()).path + "/Thumbnails/");
    if (!await dir.exists()) dir.create(recursive: true);
    File artwork = File(dir.path + "${song.path.split("/").last.replaceAll("/", "_")}MQ.jpg");
    await FlutterFFmpeg().executeWithArguments([
      "-y", "-i", "${song.path}", "-filter:v", "scale=-1:250", "-an",
      "${artwork.path}"
    ]);
    return artwork;
  }

  // Use FlutterAudioQuery Package method to generate Artwork
  static Future<File> generateArtworkWithFlutterAudioQuery(File song, String id) async {
    File artwork = File((await getApplicationDocumentsDirectory()).path +
      "/Artworks/${song.path.split("/").last.replaceAll("/", "_")}HQ.jpg");
    Uint8List bytes =  await FlutterAudioQuery().getArtwork(
      type: ResourceType.SONG,
      id: id,
      size: Size(500,500)
    );
    if (bytes.isNotEmpty) {
      await artwork.writeAsBytes(bytes);
    } else {
      var assetBytes = await rootBundle.load('assets/images/artworkPlaceholder_big.png');
      await artwork.writeAsBytes(assetBytes.buffer.asUint8List(assetBytes.offsetInBytes, assetBytes.lengthInBytes));
    }
    return artwork;
  }

}