import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:songtube/internal/models/infoSets/mediaInfoSet.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/players/components/youtubePlayer/collapsed.dart';
import 'package:songtube/players/components/youtubePlayer/expanded.dart';

class YoutubePlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    MediaInfoSet infoSet = manager.mediaInfoSet;
    return IgnorePointer(
      ignoring: infoSet != null ? false : true,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: infoSet != null ? 1.0 : 0.0,
        child: SlidingUpPanel(
          backdropColor: Colors.transparent,
          backdropEnabled: true,
          controller: manager.expandablePlayerPanelController,
          enableBottomNavigationBarMargin: true,
          minHeight: kToolbarHeight * 1.15,
          backdropBlurStrength: 15,
          maxHeight: MediaQuery.of(context).size.height,
          onPanelSlide: (double position) {
            if (position > 0.95) {
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                ),
              );
            } else {
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle(
                  statusBarIconBrightness:
                    Theme.of(context).brightness == Brightness.dark ?  Brightness.light : Brightness.dark,
                ),
              );
            }
          },
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              offset: Offset(0,-5),
              color: Colors.black.withOpacity(0.05)
            )
          ],
          color: Theme.of(context).cardColor,
          panel: manager.mediaInfoSet != null
            ? YoutubePlayerExpanded(
                onArtworkChange: () async {
                  File image = File((await FilePicker.platform
                    .pickFiles(type: FileType.image))
                    .paths[0]);
                  if (image == null) return;
                  manager.mediaInfoSet.mediaTags
                    .artworkController = image.path;
                },
              )
            : Container(),
          collapsed: manager.mediaInfoSet != null
            ? infoSet.mediaType == MediaInfoSetType.Video
                ? YoutubePlayerCollapsed(
                    playerController: manager.youtubePlayerController,
                    videoTitle: infoSet.videoFromSearch.videoTitle,
                    videoAuthor: infoSet.videoFromSearch.videoAuthor,
                    artworkUrl: "https://i.ytimg.com" +
                      infoSet.videoFromSearch
                        .videoThumbnails.last.url.path
                  )
                : YoutubePlayerCollapsed(
                    playerController: manager.youtubePlayerController,
                    videoTitle: manager.youtubePlayerController != null
                      ? manager.youtubePlayerController.value.metaData.title
                      : infoSet.playlistFromSearch.playlistTitle,
                    videoAuthor: manager.youtubePlayerController != null
                      ? manager.youtubePlayerController.value.metaData.author
                      : "Playlist",
                    artworkUrl: manager.youtubePlayerController != null
                      ? "https://img.youtube.com/vi/" +
                        "${manager.youtubePlayerController.value.metaData.videoId}" +
                        "/mqdefault.jpg"
                      : null
                  )
            : Container(),
        ),
      ),
    );
  }
}