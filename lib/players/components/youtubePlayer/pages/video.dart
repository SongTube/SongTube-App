import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eva_icons_flutter/icon_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/infoSets/mediaInfoSet.dart';
import 'package:songtube/internal/models/metadata.dart';
import 'package:songtube/internal/youtube/youtubeExtractor.dart';
import 'package:songtube/players/components/youtubePlayer/components/videoPage/artworkEditor.dart';
import 'package:songtube/players/components/youtubePlayer/components/videoPage/engagementTiles.dart';
import 'package:songtube/players/components/youtubePlayer/components/videoPage/floatingActionButton.dart';
import 'package:songtube/players/components/youtubePlayer/components/videoPage/tagsTextFields.dart';
import 'package:songtube/players/components/youtubePlayer/components/videoPage/videoComments.dart';
import 'package:songtube/players/components/youtubePlayer/components/videoPage/videoDetails.dart';
import 'package:songtube/players/components/youtubePlayer/components/videoPage/youtubeVideoPlayer.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/homeScreen/downloadMenu/downloadMenu.dart';
import 'package:songtube/screens/homeScreen/shimmer/shimmerVideoPage.dart';
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:songtube/ui/components/measureSize.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubePlayerVideoPage extends StatefulWidget {
  final Function onArtworkChange;
  YoutubePlayerVideoPage({
    @required this.onArtworkChange
  });

  @override
  _YoutubePlayerVideoPageState createState() => _YoutubePlayerVideoPageState();
}

class _YoutubePlayerVideoPageState extends State<YoutubePlayerVideoPage> {

  GlobalKey<ScaffoldState> scaffoldKey;
  double playerSize;

  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
    KeyboardVisibility.onChange.listen((bool visible) {
        if (visible == false) FocusScope.of(context).requestFocus(new FocusNode());
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context);
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    String id = manager.mediaInfoSet.videoFromSearch.videoId.value;
    return Scaffold(
      key: scaffoldKey,
      body: FadeInTransition(
        duration: Duration(milliseconds: 400),
        child: Column(
          children: <Widget> [
            // Top StatusBar Padding
            Container(
              color: Colors.black,
              height: MediaQuery.of(context).padding.top,
              width: double.infinity,
            ),
            // Mini-Player
            MeasureSize(
              onChange: (size) {
                setState(() => playerSize = size.height);
              },
              child: YoutubeVideoPlayer(
                playerController: manager.youtubePlayerController,
                playerThumbnailUrl: "http://img.youtube.com/vi/$id/mqdefault.jpg",
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: manager.mediaInfoSet.videoDetails != null ? ListView(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  children: [
                    // Video Details
                    VideoPageDetails(
                      title: manager.mediaInfoSet.videoDetails.title,
                      author: manager.mediaInfoSet.videoDetails.author,
                      duration: manager.mediaInfoSet.videoDetails.duration.inMinutes.remainder(60).toString().padLeft(2, '0') + " min "
                        + manager.mediaInfoSet.videoDetails.duration.inSeconds.remainder(60).toString().padLeft(2, '0') + " sec",
                      date: "${manager.mediaInfoSet.videoDetails.uploadDate.year}/" +
                        "${manager.mediaInfoSet.videoDetails.uploadDate.month}/" +
                        "${manager.mediaInfoSet.videoDetails.uploadDate.day}",
                      channelLogo: manager.mediaInfoSet.channelDetails != null
                        ? manager.mediaInfoSet.channelDetails.logoUrl : null
                    ),
                    // ---------------------------------------
                    // Likes, dislikes, Views and Share button
                    // ---------------------------------------
                    VideoPageEngagementTiles(
                      likeCount: manager.mediaInfoSet.videoDetails.engagement.likeCount,
                      dislikeCount: manager.mediaInfoSet.videoDetails.engagement.dislikeCount,
                      viewCount: manager.mediaInfoSet.videoDetails.engagement.viewCount,
                      channelUrl: manager.mediaInfoSet.channelDetails != null
                        ? manager.mediaInfoSet.channelDetails.url : null,
                      videoUrl: manager.mediaInfoSet.videoDetails.url,
                    ),
                    // Comments
                    Divider(),
                    InkWell(
                      onTap: () {
                        double topPadding = MediaQuery.of(context).padding.top;
                        scaffoldKey.currentState.showBottomSheet((context) {
                          return VideoComments(
                            video: manager.mediaInfoSet.videoDetails,
                            topPadding: topPadding + playerSize,
                          );
                        });
                      },
                      child: Ink(
                        height: 40,
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(EvaIcons.messageCircleOutline,
                              color: Theme.of(context).iconTheme.color),
                            SizedBox(width: 8),
                            Text(
                              "Comments",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            Spacer(),
                            Icon(EvaIcons.chevronDownOutline,
                              color: Theme.of(context).iconTheme.color),
                            SizedBox(width: 16)
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    // Artwork Editor
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                      child: VideoPageArtworkEditor(
                        onArtworkTap: () => widget.onArtworkChange,
                        artworkUrl: manager.mediaInfoSet.mediaTags.artworkController
                      ),
                    ),
                    // Tags Editor
                    VideoPageTagsTextFields(manager.mediaInfoSet.mediaTags),
                    SizedBox(height: 8),
                  ],
                ) : ShimmerVideoPage()
              ),
            ),
          ]
        ),
      ),
      floatingActionButton: VideoPageFloatingActionButton(
        readyToDownload: manager.mediaInfoSet.streamManifest == null ? false : true,
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
                    videoList: manager.mediaInfoSet.streamManifest.videoOnly
                      .sortByVideoQuality(),
                    audioList: manager.mediaInfoSet.streamManifest.audioOnly
                      .sortByBitrate(),
                    audioSize: manager.mediaInfoSet.streamManifest.audioOnly
                      .withHighestBitrate().size.totalMegaBytes,
                  ),
                ],
              );
            }
          );
          if (response == null) return;
          manager.expandablePlayerPanelController.close();
          await Future.delayed(Duration(milliseconds: 400));
          manager.screenIndex = 1;
          await Future.delayed(Duration(milliseconds: 400));
          downloadsProvider.handleVideoDownload(
            language: Languages.of(context),
            config: Provider.of<ConfigurationProvider>(context, listen: false),
            metadata: DownloadMetaData(
              title: manager.mediaInfoSet.mediaTags.titleController.text,
              album: manager.mediaInfoSet.mediaTags.albumController.text,
              artist: manager.mediaInfoSet.mediaTags.artistController.text
                .replaceAll("- Topic", "").trim(),
              genre: manager.mediaInfoSet.mediaTags.genreController.text,
              coverurl: manager.mediaInfoSet.mediaTags.artworkController,
              date: manager.mediaInfoSet.mediaTags.dateController.text,
              disc: manager.mediaInfoSet.mediaTags.discController.text,
              track: manager.mediaInfoSet.mediaTags.trackController.text
            ),
            manifest: manager.mediaInfoSet.streamManifest,
            videoDetails: manager.mediaInfoSet.videoDetails,
            data: response
          );
        },
      ),
    );
  }
}