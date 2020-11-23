// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/internal/models/infoSets/mediaInfoSet.dart';
import 'package:songtube/players/components/youtubePlayer/pages/playlist.dart';
import 'package:songtube/players/components/youtubePlayer/pages/video.dart';

// Packages
import 'package:provider/provider.dart';

class YoutubePlayerExpanded extends StatelessWidget {
  final Function onArtworkChange;
  YoutubePlayerExpanded({
    @required this.onArtworkChange
  });
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    MediaInfoSet infoSet = manager.mediaInfoSet;
    if (infoSet.mediaType == MediaInfoSetType.Video) {
      return YoutubePlayerVideoPage(
        onArtworkChange: onArtworkChange
      );
    } else {
      return YoutubePlayerPlaylistPage();
    }
  }
}