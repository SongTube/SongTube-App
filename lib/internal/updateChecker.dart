import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:songtube/internal/models/updateDetails.dart';

Future<UpdateDetails> getLatestRelease() async {
  try {
    var client = http.Client();
    var headers = {
      "Accept": "application/vnd.github.v3+json"
    };
    var response = await client
      .get("https://api.github.com/repos/SongTube/SongTube-App/releases",
        headers: headers);
    var jsonResponse = jsonDecode(response.body);
    UpdateDetails details = UpdateDetails(
      double.parse(jsonResponse[0]["tag_name"]
        .split("+").first.trim().replaceRange(3, 5, "")),
      jsonResponse[0]["published_at"].split("T").first,
      jsonResponse[0]["body"]
    );
    client.close();
    return details;
  } catch (_) {
    return null;
  }
}

Future<void> queryUpdate() async {

}