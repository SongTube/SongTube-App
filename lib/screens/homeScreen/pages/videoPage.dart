// Dart
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/metadata.dart';
import 'package:songtube/provider/configurationProvider.dart';
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
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:file_picker/file_picker.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// UI
import 'package:songtube/ui/animations/FadeIn.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  
  final dismissKey = GlobalKey();

  // Player Controller
  YoutubePlayerController playerController;

  @override
  void dispose() {
    playerController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context);
    return Scaffold(
      body: FadeInTransition(
        duration: Duration(milliseconds: 400),
        child: Dismissible(
          key: dismissKey,
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            manager.updateHomeScreen(LoadingStatus.Unload);
          },
          child: ListView(
            padding: EdgeInsets.zero,
            physics: BouncingScrollPhysics(),
            children: <Widget> [
              // Mini-Player
              HomeScreenYoutubeVideoPlayer(
                playerController: manager.youtubePlayerController,
                playerThumbnailUrl: manager.videoDetails.thumbnails.mediumResUrl,
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
              // ---------------------------------------
              // Likes, dislikes, Views and Share button
              // ---------------------------------------
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
                    File image = File((await FilePicker.platform
                      .pickFiles(type: FileType.image))
                      .paths[0]);
                    if (image == null) return;
                    setState(() {
                      manager.tagsControllers.artworkController = image.path;
                    });
                  },
                  artworkUrl: manager.tagsControllers.artworkController
                ),
              ),
              // Tags Editor
              VideoPageTagsTextFields(manager.tagsControllers),
              SizedBox(height: 8),
            ]
          ),
        ),
      ),
      floatingActionButton: VideoPageFloatingActionButton(
        readyToDownload: manager.streamManifest == null ? false : true,
        onDownload: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          List<dynamic> response = await showModalBottomSheet<dynamic>(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
              ),
            ),
            clipBehavior: Clip.antiAlias,
            context: context,
            builder: (context) {
              return Wrap(
                children: [
                  DownloadMenu(
                    videoList: manager.streamManifest.videoOnly
                      .sortByVideoQuality(),
                    audioList: manager.streamManifest.audioOnly
                      .sortByBitrate(),
                    audioSize: manager.streamManifest.audioOnly
                      .withHighestBitrate().size.totalMegaBytes,
                  ),
                ],
              );
            }
          );
          if (response == null) return;
          manager.navigateToScreen(LibraryScreen.Downloads);
          downloadsProvider.handleVideoDownload(
            language: Languages.of(context),
            currentAppData: Provider.of<ConfigurationProvider>(context, listen: false),
            metadata: DownloadMetaData(
              title: manager.tagsControllers.titleController.text,
              album: manager.tagsControllers.albumController.text,
              artist: manager.tagsControllers.artistController.text
                .replaceAll("- Topic", "").trim(),
              genre: manager.tagsControllers.genreController.text,
              coverurl: manager.tagsControllers.artworkController,
              date: manager.tagsControllers.dateController.text,
              disc: manager.tagsControllers.discController.text,
              track: manager.tagsControllers.trackController.text
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