import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeInfo {
  // Get video information by URL
  Future<Video> getVideoDetails(String url) async {
    YoutubeExplode yt = YoutubeExplode();
    Video video;
    try {
      video = await yt.videos.get(url);
    } on VideoRequiresPurchaseException catch (_) {} on Exception catch (_) {}
    yt.close();
    return video;
  }

  // Get playlist information by URL
  Future<Playlist> getPlaylistDetails(String url) async {
    YoutubeExplode yt = YoutubeExplode();
    Playlist playlist;
    try {
      playlist = await yt.playlists.get(url);
    } catch (_) {}
    yt.close();
    return playlist;
  }

  // Get playlist videos
  Future<List<Video>> getPlaylistVideos(url) async {
    YoutubeExplode yt = YoutubeExplode();
    List<Video> videos = await yt.playlists
      .getVideos(PlaylistId.parsePlaylistId(url))
      .take(50).toList();
    yt.close();
    return videos;
  }

  // Get video Manifest by URL
  Future<StreamManifest> getVideoManifest(String url) async {
    YoutubeExplode yt = YoutubeExplode();
    StreamManifest manifest;
    try {
      manifest = await yt.videos.streamsClient.getManifest(
        VideoId.parseVideoId(url)
      );
    } catch (_) {}
    yt.close();
    return manifest;
  }

  // Get video ID by URL
  String getVideoID(String url) {
    return VideoId.parseVideoId(url);
    
  }

  Future<Channel> getChannel(String url) async {
    YoutubeExplode yt = YoutubeExplode();
    Channel channel = await yt.channels
      .getByVideo(VideoId.parseVideoId(url));
    yt.close();
    return channel;
  }

}