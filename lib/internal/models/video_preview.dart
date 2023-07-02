import 'dart:convert';

import 'package:http/http.dart' as http;

class VideoPreview {

  VideoPreview({
    required this.name,
    required this.author,
    required this.thumbnailUrl,
  });

  final String name;
  final String author;
  final String thumbnailUrl;

  static Future<VideoPreview?> fromUrl(String url) async {
    final response = await http.get(Uri.parse('https://noembed.com/embed?url=${url}'));
    if (response.body.isNotEmpty) {
      final map = jsonDecode(response.body);
      return VideoPreview(
        name: map['title'],
        author: map['author_name'],
        thumbnailUrl: map['thumbnail_url']
      );
    } else {
      return null;
    }
  }

}