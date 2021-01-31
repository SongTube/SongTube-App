import 'dart:async';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
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
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:songtube/ui/internal/snackbar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'components/video/videoDetails.dart';
import 'components/video/videoEngagement.dart';

class YoutubePlayerVideoPage extends StatefulWidget {
  final bool isPlaylist;
  YoutubePlayerVideoPage({
    this.isPlaylist = false
  });

  @override
  _YoutubePlayerVideoPageState createState() => _YoutubePlayerVideoPageState();
}

class _YoutubePlayerVideoPageState extends State<YoutubePlayerVideoPage> {

  GlobalKey<ScaffoldState> scaffoldKey;

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
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: MediaQuery.of(context).orientation == Orientation.portrait
              ? _portraitPage()
              : AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: manager.playerController != null 
                    ? Material(
                        color: Colors.black,
                        child: StreamManifestPlayer(
                          manifest: manager.mediaInfoSet.streamManifest,
                          controller: manager.playerController,
                          isFullscreen: true,
                          onVideoEnded: () async {
                            if (prefs.youtubeAutoPlay) {
                              int currentIndex = manager.mediaInfoSet.autoPlayIndex;
                              if (currentIndex <= manager.mediaInfoSet.relatedVideos.length-1) {
                                manager.updateBySearchResult(
                                  manager.mediaInfoSet.relatedVideos[currentIndex]
                                );
                                await manager.updateCurrentManifest(
                                  manager.mediaInfoSet.relatedVideos[currentIndex].id
                                );
                                manager.updateCurrentChannel(
                                  manager.mediaInfoSet.relatedVideos[currentIndex].id
                                );
                                manager.mediaInfoSet.autoPlayIndex += 1;
                              }
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
            )
          ),
        ),
        floatingActionButton: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return VideoDownloadFab(
                isPlaylist: widget.isPlaylist,
                readyToDownload: manager.playerController == null ||
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
                            playlistVideos: manager.mediaInfoSet.relatedVideos
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
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              child: manager.playerController != null
                ? StreamManifestPlayer(
                    manifest: manager.mediaInfoSet.streamManifest,
                    controller: manager.playerController,
                    isFullscreen: false,
                    onVideoEnded: () async {
                      if (prefs.youtubeAutoPlay) {
                        int currentIndex = manager.mediaInfoSet.autoPlayIndex;
                        if (currentIndex <= manager.mediaInfoSet.relatedVideos.length-1) {
                          manager.updateBySearchResult(
                            manager.mediaInfoSet.relatedVideos[currentIndex]
                          );
                          await manager.updateCurrentManifest(
                            manager.mediaInfoSet.relatedVideos[currentIndex].id
                          );
                          manager.updateCurrentChannel(
                            manager.mediaInfoSet.relatedVideos[currentIndex].id
                          );
                          manager.mediaInfoSet.autoPlayIndex += 1;
                        }
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
        Expanded(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: ListView(
              padding: EdgeInsets.zero,
              
              children: [
                SizedBox(height: 12),
                // Video Details
                VideoDetails(
                  infoset: manager.mediaInfoSet,
                  isPlaylist: widget.isPlaylist
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
                          // Tags Editor (Not available on Playlists)
                          if (!widget.isPlaylist)
                          VideoTags(),
                          if (!widget.isPlaylist)
                          Divider(),
                          // Related Videos
                          RelatedVideosList(
                            related: manager.mediaInfoSet.relatedVideos,
                            isPlaylist: widget.isPlaylist,
                            onVideoTap: (index) async {
                              manager.mediaInfoSet.autoPlayIndex = index+1;
                              manager.updateBySearchResult(
                                manager.mediaInfoSet.relatedVideos[index]
                              );
                              await manager.updateCurrentManifest(
                                manager.mediaInfoSet.relatedVideos[index].id
                              );
                              if (
                                manager.mediaInfoSet.channelDetails.title != 
                                manager.mediaInfoSet.relatedVideos[index].author
                              ) {
                                manager.updateCurrentChannel(
                                  manager.mediaInfoSet.relatedVideos[index].id
                                );
                              }
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
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ),
    );
  }
}