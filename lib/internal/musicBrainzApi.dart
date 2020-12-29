import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:songtube/internal/models/tagsControllers.dart';

enum ArtworkQuality { Small, Normal, Large, Original }

class MusicBrainzAPI {

  MusicBrainzAPI();

  static Future<dynamic> getFirstRecord(String title) async {
    http.Client client = new http.Client();
    var response = await client.get(
      "http://musicbrainz.org/ws/2/recording?query="
      "${title.trim()}&dismax=true"
      "&fmt=json"
    );
    await Future.delayed(Duration(milliseconds: 1));
    var parsedJson = jsonDecode(response.body)["recordings"][0];
    response = await client.get(
      "http://musicbrainz.org/ws/2/recording/"
      "${parsedJson['id']}?inc=aliases+"
      "artist-credits+releases+genres+tags+media"
      "&fmt=json"
    );
    await Future.delayed(Duration(milliseconds: 1));
    client.close();
    parsedJson = jsonDecode(response.body);
    return parsedJson;
  }

  static Future<List<dynamic>> getRecordings(String title) async {
    http.Client client = new http.Client();
    var response = await client.get(
      "http://musicbrainz.org/ws/2/recording?query="
      "${title.trim()}&dismax=true"
      "&fmt=json"
    );
    client.close();
    return jsonDecode(response.body)["recordings"];
  }

  static Future<TagsControllers> getSongTags(parsedJson, {String artworkLink}) async {
    TagsControllers tagsControllers = TagsControllers();
    tagsControllers.titleController.text = getTitle(parsedJson);
    tagsControllers.artistController.text = getArtist(parsedJson);
    tagsControllers.albumController.text = getAlbum(parsedJson);
    tagsControllers.dateController.text = getDate(parsedJson);
    if (artworkLink == null)
      tagsControllers.artworkController = await getArtwork(parsedJson["releases"][0]["id"]);
    else
      tagsControllers.artworkController = artworkLink;
    tagsControllers.discController.text = getDiscNumber(parsedJson);
    tagsControllers.trackController.text = getTrackNumber(parsedJson);
    tagsControllers.genreController.text = getGenre(parsedJson);
    print(tagsControllers);
    return tagsControllers;
  }

  static String getTitle(parsedJson) {
    return parsedJson["title"];
  }

  static String getArtist(parsedJson) {
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

  static String getAlbum(parsedJson) {
    return parsedJson["releases"][0]["title"];
  }

  static String getTrackNumber(parsedJson) {
    return parsedJson["releases"][0]["media"][0]["track-offset"].toString() ?? "0";
  }

  static String getDiscNumber(parsedJson) {
    return "0";
  }

  static String getDate(parsedJson) {
    return parsedJson["releases"][0]["date"];
  }

  static String getGenre(parsedJson) {
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
    var response = await client.get(
      "http://coverartarchive.org/release/$mbid"
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
    var response = await client.get(
      "http://coverartarchive.org/release/$mbid"
    );
    client.close();
    if (response.body.contains("Not Found")) {
      return null;
    } else {
      var json = jsonDecode(response.body);
      return json["images"][0]["thumbnails"]["large"];
    }
  }

}