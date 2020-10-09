// Dart
import 'dart:io';
import 'dart:typed_data';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Packages
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path_provider/path_provider.dart';

class ArtworkGenerator {

  // Automatically decides which Method use to generate Artwork
  static Future<List<dynamic>> generateArtwork(File song, String id) async {
    if (!await Directory((await getApplicationDocumentsDirectory()).path + "/Artworks/").exists())
      await Directory((await getApplicationDocumentsDirectory()).path + "/Artworks/").create();
    File artwork = File((await getApplicationDocumentsDirectory()).path +
      "/Artworks/${song.path.split("/").last.replaceAll("/", "_")}HQ.jpg");
    if (!await artwork.exists()) {
      // If id is null use FFmpeg Method to extract Artwork
      if (id == null) {
        await FlutterFFmpeg().executeWithArguments([
          "-y", "-i", "${song.path}", "-filter:v", "scale=500:500", "-an",
          "-q:v", "1", "${artwork.path}"
        ]);
      } else { // Else, use native Method from FlutterAudioQuery
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
    PaletteGenerator color = await PaletteGenerator.fromImageProvider(FileImage(artwork));
    Color dominantColor = color.dominantColor.color;
    return [artwork, dominantColor];
  }

  // Use FFmpeg method to generate Artwork
  static Future<File> generateArtworkWithFFmpeg(File song) async {
    File artwork = File((await getApplicationDocumentsDirectory()).path +
      "/Artworks/${song.path.split("/").last.replaceAll("/", "_")}HQ.jpg");
    await FlutterFFmpeg().executeWithArguments([
      "-y", "-i", "${song.path}", "-filter:v", "scale=500:500", "-an",
      "-q:v", "1", "${artwork.path}"
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