import 'dart:async';
import 'dart:io';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_fade/image_fade.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/musicBrainzApi.dart';
import 'package:songtube/players/youtubePlayer.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/routes/components/relatedVideosList.dart';
import 'package:songtube/routes/components/video/shimmer/shimmerArtworkEditor.dart';
import 'package:songtube/routes/components/video/shimmer/shimmerVideoComments.dart';
import 'package:songtube/routes/components/video/shimmer/shimmerVideoEngagement.dart';
import 'package:songtube/routes/components/video/videoDownloadFab.dart';
import 'package:songtube/routes/components/video/videoTags.dart';
import 'package:songtube/downloadMenu/downloadMenu.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:songtube/ui/components/measureSize.dart';
import 'package:songtube/ui/components/tagsResultsPage.dart';
import 'package:songtube/ui/dialogs/loadingDialog.dart';
import 'package:songtube/ui/internal/snackbar.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'components/video/videoDetails.dart';
import 'components/video/videoEngagement.dart';

class YoutubePlayerVideoPage extends StatefulWidget {
  final String url;
  final String thumbnailUrl;
  YoutubePlayerVideoPage({
    @required this.url,
    @required this.thumbnailUrl,
  });

  @override
  _YoutubePlayerVideoPageState createState() => _YoutubePlayerVideoPageState();
}

class _YoutubePlayerVideoPageState extends State<YoutubePlayerVideoPage> {

  GlobalKey<ScaffoldState> scaffoldKey;
  double playerSize;

  bool showPlayer = false;
  bool useFadeInImage = false;
  String thumbnailUrl;

  // Video Player Controller
  VideoPlayerController _controller;

  @override
  void initState() {
    thumbnailUrl = widget.thumbnailUrl;
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () =>
      setState(() => showPlayer = true));
    scaffoldKey = GlobalKey<ScaffoldState>();
    KeyboardVisibility.onChange.listen((bool visible) {
        if (visible == false) FocusScope.of(context).requestFocus(new FocusNode());
      }
    );
    _updateVideo(thumbnail: thumbnailUrl);
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return WillPopScope(
      onWillPop: () {
        manager.youtubeExtractor.killIsolates();
        return Future.value(true);
      },
      child: Scaffold(
        key: scaffoldKey,
        body: FadeInTransition(
          duration: Duration(milliseconds: 400),
          child: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return _portraitPage();
              } else {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: showPlayer && _controller != null 
                    ? Material(
                        color: Colors.black,
                        child: StreamManifestPlayer(
                          manifest: manager.mediaInfoSet.streamManifest,
                          controller: _controller,
                          isFullscreen: true,
                          onVideoEnded: () {
                            if (prefs.youtubeAutoPlay) {
                              manager.streamPlayerAutoPlay();
                              Future.delayed(Duration(milliseconds: 400), () =>_updateVideo());
                            }
                          },
                          onFullscreenTap: () {
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.portraitUp,
                              DeviceOrientation.portraitDown,
                            ]);
                            SystemChrome.setEnabledSystemUIOverlays
                              ([SystemUiOverlay.top, SystemUiOverlay.bottom]);
                          },
                        ),
                      )
                    : _videoLoading()
                );
              }
            }
          ),
        ),
        floatingActionButton: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return VideoDownloadFab(
                readyToDownload: manager.mediaInfoSet.streamManifest == null ||
                  manager.mediaInfoSet.videoDetails == null ? false : true,
                onDownload: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  showModalBottomSheet<dynamic>(
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
                            streamManifest: manager.mediaInfoSet.streamManifest,
                            tags: manager.mediaInfoSet.mediaTags,
                            videoDetails: manager.mediaInfoSet.videoDetails,
                            scaffoldState: scaffoldKey.currentState,
                          ),
                        ],
                      );
                    }
                  );
                },
              );
            } else {
              return Container();
            }
          }
        ),
      ),
    );
  }

  Widget _portraitPage() {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return Column(
      children: <Widget> [
        // Top StatusBar Padding
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          height: MediaQuery.of(context).padding.top,
          width: double.infinity,
        ),
        // Mini-Player
        Container(
          margin: EdgeInsets.only(left: 12, right: 12),
          child: AspectRatio(
            aspectRatio: 16/9,
            child: Hero(
              tag: "${widget.url}player",
              child: MeasureSize(
                onChange: (size) {
                  playerSize = size.height;
                },
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: showPlayer && _controller != null
                    ? StreamManifestPlayer(
                        manifest: manager.mediaInfoSet.streamManifest,
                        controller: _controller,
                        isFullscreen: false,
                        onVideoEnded: () {
                          if (prefs.youtubeAutoPlay) {
                            manager.streamPlayerAutoPlay();
                            Future.delayed(Duration(milliseconds: 400), () =>_updateVideo());
                          }
                        },
                        onFullscreenTap: () {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeRight,
                          ]);
                          SystemChrome.setEnabledSystemUIOverlays([]);
                        },
                      )
                    : _videoLoading()
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: ListView(
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: 12),
                // Video Details
                VideoDetails(
                  infoset: manager.mediaInfoSet,
                ),
                // ---------------------------------------
                // Likes, dislikes, Views and Share button
                // ---------------------------------------
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: manager.mediaInfoSet.videoDetails != null
                    ? ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(height: 12),
                          VideoEngagement(
                            infoset: manager.mediaInfoSet,
                            onSaveToFavorite: () {
                              List<Video> videos = prefs.favoriteVideos;
                              videos.add(manager.mediaInfoSet.videoDetails);
                              prefs.favoriteVideos = videos;
                              AppSnack.showSnackBar(
                                icon: EvaIcons.heartOutline,
                                title: "Video added to Favorites",
                                context: context,
                                scaffoldKey: scaffoldKey.currentState
                              );
                            },
                          ),
                          Divider(),
                          // Tags Editor
                          VideoTags(),
                          Divider(),
                          // Related Videos
                          RelatedVideosList(
                            onVideoTap: (index) {
                              manager.updateMediaInfoSet(
                                manager.mediaInfoSet.relatedVideos[index],
                                manager.mediaInfoSet.relatedVideos
                              );
                              _updateVideo();
                            },
                          )
                        ],
                      )
                    : ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(height: 12),
                          const ShimmerVideoEngagement(),
                          Divider(color: Colors.transparent),
                          const ShimmerVideoComments(),
                          Divider(color: Colors.transparent),
                          const ShimmerArtworkEditor(),
                          Divider(color: Colors.transparent),
                        ],
                      )
                ),
              ],
            ),
          ),
        ),
      ]
    );
  }

  Widget _videoLoading() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          useFadeInImage
          ? ImageFade(
              fadeDuration: Duration(milliseconds: 300),
              width: double.infinity,
              fit: BoxFit.cover,
              image: NetworkImage(thumbnailUrl),
            )
          : Image.network(
              thumbnailUrl, width: double.infinity, fit: BoxFit.cover,
            ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          )
        ],
      ),
    );
  }

  void _updateVideo({String thumbnail}) async {
    ManagerProvider manager = Provider.of<ManagerProvider>(context, listen: false);
    thumbnailUrl = thumbnail == null
      ? manager.mediaInfoSet.videoDetails.thumbnails.highResUrl : thumbnail;
    setState(() => showPlayer = false);
    VideoId id = manager.mediaInfoSet.videoFromSearch.videoId;
    manager.youtubeExtractor.getStreamManifest(id).then((value) {
      manager.mediaInfoSet.streamManifest = value;
      manager.playerStream = value;
      _controller = VideoPlayerController.network(
        manager.mediaInfoSet.streamManifest.muxed.withHighestBitrate().url.toString()
      )..initialize().then((value) {
        _controller.play();
        setState(() { showPlayer = true; useFadeInImage = true; });
      });
    });
  }
}