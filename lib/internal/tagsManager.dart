// Dart
import 'dart:io';
import 'dart:math';

// Flutter
import 'package:flutter/services.dart';

// Internal
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/internal/randomString.dart';

// Packages
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class TagsManager {

  // -------------------------
  // Implementation for native
  // Tags editing Methods
  // -------------------------

  // Define platform channel name
  static const _channel = const MethodChannel("tagsChannel");

  // Write all (available) Tags into the audio file
  static Future<int> writeAllTags({
    String songPath,
    String title,
    String album,
    String artist,
    String genre,
    String year,
    String disc,
    String track
  }) async {
    int result = await _channel.invokeMethod("writeAllTags", {
      "songPath":   songPath,
      "tagsTitle":  title,
      "tagsAlbum":  album,
      "tagsArtist": artist,
      "tagsGenre":  genre,
      "tagsYear":   year,
      "tagsDisc":   disc,
      "tagsTrack":  track
    });
    return result;
  }

  // Write artwork using local Image or from Url
  static Future<int> writeArtwork({
    String songPath,
    String artworkPath,
    String artworkUrl,
  }) async {
    if (artworkPath != null && artworkUrl != null)
      throw Exception("Both artworkPath and artworkUrl defined, please define only one");
    if (artworkPath != null) {
      if (!await File(artworkPath).exists()) throw Exception("artworkPath provided path doesnt exist or is invalid");
    }
    String artwork;
    bool fromUrl;
    Directory directory;
    File artworkFile;
    http.Response response;
    if (artworkPath != null) {artwork = artworkPath; fromUrl = false;}
    if (artworkUrl  != null) {artwork = artworkUrl; fromUrl = true;}
    if (fromUrl == true) {
      directory    = await getTemporaryDirectory();
      artworkFile  = new File(directory.path + "/" + _randomString());
      response     = await http.get(artwork);
      artwork      = artworkFile.path;
      if (response.statusCode != 200) {
        throw Exception("Error downloading artwork, check your Url or internet connection");
      }
      await artworkFile.writeAsBytes(response.bodyBytes);
    }
    int result = await _channel.invokeMethod("writeArtwork", {
      "songPath": songPath,
      "artworkPath": artwork
    });
    return result;
  }

  // Get a random string used by Function: writeArtwork
  static String _randomString() {
    final _chars = "abcdefghijklmnopqrstuvwxyz";
    Random _rnd = Random();
    String string = String.fromCharCodes(Iterable.generate(
      6, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))
    ));
    return string;
  }

  // Generate a Square Cover Image
  static Future<File> generateCover(String url) async {
    File artwork =
      new File((await getApplicationDocumentsDirectory()).path +
        "/${RandomString.getRandomString(5)}.jpg");
    var response; try {
      response = await http.get(url);
    } catch (_) {return null;}
    await artwork.writeAsBytes(response.bodyBytes);
    File croppedImage = await NativeMethod.cropToSquare(artwork);
    return croppedImage;
  }
}