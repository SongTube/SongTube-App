import 'dart:async';
import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/models/channel.dart';
import 'package:newpipeextractor_dart/models/infoItems/playlist.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/internal/musicBrainzApi.dart';
import 'package:songtube/pages/components/relatedVideosList.dart';
import 'package:songtube/players/components/youtubePlayer/ui/comments.dart';
import 'package:songtube/players/components/youtubePlayer/videoPlayer.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/pages/components/video/shimmer/shimmerArtworkEditor.dart';
import 'package:songtube/pages/components/video/shimmer/shimmerVideoComments.dart';
import 'package:songtube/pages/components/video/shimmer/shimmerVideoEngagement.dart';
import 'package:songtube/players/components/youtubePlayer/ui/fab.dart';
import 'package:songtube/players/components/youtubePlayer/ui/tags.dart';
import 'package:songtube/downloadMenu/downloadMenu.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:songtube/ui/components/measureSize.dart';
import 'package:songtube/ui/components/tagsResultsPage.dart';
import 'package:songtube/ui/dialogs/loadingDialog.dart';
import 'package:songtube/ui/internal/snackbar.dart';
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
  double playerHeight = 0;

  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
    KeyboardVisibility.onChange.listen((bool visible) {
      if (mounted) {
        if (visible == false) FocusScope.of(context).requestFocus(new FocusNode());
      }
    });
  }

  void executeAutoPlay() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context, listen: false);
    StreamInfoItem currentStream = pageProvider.infoItem;
    bool isPlaylist = pageProvider.infoItem is StreamInfoItem &&
      pageProvider.currentPlaylist != null;
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
    return Scaffold(
      key: scaffoldKey,
      body: FadeInTransition(
        duration: Duration(milliseconds: 400),
        child: MediaQuery.of(context).orientation == Orientation.portrait
          ? SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: _portraitPage()
              )
            )
          : _fullscreenPage(),
        ),
      floatingActionButton: _fab()
    );
  }

  Widget _fullscreenPage() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      child: pageProvider.currentVideo != null 
        ? StreamManifestPlayer(
            videoTitle: pageProvider.currentVideo.name,
            key: pageProvider.playerKey,
            streams: pageProvider.currentVideo.videoOnlyStreams,
            audioStream: pageProvider.currentVideo.getAudioStreamWithBestMatchForVideoStream(
              pageProvider.currentVideo.videoOnlyWithHighestQuality
            ),
            isFullscreen: true,
            onVideoEnded: () async {
              if (prefs.youtubeAutoPlay) {
                executeAutoPlay();
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
          )
        : _videoLoading(pageProvider.infoItem.thumbnails.hqdefault)
    );
  }

  Widget _portraitPage() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    bool isPlaylist = pageProvider.infoItem is StreamInfoItem &&
      pageProvider.currentPlaylist != null;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays
      ([SystemUiOverlay.top, SystemUiOverlay.bottom]);
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
          child: MeasureSize(
            onChange: (Size size) {
              playerHeight = size.height;
            },
            child: AspectRatio(
              aspectRatio: 16/9,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: pageProvider.currentVideo != null
                  ? StreamManifestPlayer(
                      videoTitle: pageProvider.currentVideo.name,
                      key: pageProvider.playerKey,
                      streams: pageProvider.currentVideo.videoOnlyStreams,
                      audioStream: pageProvider.currentVideo.audioWithBestOggQuality,
                      isFullscreen: false,
                      onVideoEnded: () async {
                        if (prefs.youtubeAutoPlay) {
                          executeAutoPlay();
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
        SizedBox(height: 12),
        // Video Details
        VideoDetails(
          infoItem: pageProvider.infoItem,
          uploaderAvatarUrl: pageProvider.currentChannel?.avatarUrl ?? null,
        ),
        // ---------------------------------------
        // Likes, dislikes, Views and Share button
        // ---------------------------------------
        _videoEngagementWidget(),
        Divider(height: 1),
        Expanded(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(height: !isPlaylist ? 4 : 0),
                // Tags Editor (Not available on Playlists)
                if (!isPlaylist)
                AnimatedSize(
                  vsync: this,
                  duration: Duration(milliseconds: 300),
                  child: VideoTags(
                    tags: pageProvider.currentTags,
                    infoItem: pageProvider.infoItem is StreamInfoItem
                      ? pageProvider.infoItem : null,
                    onAutoTag: () async {
                      showDialog(
                        context: context,
                        builder: (_) => LoadingDialog()
                      );
                      String lastArtwork = pageProvider.currentTags.artworkController;
                      var record = await MusicBrainzAPI
                        .getFirstRecord(pageProvider.currentTags.titleController.text);
                      pageProvider.currentTags = await MusicBrainzAPI.getSongTags(record);
                      if (pageProvider.currentTags.artworkController == null)
                        pageProvider.currentTags.artworkController = lastArtwork;
                      Navigator.pop(context);
                      setState(() {});
                    },
                    onManualTag: () async {
                      var record = await Navigator.push(context,
                        BlurPageRoute(builder: (context) => 
                          TagsResultsPage(
                            title: pageProvider.currentTags.titleController.text,
                            artist: pageProvider.currentTags.artistController.text
                          )));
                      if (record == null) return;
                      showDialog(
                        context: context,
                        builder: (_) => LoadingDialog()
                      );
                      String lastArtwork = pageProvider.currentTags.artworkController;
                      pageProvider.currentTags = await MusicBrainzAPI.getSongTags(record);
                      if (pageProvider.currentTags.artworkController == null)
                        pageProvider.currentTags.artworkController = lastArtwork;
                      Navigator.pop(context);
                    },
                    onSearchDevice: () async {
                      File image = File((await FilePicker.platform
                        .pickFiles(type: FileType.image))
                        .paths[0]);
                      if (image == null) return;
                      pageProvider.currentTags.artworkController = image.path;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: !isPlaylist ? 4 : 0),
                if (!isPlaylist)
                Divider(height: 1),
                SizedBox(height: !isPlaylist ? 8 : 8),
                // Related Videos
                RelatedVideosList(
                  related: pageProvider?.currentRelatedVideos == null
                    ? [] : pageProvider.currentRelatedVideos, 
                  isPlaylist: isPlaylist,
                  onVideoTap: (index) async {
                    pageProvider.infoItem =
                      pageProvider.currentRelatedVideos[index];
                  },
                )
              ],
            ),
          ),
        ),
      ]
    );
  }

  Widget _fab() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return VideoDownloadFab(
            readyToDownload: pageProvider.currentVideo == null ? false : true,
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
                        video: pageProvider.currentVideo,
                        tags: pageProvider.currentTags,
                        scaffoldState: scaffoldKey.currentState,
                        relatedVideos: pageProvider.currentRelatedVideos
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
    );
  }

  Widget _videoEngagementWidget() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
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
                SizedBox(height: 8),
                VideoEngagement(
                  likeCount: pageProvider.currentVideo.likeCount,
                  dislikeCount: pageProvider.currentVideo.dislikeCount,
                  viewCount: pageProvider.currentVideo.viewCount,
                  onSaveToPlaylist: () {
                    List<StreamInfoItem> videos = prefs.favoriteVideos;
                    videos.add(pageProvider.infoItem);
                    prefs.favoriteVideos = videos;
                    AppSnack.showSnackBar(
                      icon: EvaIcons.heartOutline,
                      title: "Video added to Favorites",
                      context: context,
                      scaffoldKey: scaffoldKey.currentState
                    );
                  },
                  onOpenComments: () {
                    double topPadding = MediaQuery.of(context).padding.top;
                    scaffoldKey.currentState.showBottomSheet((context) {
                      return VideoComments(
                        infoItem: pageProvider.infoItem,
                        topPadding: topPadding + playerHeight + 8,
                      );
                    });
                  },
                ),
                SizedBox(height: 8),
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