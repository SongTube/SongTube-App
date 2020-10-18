// Dart
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';

// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/internal/models/metadata.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/provider/downloadsProvider.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/homeScreen/components/youtubeVideoPlayer.dart';
import 'package:songtube/screens/homeScreen/pages/components/videoPage/artworkEditor.dart';
import 'package:songtube/screens/homeScreen/pages/components/videoPage/engagementTiles.dart';
import 'package:songtube/screens/homeScreen/pages/components/videoPage/floatingActionButton.dart';
import 'package:songtube/screens/homeScreen/downloadMenu/downloadMenu.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:songtube/screens/homeScreen/pages/components/videoPage/tagsTextFields.dart';
import 'package:songtube/screens/homeScreen/pages/components/videoPage/videoDetails.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// UI
import 'package:songtube/ui/animations/FadeIn.dart';

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeInTransition(
      duration: Duration(milliseconds: 400),
      child: Dismissible(
        resizeDuration: Duration(milliseconds: 100),
        movementDuration: Duration(milliseconds: 100),
        key: GlobalKey(),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            Provider.of<ManagerProvider>(context, listen: false)
              .updateHomeScreen(LoadingStatus.Unload);
          },
          child: VideoPageBody(),
      ),
    );
  }
}

class VideoPageBody extends StatefulWidget {
  @override
  _VideoPageBodyState createState() => _VideoPageBodyState();
}

class _VideoPageBodyState extends State<VideoPageBody> {
  
  // Open Player
  bool openPlayer;

  // Tags Controllers
  TagsControllers tagsControllers;

  @override
  void initState() {
    openPlayer = false;
    tagsControllers = new TagsControllers();
    tagsControllers.updateTextControllers(
      Provider.of<ManagerProvider>
        (context, listen: false).videoDetails
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        children: <Widget> [
          // Mini-Player
          HomeScreenYoutubeVideoPlayer(
            openPlayer: openPlayer,
            playerController: YoutubePlayerController(
              initialVideoId: manager.videoDetails.id.value,
              flags: YoutubePlayerFlags(
                autoPlay: true
              )
            ),
            playerThumbnailUrl: manager.videoDetails.thumbnails.mediumResUrl,
            onPlayPressed: () => setState(() => openPlayer = true)
          ),
          // Video Details
          VideoPageDetails(
            title: manager.videoDetails.title,
            author: manager.videoDetails.author,
            duration: manager.videoDetails.duration.inMinutes.remainder(60).toString().padLeft(2, '0') + " min "
              + manager.videoDetails.duration.inSeconds.remainder(60).toString().padLeft(2, '0') + " sec",
            date: "${manager.videoDetails.uploadDate.year}/" +
              "${manager.videoDetails.uploadDate.month}/" +
              "${manager.videoDetails.uploadDate.day}",
            channelLogo: manager.channelDetails != null
              ? manager.channelDetails.logoUrl : null
          ),
          // Likes, dislikes, Views and Share button
          VideoPageEngagementTiles(
            likeCount: manager.videoDetails.engagement.likeCount,
            dislikeCount: manager.videoDetails.engagement.dislikeCount,
            viewCount: manager.videoDetails.engagement.viewCount,
            channelUrl: manager.channelDetails != null
              ? manager.channelDetails.url : null,
            videoUrl: manager.videoDetails.url,
          ),
          // Artwork Editor
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
            child: VideoPageArtworkEditor(
              onArtworkTap: () async {
                File image = await FilePicker.getFile(type: FileType.image);
                if (image == null) return;
                setState(() {
                  tagsControllers.artworkController = image.path;
                });
              },
              artworkUrl: tagsControllers.artworkController
            ),
          ),
          // Tags Editor
          VideoPageTagsTextFields(tagsControllers),
          SizedBox(height: 8),
        ]
      ),
      floatingActionButton: VideoPageFloatingActionButton(
        readyToDownload: manager.streamManifest == null ? false : true,
        onDownload: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          List<dynamic> response = await showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
              ),
            ),
            context: context,
            builder: (context) {
              return DownloadMenu(
                videoList: manager.streamManifest.videoOnly
                  .sortByVideoQuality(),
                audioSize: manager.streamManifest.audioOnly
                  .withHighestBitrate().size.totalMegaBytes,
              );
            }
          );
          if (response == null) return;
          manager.navigateToScreen(LibraryScreen.Downloads);
          downloadsProvider.handleVideoDownload(
            currentAppData: Provider.of<AppDataProvider>(context, listen: false),
            metadata: DownloadMetaData(
              title: tagsControllers.titleController.text,
              album: tagsControllers.albumController.text,
              artist: tagsControllers.artistController.text,
              genre: tagsControllers.genreController.text,
              coverurl: tagsControllers.artworkController,
              date: tagsControllers.dateController.text,
              disc: tagsControllers.discController.text,
              track: tagsControllers.trackController.text
            ),
            manifest: manager.streamManifest,
            videoDetails: manager.videoDetails,
            data: response
          );
        },
      ),
    );
  }
}