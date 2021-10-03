import 'dart:convert';

import 'package:http/http.dart';

class LyricsProviders {

  static Future<String> lyricsOvh({String author, String title}) async {
    Client client = Client();
    Response response;
    try {
      response = await client.get(Uri.parse(
        "https://api.lyrics.ovh/v1/"
        "${author.replaceAll('&', '')}/"
        "${title.replaceAll('&', '')}")
      ).timeout(Duration(seconds: 5));
    } catch (_) {
      return "";
    }
    client.close();
    if ((jsonDecode(response.body) as Map).containsKey('error')) {
      return "";
    } else {
      return jsonDecode(response.body)["lyrics"]; 
    }
  }

  static final happiDevKey = "e1de5fbTOztuNxXBGZ1m39MbY0SPfUUQQm2pbLSdEADsMMm1duk4xQBa";

  static Future<String> lyricsHappiDev({String title}) async {
    Client client = Client();
    var response = await client.get(Uri.parse(
      "https://api.happi.dev/v1/music?q=${title.replaceAll('&', '')}"
      "&limit=1&apikey=$happiDevKey&type=track")
    );
    var responseJson = jsonDecode(response.body);
    if (responseJson["success"] == true) {
      var lyricsResponse = await client.get(
        responseJson["result"][0]["api_lyrics"] +
        "?apikey=$happiDevKey"
      );
      var lyricsJson = jsonDecode(lyricsResponse.body);
      if (lyricsJson["success"] == true) {
        return lyricsJson["result"]["lyrics"];
      } else {
        client.close();
        return "";
      }
    } else {
      client.close();
      return "";
    }
  }

  

}