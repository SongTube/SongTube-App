import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_pip/flutter_pip.dart';
import 'package:flutter_pip/platform_channel/channel.dart';
import 'package:intl/intl.dart';
import 'package:newpipeextractor_dart/models/infoItems/playlist.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:newpipeextractor_dart/models/playlist.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/pages/channel.dart';
import 'package:songtube/players/components/youtubePlayer/ui/comments.dart';
import 'package:songtube/players/components/youtubePlayer/ui/moreDetails.dart';
import 'package:songtube/players/components/youtubePlayer/videoPlayer.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/pages/components/video/shimmer/shimmerVideoEngagement.dart';
import 'package:songtube/downloadMenu/downloadMenu.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/components/addToPlaylist.dart';
import 'package:songtube/ui/components/measureSize.dart';
import 'package:flutter_screen/flutter_screen.dart';
import 'package:songtube/ui/layout/streamsListTile.dart';
import 'package:transparent_image/transparent_image.dart';
import 'ui/details.dart';
import 'ui/engagement.dart';

class YoutubePlayerVideoPage extends StatefulWidget {
  @override
  _YoutubePlayerVideoPageState createState() => _YoutubePlayerVideoPageState();
}

class _YoutubePlayerVideoPageState extends State<YoutubePlayerVideoPage> with TickerProviderStateMixin {

  GlobalKey<ScaffoldState> scaffoldKey;

  // Player Height
  double mainBodyHeight = 0;
  double playerHeight = 0;

  // Pip Status
  bool isInPictureInPictureMode = false;

  // BottomSheet controller
  PersistentBottomSheetController bottomSheetController;

  // Scroll Controller
  ScrollController scrollController;

  // Restoring Scroll position
  bool restoringScroll = false;
  double scrollExcessOffset = 0;

  // Animation controller for hiding Details & Engagement on scroll
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (!restoringScroll)
        animationController.value = 1 - (scrollController.position.pixels.clamp(0, 200))/200;
    });
    animationController = AnimationController(
      vsync: this, value: 1, duration: Duration(milliseconds: 250));
    KeyboardVisibility.onChange.listen((bool visible) {
      if (mounted) {
        if (visible == false) FocusScope.of(context).requestFocus(new FocusNode());
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<VideoPageProvider>(context, listen: false)
        .fwController.open();
    });
  }

  void executeAutoPlay() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context, listen: false);
    StreamInfoItem currentStream = pageProvider.infoItem;
    bool isPlaylist = pageProvider.isPlaylist;
    if (isPlaylist) {
      int currentIndex = pageProvider.currentRelatedVideos.indexOf(currentStream);
      if (currentIndex + 1 <= pageProvider.currentRelatedVideos.length) {
        pageProvider.infoItem = pageProvider.currentRelatedVideos[currentIndex+1];
      }
    } else {
      pageProvider.infoItem = pageProvider.currentRelatedVideos[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    if (bottomSheetController != null && pageProvider.fwController.panelPosition < 1) {
      try {
        bottomSheetController.close();
      } catch (_) {}
      setState(() => bottomSheetController = null);
    }
    return PipWidget(
      onResume: (bool pipMode) {
        setState(() => isInPictureInPictureMode = pipMode);
      },
      child: Scaffold(
        key: scaffoldKey,
        body: _currentWidget(),
      ),
    );
  }

  Widget _currentWidget() {
    if (isInPictureInPictureMode) {
      return _pipWidget();
    } else if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return NotificationListener<ScrollNotification>(
        onNotification: (scroll) {
          if (scroll is ScrollEndNotification) {
            if (scrollController.position.pixels < 100) {
              animationController.animateTo(1).then((_) {
                restoringScroll = true;
                scrollController.animateTo(0,
                  duration: Duration(milliseconds: 150),
                  curve: Curves.ease).then((_) =>
                    restoringScroll = false);
              });
            } else {
              animationController.animateTo(0).then((_) {
                restoringScroll = true;
                if (scrollController.position.pixels < 200) {
                  scrollController.animateTo(200,
                    duration: Duration(milliseconds: 150),
                    curve: Curves.ease).then((_) =>
                      restoringScroll = false);
                }
              });
            }
          }
          return false;
        },
        child: _portraitPage()
      );
    } else {
      return _fullscreenPage();
    }
  }

  Widget _videoPlayerWidget() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return StreamManifestPlayer(
      segments: pageProvider.currentVideo.segments,
      quality: prefs.youtubePlayerQuality,
      onQualityChanged: (String quality) {
        prefs.youtubePlayerQuality = quality;
      },
      borderRadius: MediaQuery.of(context).orientation == Orientation.landscape
        ? 0 : 10,
      key: pageProvider.playerKey,
      videoTitle: pageProvider?.currentVideo?.name ?? "",
      streams: pageProvider.currentVideo.videoOnlyStreams,
      audioStream: pageProvider.currentVideo.getAudioStreamWithBestMatchForVideoStream(
        pageProvider.currentVideo.videoOnlyWithHighestQuality
      ),
      isFullscreen: MediaQuery.of(context).orientation == Orientation.landscape
        ? true : false,
      onAutoPlay: () async {
        if (mounted)
          executeAutoPlay();
      },
      onFullscreenTap: () {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          SystemChrome.setEnabledSystemUIOverlays
            ([SystemUiOverlay.top, SystemUiOverlay.bottom]);
        } else {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
          SystemChrome.setEnabledSystemUIOverlays([]);
        }
      },
      onEnterPipMode: () {
        setState(() => isInPictureInPictureMode = true);
        FlutterPip.enterPictureInPictureMode();
      },
    );
  }

  Widget _pipWidget() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    pageProvider.playerKey?.currentState?.controller?.play();
    pageProvider.fwController.open();
    FlutterScreen.resetBrightness();
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      child: pageProvider.currentVideo != null 
        ? _videoPlayerWidget()
        : _videoLoading(pageProvider.infoItem.thumbnails.hqdefault)
    );
  }

  Widget _fullscreenPage() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      child: pageProvider.currentVideo != null 
        ? _videoPlayerWidget()
        : _videoLoading(pageProvider.infoItem.thumbnails.hqdefault)
    );
  }

  Widget _portraitPage() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    bool isPlaylist = pageProvider.isPlaylist;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays
      ([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    FlutterScreen.resetBrightness();
    return isPlaylist
      ? _portraitPlaylistPage()
      : _portraitVideoPage();
  }

  Widget _portraitMainBody() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays
      ([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    FlutterScreen.resetBrightness();
    return MeasureSize(
      onChange: (Size size) {
        setState(() => mainBodyHeight = size.height);
      },
      child: Column(
        children: [
          // Top StatusBar Padding
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: MediaQuery.of(context).padding.top,
            width: double.infinity,
          ),
          // Mini-Player
          Container(
            margin: EdgeInsets.only(left: 12, right: 12),
            child: MeasureSize(
              onChange: (Size size) {
                playerHeight = size.height;
              },
              child: AspectRatio(
                aspectRatio: 16/9,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: pageProvider.currentVideo != null
                    ? _videoPlayerWidget()
                    : _videoLoading(
                        pageProvider.infoItem is StreamInfoItem
                          ? pageProvider.infoItem.thumbnails.hqdefault
                          : pageProvider.infoItem is PlaylistInfoItem
                            ? pageProvider.infoItem.thumbnailUrl
                            : null,
                      )
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Opacity(
                opacity: (animationController.value - (1 - animationController.value)) > 0
                  ? (animationController.value - (1 - animationController.value)) : 0,
                child: Align(
                  heightFactor: animationController.value,
                  child: child
                ),
              );
            },
            child: Column(
              children: [
                SizedBox(height: 12),
                // Video Details
                _videoDetails(),
                // ---------------------------------------
                // Likes, dislikes, Views and Share button
                // ---------------------------------------
                _videoEngagementWidget(),
                Divider(height: 1),
              ],
            ),
          ),
          // Channel section
          _channelInfo(),
        ],
      ),
    );
  }

  Widget _portraitVideoPage() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom,
              padding: EdgeInsets.only(top: 4),
              child: Column(
                children: <Widget> [
                  _portraitMainBody(),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        children: [
                          // Comments section
                          _commentTile(),
                          StreamsListTileView(
                            scaffoldKey: scaffoldKey.currentState,
                            shrinkWrap: true,
                            removePhysics: true,
                            streams: pageProvider?.currentRelatedVideos == null
                              ? [] : pageProvider.currentRelatedVideos, 
                            onTap: (stream, index) async {
                              pageProvider.infoItem =
                                pageProvider.currentRelatedVideos[index];
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).padding.bottom,
          color: Theme.of(context).cardColor
        )
      ],
    );
  }

  Widget _portraitPlaylistPage() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays
      ([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    FlutterScreen.resetBrightness();
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom,
              padding: EdgeInsets.only(top: 4),
              child: Column(
                children: <Widget> [
                  _portraitMainBody(),
                  // Playlist & Videos
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          // Comments section
                          _commentTile(),
                          SizedBox(height: 12),
                          StreamsListTileView(
                            scaffoldKey: scaffoldKey.currentState,
                            shrinkWrap: true,
                            removePhysics: true,
                            topPadding: false,
                            streams: pageProvider?.currentRelatedVideos == null
                              ? [] : pageProvider.currentRelatedVideos, 
                            onTap: (stream, index) async {
                              pageProvider.infoItem =
                                pageProvider.currentRelatedVideos[index];
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).padding.bottom,
          color: Theme.of(context).cardColor
        )
      ],
    );
  }

  Widget _videoEngagementWidget() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    return AnimatedSize(
      vsync: this,
      duration: Duration(milliseconds: 300),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: pageProvider.currentVideo != null
          ? ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(height: 4),
                VideoEngagement(
                  likeCount: pageProvider.currentVideo.likeCount,
                  dislikeCount: pageProvider.currentVideo.dislikeCount,
                  viewCount: pageProvider.currentVideo.viewCount,
                  onSaveToPlaylist: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)
                        )
                      ),
                      builder: (context) {
                        return AddStreamToPlaylistSheet(stream: pageProvider.infoItem);
                      }
                    );
                  },
                  onDownload: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    showModalBottomSheet<dynamic>(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return DownloadMenu(
                          video: pageProvider.currentVideo,
                          tags: pageProvider.currentTags,
                          scaffoldState: scaffoldKey.currentState,
                          relatedVideos: pageProvider.currentRelatedVideos
                        );
                      }
                    );
                  },
                  onShare: () {
                    Share.share(pageProvider.currentVideo.url);
                  },
                ),
                SizedBox(height: 4),
              ],
            )
          : ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(height: 12),
                const ShimmerVideoEngagement(),
              ],
            )
      ),
    );
  }

  Widget _videoDetails() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    return VideoDetails(
      infoItem: pageProvider.infoItem,
      onMoreDetails: () {
        if (pageProvider.currentVideo == null) return;
        if (bottomSheetController != null) {
          try {
            bottomSheetController?.close();
          } catch (_) {}
          bottomSheetController = null;
          return;
        }
        double height = MediaQuery.of(context).size.height;
        double bottomPadding = MediaQuery.of(context).padding.bottom;
        bottomSheetController = scaffoldKey.currentState.showBottomSheet((context) {
          return Wrap(
            children: [
              Container(
                height: height - mainBodyHeight - bottomPadding - 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)
                  ),
                ),
                child: MoreDetailsSheet(
                  video: pageProvider.currentVideo,
                  segments: pageProvider?.currentVideo?.segments ?? [],
                  onSegmentTap: (position) => pageProvider.playerKey.currentState
                    .controller.seekTo(Duration(seconds: position)),
                  onDispose: () => bottomSheetController = null,
                ),
              ),
              Container(
                height: bottomPadding,
                color: Colors.transparent,
              )
            ],
          );
        });
      },
    );
  }

  Widget _commentTile() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      vsync: this,
      child: pageProvider.currentComments != null
        ? InkWell(
            onTap: () {
              if (bottomSheetController != null) {
                try {
                  bottomSheetController?.close();
                } catch (_) {}
                bottomSheetController = null;
                return;
              }
              double topPadding = MediaQuery.of(context).padding.top;
              bottomSheetController = scaffoldKey.currentState.showBottomSheet((context) {
                return VideoComments(
                  topPadding: topPadding + playerHeight + 8,
                  onDispose: () => bottomSheetController = null,
                );
              });
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "Comments",
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Product Sans'
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 12),
                          Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.only(right: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: FadeInImage(
                                fadeInDuration: Duration(milliseconds: 300),
                                placeholder: MemoryImage(kTransparentImage),
                                image: NetworkImage(pageProvider.currentComments[0].uploaderAvatarUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              pageProvider.currentComments[0].commentText,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).iconTheme.color
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Divider(height: 1)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Icon(EvaIcons.arrowIosForwardOutline,
                    color: Theme.of(context).iconTheme.color,
                    size: 18),
                ),
              ],
            ),
          )
        : Container(),
    );
  }

  Widget _channelInfo() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    return InkWell(
      onTap: () {
        if (pageProvider.currentChannel != null)
          Navigator.push(context,
            BlurPageRoute(
              blurStrength: Provider.of<PreferencesProvider>
                (context, listen: false).enableBlurUI ? 20 : 0,
              builder: (_) => 
              YoutubeChannelPage(
                url: pageProvider.currentChannel.url,
                name: pageProvider.currentChannel.name,
                lowResAvatar: pageProvider.currentChannel.avatarUrl,
          )));
      },
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FadeInImage(
                      fadeInDuration: Duration(milliseconds: 300),
                      placeholder: MemoryImage(kTransparentImage),
                      image: pageProvider.currentChannel != null
                        ? NetworkImage(pageProvider.currentChannel.avatarUrl)
                        : MemoryImage(kTransparentImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pageProvider?.currentChannel?.name ?? "",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Product Sans',
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        pageProvider.currentChannel != null
                         ? "${NumberFormat.compact().format(pageProvider.currentChannel.subscriberCount)} subs"
                         : "",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color
                            .withOpacity(0.8),
                          fontFamily: "Product Sans",
                          fontSize: 12,
                          letterSpacing: 0.2
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // TODO: Implement subs system
                },
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Ink(
                    color: Colors.transparent,
                    child: Text(
                      Languages.of(context).labelSubscribe.toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8)
            ],
          ),
          Divider(height: 1)
        ],
      ),
    );
  }

  Widget _videoLoading(String thumbnailUrl) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
            fadeInDuration: Duration(milliseconds: 250),
            placeholder: MemoryImage(kTransparentImage),
            image: thumbnailUrl == null
              ? MemoryImage(kTransparentImage)
              : NetworkImage(thumbnailUrl),
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ],
    );
  }
}