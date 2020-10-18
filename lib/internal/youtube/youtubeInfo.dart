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

  // Get playlist information by URL
  Future<Playlist> getPlaylistDetails(String url) async {

    // Playlist Details
    Playlist playlist;

    // Try get information from URL
    try {
      playlist = await yt.playlists.get(url);
    } catch (_) {}

    // Return Playlist Details
    return playlist;
  }

  // Get playlist videos
  Future<List<Video>> getPlaylistVideos(url) async {
    return await yt.playlists
      .getVideos(PlaylistId.parsePlaylistId(url))
      .take(50).toList();
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

  Future<Channel> getChannel(String url) async {
    return await yt.channels.getByVideo(VideoId.parseVideoId(url));
  }

}