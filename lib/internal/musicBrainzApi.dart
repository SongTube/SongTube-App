import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:songtube/internal/models/tagsControllers.dart';

enum ArtworkQuality { Small, Normal, Large, Original }

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
    http.Client client = new http.Client();
    var response = await client.get(Uri.parse(
      "http://musicbrainz.org/ws/2/recording?query="
      "${title.trim().replaceAll('&', '')}&dismax=true"
      "&fmt=json")
    );
    await Future.delayed(Duration(milliseconds: 1));
    var parsedJson = jsonDecode(utf8.decode(response.bodyBytes))["recordings"][0];
    response = await client.get(Uri.parse(
      "http://musicbrainz.org/ws/2/recording/"
      "${parsedJson['id']}?inc=aliases+"
      "artist-credits+releases+genres+tags+media"
      "&fmt=json")
    );
    await Future.delayed(Duration(milliseconds: 1));
    client.close();
    parsedJson = jsonDecode(utf8.decode(response.bodyBytes));
    return parsedJson;
  }

  static Future<List<dynamic>> getRecordings(String title) async {
    http.Client client = new http.Client();
    var response = await client.get(Uri.parse(
      "http://musicbrainz.org/ws/2/recording?query="
      "${title.trim().replaceAll('&', '')}&dismax=true"
      "&fmt=json"),
      headers: headers,
    );
    client.close();
    return jsonDecode(utf8.decode(response.bodyBytes))["recordings"];
  }

  static Future<TagsControllers> getSongTags(MusicBrainzRecord record, {String artworkLink}) async {
    TagsControllers tagsControllers = TagsControllers();
    tagsControllers.titleController.text = record.title;
    tagsControllers.artistController.text = record.artist;
    tagsControllers.albumController.text = record.album;
    tagsControllers.dateController.text = record.date;
    tagsControllers.discController.text = record.disc;
    tagsControllers.trackController.text = record.track;
    tagsControllers.genreController.text = record.genre;
    tagsControllers.artworkController = null;
    if (artworkLink == null) {
      try {
        await getThumbnails(record.id).then((map) {
          if (map != null) {
            if (map.containsKey("1200x1200"))
              tagsControllers.artworkController = map["1200x1200"];
            else
              tagsControllers.artworkController = map["500x500"];
          }
        });
      } catch (e) {}
    } else {
      tagsControllers.artworkController = artworkLink;
    }
    return tagsControllers;
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
      return parsedJson["releases"][0]["media"][0]["track-offset"].toString() ?? "0";
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

  static Future<String> getArtwork(mbid, 
  {ArtworkQuality quality = ArtworkQuality.Large}) async {
    http.Client client = new http.Client();
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

  static Future<String> getThumbnail(mbid) async {
    http.Client client = new http.Client();
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

  static Future<Map<String, String>> getThumbnails(mbid) async {
    if (mbid == null) return null;
    http.Client client = new http.Client();
    Map<String, String> thumbnails = Map<String, String>();
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
          if (!thumbnails.containsKey("1200x1200"))
            thumbnails.addAll({"1200x1200": url});
        }
        if (key == "large" || key == "500") {
          if (!thumbnails.containsKey("500x500"))
            thumbnails.addAll({"500x500": url});
        }
        if (key == "small" || key == "250") {
          if (!thumbnails.containsKey("250x250"))
            thumbnails.addAll({"250x250": url});
        }
      });
      return thumbnails;
    }
  }

}

class MusicBrainzRecord {

  final String id;
  final String title;
  final String artist;
  final String album;
  final String date;
  final String genre;
  final String disc;
  final String track;
  String artwork;

  MusicBrainzRecord({
    this.id,
    this.title,
    this.artist,
    this.album,
    this.date,
    this.genre,
    this.disc,
    this.track,
    this.artwork,
  });

  static MusicBrainzRecord fromMap(Map<String, dynamic> map) {
    return MusicBrainzRecord(
      id: map.containsKey('releases')
        ? map['releases'].isNotEmpty ? map['releases'][0]['id'] : null : null,
      title: MusicBrainzAPI.getTitle(map),
      artist: MusicBrainzAPI.getArtist(map),
      album: MusicBrainzAPI.getAlbum(map),
      date: MusicBrainzAPI.getDate(map) ?? 'Unknown',
      genre: MusicBrainzAPI.getGenre(map) ?? 'Unknown',
      disc: MusicBrainzAPI.getDiscNumber(map) ?? 'Unknown',
      track: MusicBrainzAPI.getTrackNumber(map) ?? 'Unknown',
    );
  }

}