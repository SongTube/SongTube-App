import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeInfo {

  YoutubeInfo() {
    yt = new YoutubeExplode();
  }

  // Youtube Explode
  YoutubeExplode yt;

  // Get video information by URL
  Future<Video> getVideoDetails(String url) async {

    // Video Details
    Video video;

    // Try get information from URL
    try {
      video = await yt.videos.get(url);
    } on VideoRequiresPurchaseException catch (_) {} on Exception catch (_) {}

    // Return Video Details
    return video;
  }

  // Get video Manifest by URL
  Future<StreamManifest> getVideoManifest(String url) async {
    StreamManifest manifest;
    try {
      manifest = await yt.videos.streamsClient.getManifest(
        VideoId.parseVideoId(url)
      );
    } catch (_) {return null;}
    return manifest;
  }

  // Get video ID by URL
  String getVideoID(String url) {
    return VideoId.parseVideoId(url);
    
  }

  Future<String> getChannelLink(String url) async {
    // Get channel by URL
    String channelUrl;
    await yt.channels.getByVideo(VideoId.parseVideoId(url)).then((value) => {
      channelUrl = value.url
    });
    return channelUrl;
  }

}