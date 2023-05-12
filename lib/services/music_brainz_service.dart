import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:songtube/internal/models/audio_tags.dart';
import 'package:songtube/internal/models/music_brainz_record.dart';

enum ArtworkQuality { small, normal, large, original }

class MusicBrainzAPI {

  MusicBrainzAPI();

  static final headers = {
    'user-agent':
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
      '(KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36',
    'accept-language': 'en-US,en;q=1.0',
    'Content-Type': 'application/json'
  };

  static Future<dynamic> getFirstRecord(String title) async {
    http.Client client = http.Client();
    var response = await client.get(Uri.parse(
      "http://musicbrainz.org/ws/2/recording?query="
      "${title.trim().replaceAll('&', '')}&dismax=true"
      "&fmt=json")
    );
    await Future.delayed(const Duration(milliseconds: 1));
    var parsedJson = jsonDecode(utf8.decode(response.bodyBytes))["recordings"][0];
    response = await client.get(Uri.parse(
      "http://musicbrainz.org/ws/2/recording/"
      "${parsedJson['id']}?inc=aliases+"
      "artist-credits+releases+genres+tags+media"
      "&fmt=json")
    );
    await Future.delayed(const Duration(milliseconds: 1));
    client.close();
    parsedJson = jsonDecode(utf8.decode(response.bodyBytes));
    return parsedJson;
  }

  static Future<List<dynamic>> getRecordings(String title) async {
    http.Client client = http.Client();
    var response = await client.get(Uri.parse(
      "http://musicbrainz.org/ws/2/recording?query="
      "${title.trim().replaceAll('&', '')}&dismax=true"
      "&fmt=json"),
      headers: headers,
    );
    client.close();
    return jsonDecode(utf8.decode(response.bodyBytes))["recordings"];
  }

  static Future<AudioTags> getSongTags(MusicBrainzRecord record) async {
    AudioTags audioTags = AudioTags.withMusicBrainzRecord(record);
    try {
      await getThumbnails(record.id).then((map) {
        if (map != null) {
          if (map.containsKey("1200x1200")) {
            audioTags.artwork = map["1200x1200"];
          } else {
            audioTags.artwork = map["500x500"];
          }
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return audioTags;
  }

  static String getTitle(Map<String, dynamic> parsedJson) {
    return parsedJson["title"];
  }

  static String getArtist(Map<String, dynamic> parsedJson) {
    String fullArtist = "";
    for (var map in parsedJson["artist-credit"]) {
      if (fullArtist == "") {
        fullArtist = map["name"];
      } else {
        fullArtist += " & ${map['name']}";
      }
    }
    return fullArtist;
  }

  static String getAlbum(Map<String, dynamic> parsedJson) {
    if (parsedJson.containsKey('releases') && parsedJson['releases'].isNotEmpty) {
      return parsedJson["releases"][0]["title"];
    } else {
      return "Unknown";
    }
  }

  static String getTrackNumber(Map<String, dynamic>parsedJson) {
    if (parsedJson.containsKey('releases') && parsedJson['releases'].isNotEmpty) {
      return parsedJson["releases"][0]["media"][0]["track-offset"].toString();
    } else {
      return 'Unknown';
    }
  }

  static String getDiscNumber(Map<String, dynamic> parsedJson) {
    return "0";
  }

  static String getDate(Map<String, dynamic>parsedJson) {
    if (parsedJson.containsKey('releases') && parsedJson['releases'].isNotEmpty) {
      return parsedJson["releases"][0]["date"];
    } else {
      return 'Unknown';
    }
  }

  static String getGenre(Map<String, dynamic> parsedJson) {
    if (parsedJson.containsKey("genres")) {
      if (parsedJson["genres"].isNotEmpty) {
        return parsedJson["genres"][0]["name"];
      } else {
        return "Any";
      }
    } else {
      return "Any";
    }
  }

  static Future<String?> getArtwork(mbid, 
  {ArtworkQuality quality = ArtworkQuality.large}) async {
    http.Client client = http.Client();
    var response = await client.get(Uri.parse(
      "http://coverartarchive.org/release/$mbid")
    );
    client.close();
    if (response.body.contains("Not Found")) {
      return null;
    } else {
      var json = jsonDecode(response.body);
      return json["images"][0]["thumbnails"]["large"];
    }
  }

  static Future<String?> getThumbnail(mbid) async {
    http.Client client = http.Client();
    var response = await client.get(Uri.parse(
      "http://coverartarchive.org/release/$mbid")
    );
    client.close();
    if (response.body.contains("Not Found")) {
      return null;
    } else {
      var json = jsonDecode(response.body);
      return json ["images"][0]["thumbnails"]["large"];
    }
  }

  static Future<Map<String, String>?> getThumbnails(mbid) async {
    if (mbid == null) return null;
    http.Client client = http.Client();
    Map<String, String> thumbnails = <String, String>{};
    var response = await client.get(Uri.parse(
      "http://coverartarchive.org/release/$mbid")
    );
    client.close();
    if (response.body.contains("Not Found")) {
      return null;
    } else {
      var json = jsonDecode(response.body);
      json["images"][0]["thumbnails"].forEach((key, url) {
        if (key == "1200") {
          if (!thumbnails.containsKey("1200x1200")) {
            thumbnails.addAll({"1200x1200": url});
          }
        }
        if (key == "large" || key == "500") {
          if (!thumbnails.containsKey("500x500")) {
            thumbnails.addAll({"500x500": url});
          }
        }
        if (key == "small" || key == "250") {
          if (!thumbnails.containsKey("250x250")) {
            thumbnails.addAll({"250x250": url});
          }
        }
      });
      return thumbnails;
    }
  }

}