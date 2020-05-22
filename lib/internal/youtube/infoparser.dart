// UI
import 'package:songtube/ui/snackbar.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeInfo {

  // Get link ID
  static String getLinkID(String url) => YoutubeExplode.parseVideoId(url);

  // Get video information by ID
  static Future<MediaStreamInfoSet> getVideoInfo(id) async {

    // MediaStream
    YoutubeExplode yt = YoutubeExplode();
    MediaStreamInfoSet mediaStream;

    // Try get information from ID
    try {
      mediaStream = await yt.getVideoMediaStream(id);
    } on VideoRequiresPurchaseException catch (_) {
      appSnack.videoIsPremium();
      yt.close(); return null;
    } on Exception catch (_) {
      appSnack.internetError();
      yt.close(); return null;
    }

    // Close YoutubeExplode() instance
    yt.close();

    // Return metadata and mediaStream
    return mediaStream;
  }

}