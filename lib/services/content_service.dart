import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/extractors/playlist.dart';
import 'package:newpipeextractor_dart/extractors/trending.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;

class ContentService {

  // Get list of trending videos 
  static Future<List<StreamInfoItem>?> getTrendingPage() async {
    return await TrendingExtractor.getTrendingVideos();
  }

  // Fetch a Video/Playlist from URL
  static Future<dynamic> fetchInfoItemFromUrl(String? url) async {
    if (isNull(url) || !isURL(url)) return null;
    // Check if url is a playlist
    if (url!.contains('list=')) {
      try {
        final playlist = await PlaylistExtractor.getPlaylistDetails(url);
        await playlist.getStreams();
        return playlist;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      try {
        final video = await VideoExtractor.getStream(url);
        return video;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  // Fetch a Video from StreamItem
  static Future<YoutubeVideo?> fetchVideoFromInfoItem(StreamInfoItem infoItem) async {
    try {
      return await VideoExtractor.getStream(infoItem.url);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  // Fetch a Playlist from PlaylistItem
  static Future<YoutubePlaylist?> fetchPlaylistFromInfoItem(PlaylistInfoItem infoItem) async {
    try {
      final playlist = await PlaylistExtractor.getPlaylistDetails(infoItem.url);
      await playlist.getStreams();
      return playlist;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  // Fetch the Avatar Picture of a channel by using the channel url
  // If this image does not exist, download and save it, next time, we
  // load from local, by default this retrieves the low quality image,
  // but if the high quality already exist, we trieve that one instead.
  static Future<File> channelAvatarPictureFile(String channelUrl) async {
    final cacheDirectory = await getTemporaryDirectory();
    final file = File('${cacheDirectory.path}/${channelUrl.split('channel/').last}');
    if (await file.exists()) {
      return file;
    } else {
      final channel = await ChannelExtractor.channelInfo(channelUrl);
      final avatarUrl = channel.avatarUrl;
      final data = await http.get(Uri.parse(avatarUrl!));
      final bytes = data.bodyBytes;
      file.writeAsBytes(bytes);
      return file;
    }
  }

}