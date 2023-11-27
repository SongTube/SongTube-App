import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pip/models/pip_ratio.dart';
import 'package:flutter_pip/platform_channel/channel.dart';
import 'package:image_fade/image_fade.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:newpipeextractor_dart/extractors/comments.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/models/videoInfo.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:songtube/internal/models/content_wrapper.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/download_provider.dart';
import 'package:songtube/screens/channel.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/components/custom_inkwell.dart';
import 'package:songtube/ui/components/shimmer_container.dart';
import 'package:songtube/ui/components/subscribe_text.dart';
import 'package:songtube/ui/components/text_icon_button.dart';
import 'package:songtube/ui/menus/download_content_menu.dart';
import 'package:songtube/ui/players/video_player/comments.dart';
import 'package:songtube/ui/players/video_player/description.dart';
import 'package:songtube/ui/players/video_player/suggestions.dart';
import 'package:songtube/ui/sheets/add_to_stream_playlist.dart';
import 'package:songtube/ui/sheets/snack_bar.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/ui_utils.dart';

class VideoPlayerContent extends StatefulWidget {
  const VideoPlayerContent({
    required this.content,
    required this.videoDetails,
    super.key});
  final ContentWrapper content;
  final YoutubeVideo? videoDetails;

  @override
  State<VideoPlayerContent> createState() => _VideoPlayerContentState();
}

class _VideoPlayerContentState extends State<VideoPlayerContent> with TickerProviderStateMixin {

  // Our current list of comments
  List<YoutubeComment> comments = [];

  // Our current list of video or playlist suggestions
  List<dynamic> relatedStreams = [];

  // Indicate if this videos has comments available
  bool commentsAvailable = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final url = widget.videoDetails?.videoInfo.url;
      if (url != null) {
        loadComments(url);
        loadSuggestions(url);
      }
    });
    super.initState();
  }

  @override 
  void didUpdateWidget(covariant VideoPlayerContent oldWidget) {
    if (oldWidget.videoDetails?.videoInfo.url != widget.videoDetails?.videoInfo.url) {
      if (widget.videoDetails?.videoInfo.url != null) {
        loadComments(widget.videoDetails!.videoInfo.url!);
        loadSuggestions(widget.videoDetails!.videoInfo.url!);
      } else {
        setState(() {
          comments.clear();
          relatedStreams.clear();
        });
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  // Load video comments
  void loadComments(String url) {
    setState(() {
      comments.clear();
    });
    CommentsExtractor.getComments(url).then((value) {
      setState(() {
        comments = value;
        if (value.isEmpty) {
          commentsAvailable = false;
        } else {
          commentsAvailable = true;
        }
      });
    });
  }

  // Load video suggestions
  void loadSuggestions(String url) {
    setState(() {
      relatedStreams.clear();
    });
    VideoExtractor.getRelatedStreams(url).then((value) {
      relatedStreams = value;
      final contentProvider = Provider.of<ContentProvider>(context, listen: false);
      // Remove first item if it's the one currently playing
      if (contentProvider.playingContent!.infoItem == relatedStreams.first) {
        relatedStreams.removeAt(0);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child:  _body()
    );
  }

  Widget _body() {
    ContentProvider contentProvider = Provider.of(context);
    if (contentProvider.showComments && widget.content.videoDetails != null) {
      return VideoPlayerCommentsExpanded(
        comments: comments..sort((a, b) => b.likeCount!.compareTo(a.likeCount!)),
        onBack: () => contentProvider.showComments = false,
        onSeek: (position) {
          widget.content.videoPlayerController.videoPlayerController?.seekTo(position);
        });
    } else if (contentProvider.showDescription && widget.content.videoDetails != null) {
      return VideoPlayerDescription(
        info: widget.content.videoDetails!.videoInfo,
        segments: widget.content.videoDetails?.segments ?? [],
        onBack: () => contentProvider.showDescription = false,
        onSegmentTap: (position) {
          widget.content.videoPlayerController.videoPlayerController?.seekTo(Duration(seconds: position));
        },
        onSeek: (position) {
          widget.content.videoPlayerController.videoPlayerController?.seekTo(position);
        });
    } else {
      return _playerBody();
    }
  }

  Widget _playerBody() {
    ContentProvider contentProvider = Provider.of(context);
    return CustomScrollView(
      
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        // Video Title and Show More Button
        SliverToBoxAdapter(child: _playerTitle()),
        const SliverToBoxAdapter(child: SizedBox(height: 6)),
        // Action Buttons (Like, dislike, download, etc...)
        SliverToBoxAdapter(child: _playerActions()),
        SliverToBoxAdapter(
          child: GestureDetector(
            onTap: () {
              contentProvider.showComments = true;
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: VideoPlayerCommentsCollapsed(
                comments: comments..sort((a, b) => b.likeCount!.compareTo(a.likeCount!)),
                commentsAvailable: commentsAvailable,
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        // Video Suggestions
        VideoPlayerSuggestions(suggestions: relatedStreams),
        SliverToBoxAdapter(child: SizedBox(height: widget.content.infoItem is PlaylistInfoItem ? kToolbarHeight+32 : 0))
      ],
    );
  }

  Widget _playerTitle() {
    ContentProvider contentProvider = Provider.of(context);
    StreamInfoItem? infoItem = widget.content.infoItem is StreamInfoItem ? widget.content.infoItem : null;
    VideoInfo? videoInfo = widget.content.videoDetails?.videoInfo;
    final views = (infoItem?.viewCount != null || videoInfo != null) ? "${NumberFormat.compact().format(infoItem?.viewCount ?? videoInfo?.viewCount)} ${Languages.of(context)!.labelViews}" : '-1';
    final date = infoItem?.date ?? widget.content.videoDetails?.videoInfo.uploadDate ?? "";
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(infoItem?.name ?? videoInfo?.name ?? '', style: textStyle(context), maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 2),
                        Text((views.contains('-1') ? "" : ("$views  •  ${date.isNotEmpty ? timeago.format(DateTime.parse(date), locale: 'en') : ''}")), style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    )
                  ),
                  Semantics(
                    label: Languages.of(context)!.labelMore,
                    child: IconButton(
                      onPressed: () {
                        contentProvider.showDescription = true;
                      },
                      icon: const AppAnimatedIcon(Icons.expand_more)
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Channel Details
              FutureBuilder<YoutubeChannel>(
                future: videoInfo?.getChannel().getChannel,
                builder: (context, snapshot) {
                  return CustomInkWell(
                    onTap: () {
                      UiUtils.pushRouteAsync(navigatorKey.currentState!.context, ChannelPage(infoItem: videoInfo!.getChannel(), channel: snapshot.data));
                    },
                    child: Row(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: videoInfo != null
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 6,
                                      offset: const Offset(0,0),
                                      color: Theme.of(context).shadowColor.withOpacity(0.1)
                                    )
                                  ],
                                  border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.08), width: 1.5),
                                ),
                                height: 40,
                                width: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: ImageFade(
                                    fadeDuration: const Duration(milliseconds: 300),
                                    placeholder: ShimmerContainer(height: 40, width: 40, borderRadius: BorderRadius.circular(100)),
                                    image: NetworkImage(videoInfo.uploaderAvatarUrl!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : ShimmerContainer(height: 40, width: 40, borderRadius: BorderRadius.circular(100)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      infoItem?.uploaderName ?? videoInfo?.uploaderName ?? '',
                                      style: subtitleTextStyle(context).copyWith(fontWeight: FontWeight.normal),
                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      snapshot.data?.subscriberCount != null
                                        ? '${NumberFormat().format(snapshot.data?.subscriberCount)} Subs'
                                        : '',
                                      style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12),
                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              if (videoInfo != null)
                              ChannelSubscribeText(channelName: videoInfo.uploaderName??'', channel: ChannelInfoItem(
                                videoInfo.uploaderUrl??'', videoInfo.uploaderName??'', '', '', null, -1
                              )),
                              const SizedBox(width: 4),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _playerActions() {
    DownloadProvider downloadProvider = Provider.of(context);
    VideoInfo? videoInfo = widget.content.videoDetails?.videoInfo;
    ContentProvider contentProvider = Provider.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 12),
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 12, right: 12),
        children: [
          // Like Button
          Builder(
            builder: (context) {
              final hasVideo = contentProvider.favoriteVideos.any((element) => element.id == videoInfo?.id);
              return TextIconSlimButton(
                icon: const AppAnimatedIcon(LineIcons.thumbsUp, size: 18),
                text: hasVideo ? Languages.of(context)!.labelLiked : Languages.of(context)!.labelLike,
                applyColor: hasVideo,
                onTap: () {
                  showSnackbar(customSnackBar: CustomSnackBar(icon: hasVideo ? LineIcons.trash : LineIcons.star, title: hasVideo ? Languages.of(context)!.labelVideoRemovedFromFavorites : Languages.of(context)!.labelVideoAddedToFavorites));
                  if (hasVideo) {
                    contentProvider.removeVideoFromFavorites(videoInfo!.id!);
                  } else {
                    contentProvider.saveVideoToFavorites(widget.content.videoDetails!.toStreamInfoItem());
                  }
                },
              );
            }
          ),
          const SizedBox(width: 12),
          // Share Button
          TextIconSlimButton(
            icon: const AppAnimatedIcon(LineIcons.share, size: 18),
            text: Languages.of(context)!.labelShare,
            onTap: () {
              Share.share(videoInfo!.url!);
            },
          ),
          const SizedBox(width: 12),
          // Add to Playlist Button
          TextIconSlimButton(
            icon: const AppAnimatedIcon(Ionicons.add_outline, size: 18),
            text: Languages.of(context)!.labelPlaylist,
            onTap: () {
              UiUtils.showModal(
                context: internalNavigatorKey.currentContext!,
                modal: AddToStreamPlaylist(stream: widget.content.videoDetails!.toStreamInfoItem()),
              );
            },
          ),
          // Popup Player Button
          FutureBuilder<bool?>(
            future: FlutterPip.isPictureInPictureSupported(),
            builder: (context, snapshot) {
              if (snapshot.data ?? false) {
                return Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TextIconSlimButton(
                    icon: const AppAnimatedIcon(LineIcons.video, size: 18),
                    text: Languages.of(context)!.labelPopupMode,
                    onTap: () {
                      final size = Provider.of<ContentProvider>(context, listen: false).playingContent?.videoPlayerController.videoPlayerController?.value.size;
                      FlutterPip.enterPictureInPictureMode(pipRatio: size != null ? PipRatio(width: size.width.round(), height: size.height.round()) : null);
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            }
          ),
          const SizedBox(width: 12),
          // Download Button
          Builder(
            builder: (context) {
              final downloading = downloadProvider.queue.any((element) => element.downloadInfo.url == videoInfo?.url);
              final downloadItem = downloadProvider.queue.firstWhereOrNull((element) => element.downloadInfo.url == videoInfo?.url);
              final downloaded = downloadProvider.downloadedSongs.any((element) => element.videoId == videoInfo?.url);
              return StreamBuilder<double?>(
                stream: downloadItem?.downloadProgress,
                builder: (context, snapshot) {
                  final progress = snapshot.data;
                  final currentProgress = progress != null ? (progress*100).round().toString() : '';
                  return TextIconSlimButton(
                    icon: const AppAnimatedIcon(LineIcons.alternateCloudDownload, size: 18),
                    text: downloading ? '${Languages.of(context)!.labelDownloading}... ${currentProgress.isNotEmpty ? '$currentProgress%' : ''}' : downloaded ? Languages.of(context)!.labelDownloaded : Languages.of(context)!.labelDownload,
                    applyColor: downloaded,
                    onTap: () {
                      UiUtils.showModal(
                        context: internalNavigatorKey.currentContext!,
                        modal: DownloadContentMenu(content: widget.content));
                    },
                  );
                }
              );
            }
          ),
        ],
      ),
    );
  }

}