import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:songtube/internal/global.dart';

enum ArtworkQuality { small, normal, large, original }

String? get artistUserToken => sharedPreferences.getString('artistUserToken');

class MusicBrainzAPI {

  static final headers = {
    'user-agent':
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
      '(KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36',
    'accept-language': 'en-US,en;q=1.0',
    'Content-Type': 'application/json'
  };

  static Future<dynamic> getFirstRecord(String title) async {
    final client = http.Client();
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
    final client = http.Client();
    var response = await client.get(Uri.parse(
      "http://musicbrainz.org/ws/2/recording?query="
      "${title.trim().replaceAll('&', '')}&dismax=true"
      "&fmt=json"),
      headers: headers,
    );
    client.close();
    return jsonDecode(utf8.decode(response.bodyBytes))["recordings"];
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
      return parsedJson["releases"][0]["media"][0]["track-offset"]?.toString() ?? "0";
    } else {
      return 'Unknown';
    }
  }

  static String getDiscNumber(Map<String, dynamic> parsedJson) {
    return "0";
  }

  static String getDate(Map<String, dynamic>parsedJson) {
    if (parsedJson.containsKey('releases') && parsedJson['releases'].isNotEmpty) {
      if (parsedJson["releases"][0].containsKey('date')) {
        return parsedJson["releases"][0]["date"];
      } else {
        return 'Unknown';
      }
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
    final client = http.Client();
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
    final client = http.Client();
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
    final client = http.Client();
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

  // Retrieve artist image
  static Future<String?> getArtistImage(String name) async {
    final client = http.Client();
    final key = 'artistImage$name';
    final imageUrl = sharedPreferences.getString(key);
    // Check if image exist
    if (imageUrl != null) {
      return imageUrl;
    } else {
      // Check user token
      if (artistUserToken == null) {
        final tokenResponse = await client.get(Uri.parse('https://open.spotify.com/get_access_token?reason=transport&productType=web_player'));
        if (tokenResponse.statusCode == 200) {
          final map = jsonDecode(tokenResponse.body);
          sharedPreferences.setString('artistUserToken', map['accessToken']);
        }
      }
      // Retrieve image
      final imageResponse = await client.get(
        Uri.parse('https://api.spotify.com/v1/search?type=artist&q=$name&decorate_restrictions=false&best_match=true&include_external=audio&limit=1'),
        headers: {
          'Authorization': 'Bearer $artistUserToken' 
        }
      );
      if (imageResponse.statusCode == 200) {
        // Extract and save artist image url
        final map = jsonDecode(imageResponse.body);
        final url = map['best_match']['items'][0]['images'][0]['url'];
        sharedPreferences.setString(key, url);
        return url;
      } else {
        return null;
      }
    }
  }

}