// ArtorkFile Getter
import 'dart:io';

import 'package:audio_tagger/audio_tagger.dart';
import 'package:flutter/services.dart';
import 'package:songtube/internal/media_utils.dart';

// Song Thumnnails Directory
late Directory songArtworkPath;
late Directory songThumbnailPath;

// Artwork Getter
File artworkFile(String id) => File('${songArtworkPath.path}/${MediaUtils.removeToxicSymbols((id.split('/').last).replaceAll(' ', '').trim())}-hq');

// Thumbnail Getter
File thumbnailFile(String id) => File('${songThumbnailPath.path}/${MediaUtils.removeToxicSymbols((id.split('/').last).replaceAll(' ', '').trim())}-lq');

class ArtworkManager {

  /// Setup the artwork for a given song file, this function also has the ability to embed the artwork to the song directly
  static Future<void> writeArtwork(String filePath, {dynamic artwork, bool forceRefresh = false, bool embedToSong = false}) async {
    if ((await artworkFile(filePath).exists()) && !forceRefresh) {
      return;
    }
    final Uint8List? image = artwork != null
      ? artwork is File
        ? await artwork.readAsBytes()
        : artwork
      : await AudioTagger.extractArtwork(filePath);
    if (image == null || image.isEmpty) {
      await writeDefaultThumbnail(filePath);
      return;
    }
    if ((await artworkFile(filePath).exists())) {
      await artworkFile(filePath).delete();
      await artworkFile(filePath).create();
    } else {
      await artworkFile(filePath).create();
    }
    await artworkFile(filePath).writeAsBytes(image);
    if (embedToSong) {
      await AudioTagger.writeArtwork(
        songPath: filePath,
        artworkPath: artworkFile(filePath).path
      );
    }
  }

  /// Setup the thumbnail for a given song file
  static Future<void> writeThumbnail(String filePath, {dynamic artwork, bool forceRefresh = false}) async {
    if ((await thumbnailFile(filePath).exists()) && !forceRefresh) {
      return;
    }
    final Uint8List? image = artwork != null
      ? artwork is File
        ? await artwork.readAsBytes()
        : artwork
      : await AudioTagger.extractThumbnail(filePath);
    if (image == null || image.isEmpty) {
      await writeDefaultThumbnail(filePath);
      return;
    }
    if ((await thumbnailFile(filePath).exists())) {
      await thumbnailFile(filePath).delete();
      await thumbnailFile(filePath).create();
    } else {
      await thumbnailFile(filePath).create();
    }
    await thumbnailFile(filePath).writeAsBytes(image);
  }

  // Writes the default SongTube thumbnail to any given song file
  static Future<void> writeDefaultThumbnail(String filePath) async {
    if ((await thumbnailFile(filePath).exists())) {
      await thumbnailFile(filePath).delete();
      await thumbnailFile(filePath).create();
    } else {
      await thumbnailFile(filePath).create();
    }
    final data = await rootBundle.load('assets/images/artworkPlaceholder_big.png');
    final bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await thumbnailFile(filePath).writeAsBytes(bytes);
  }

}