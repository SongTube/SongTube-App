import 'package:songtube/internal/youtube/youtubeInfo.dart';
import 'package:songtube/internal/youtube/youtubeIsolates.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// This class is designed to Extract all kind of information
/// about any [Video] or [Playlist]
class YoutubeExtractor {

  YoutubeExtractor() {
    youtubeInfo = YoutubeInfo();
  }

  YoutubeInfo youtubeInfo;

  Future<Channel> getChannel(url) async {
    return await YoutubeIsolates.getChannelByVideoId(url);
  }

  // Get Playlist Details
  Future<Playlist> getPlaylistDetails(String url) async {
    if (PlaylistId.parsePlaylistId(url) == null) return null;
    Playlist playlist;
    while (playlist == null) {
      try {
        playlist = await youtubeInfo.getPlaylistDetails(url)
          .timeout(Duration(seconds: 20));
      } catch (_) {}
    }
    return playlist;
  }
  // Get StreamManifest
  Future<StreamManifest> getStreamManifest(String url) async {
    StreamManifest streamManifest;
    while (streamManifest == null) {
      try {
        streamManifest =
          await YoutubeIsolates.getStreamManifest(url)
            .timeout(Duration(seconds: 30));
      } catch (_) {}
    }
    return streamManifest;
  }
  
  // Playlist Details
  Future<List<Video>> getPlaylistVideos(String url) async {
    List<Video> videos;
    while (videos == null) {
      try {
        videos = await youtubeInfo.getPlaylistVideos(url);
      } catch (_) {}
    }
    return videos;
  }

  // Video Comments
  Future<List<Comment>> getVideoComments(Video video) async {
    YoutubeExplode yt = YoutubeExplode();
    List<Comment> comments = await yt.videos.commentsClient
      .getComments(video)
      .take(30).toList();
    yt.close();
    if (comments == null || comments.isEmpty) {
      comments = null;
    }
    return comments;
  }

}