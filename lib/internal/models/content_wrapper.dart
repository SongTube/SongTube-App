import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:songtube/internal/models/playback_quality.dart';
import 'package:songtube/services/content_service.dart';
import 'package:songtube/ui/players/video_player/player_widget.dart';
import 'package:songtube/ui/players/video_player/suggestions.dart';

class ContentWrapper {

  ContentWrapper({
    required this.infoItem,
    this.previousUrl,
  });

  // Video/Playlist InfoItem
  final dynamic infoItem;

  // Video Information
  YoutubeVideo? videoDetails;

  // Video Quality
  List<VideoPlaybackQuality>? get videoOnlyOptions =>
    videoDetails != null ? VideoPlaybackQuality.fetchAllVideoOnlyQuality(videoDetails!) : null;

  // Video Quality
  List<VideoPlaybackQuality>? get videoOptions =>
    videoDetails != null ? VideoPlaybackQuality.fetchAllVideoQuality(videoDetails!) : null;

  // Playlist Information
  YoutubePlaylist? playlistDetails;

  // Selected playlist video index
  int? selectedPlaylistIndex;

  // Video Player Controller
  VideoPlayerWidgetController videoPlayerController = VideoPlayerWidgetController();

  // Youtube Video Suggestions Controller
  VideoSuggestionsController videoSuggestionsController = VideoSuggestionsController();

  // Previous ContentWrapper video url
  String? previousUrl;

  Future<void> loadWrapper() async {
    if (infoItem is StreamInfoItem) {
      try {
        videoDetails = await ContentService.fetchVideoFromInfoItem(infoItem);
      } catch (e) {
        errorMessage = e.toString();
      }
    } else if (infoItem is PlaylistInfoItem) {
      try {
        if (playlistDetails == null) {
          playlistDetails = await ContentService.fetchPlaylistFromInfoItem(infoItem);
          await playlistDetails!.getStreams();
        }
        if (previousUrl != playlistDetails?.streams?.first.url) {
          videoDetails = await ContentService.fetchVideoFromInfoItem(playlistDetails!.streams!.first);
          selectedPlaylistIndex = 0;
        } else {
          videoDetails = await ContentService.fetchVideoFromInfoItem(playlistDetails!.streams![1]);
          selectedPlaylistIndex = 1;
        }
      } catch (e) {
        errorMessage = e.toString();
      }
    } else {
      errorMessage = 'InfoItem is an invalid object';
    }
  }

  // Error Message
  String? errorMessage;

}