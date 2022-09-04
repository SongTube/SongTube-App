import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/models/channel.dart';
import 'package:newpipeextractor_dart/models/infoItems/channel.dart';
import 'package:newpipeextractor_dart/models/infoItems/playlist.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:songtube/internal/avatarHandler.dart';
import 'package:songtube/pages/channel.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:songtube/ui/components/shimmerContainer.dart';
import 'package:songtube/ui/layout/components/popupMenu.dart';
import 'package:transparent_image/transparent_image.dart';

class StreamsLargeThumbnailView extends StatelessWidget {
  final List<dynamic> infoItems;
  final bool shrinkWrap;
  final Function(dynamic) onDelete;
  final bool allowSaveToFavorites;
  final bool allowSaveToWatchLater;
  final Function onReachingListEnd;
  final scaffoldKey;
  StreamsLargeThumbnailView({
    @required this.infoItems,
    this.shrinkWrap = false,
    this.onDelete,
    this.allowSaveToFavorites = true,
    this.allowSaveToWatchLater = true,
    this.onReachingListEnd,
    this.scaffoldKey,
    Key key,
  }) : super (key: key);
  @override
  Widget build(BuildContext context) {
    if (infoItems.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          double maxScroll = notification.metrics.maxScrollExtent;
          double currentScroll = notification.metrics.pixels;
          double delta = 200.0;
          if ( maxScroll - currentScroll <= delta)
            onReachingListEnd();
          return false;
        },
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: kToolbarHeight*2),
          itemCount: infoItems.length,
          itemBuilder: (context, index) {
            dynamic infoItem = infoItems[index];
            return FadeInTransition(
              duration: Duration(milliseconds: 300),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 16, top: index == 0 ? 12 : 0,
                  left: 12, right: 12
                ),
                child: Consumer<VideoPageProvider>(
                  builder: (context, provider, child) {
                    return GestureDetector(
                      onTap: () {
                        if (infoItem is StreamInfoItem || infoItem is PlaylistInfoItem) {
                          provider.infoItem = infoItem;
                        } else {
                          Navigator.push(context,
                            BlurPageRoute(
                              blurStrength: Provider.of<PreferencesProvider>
                                (context, listen: false).enableBlurUI ? 20 : 0,
                              builder: (_) => 
                              YoutubeChannelPage(
                                url: infoItem.url,
                                name: infoItem.name,
                          )));
                        }
                      },
                      child: child,
                    );
                  },
                  child: infoItem is ChannelInfoItem
                    ? _channelWidget(context, infoItem)
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: _thumbnailWidget(infoItem)
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: _infoItemDetails(context, infoItem),
                          )
                        ],
                      )
                ),
              ),
            );
          }
        ),
      );
    } else {
      return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              top: index == 0 ? 12 : 0
            ),
            child: _shimmerTile(context),
          );
        },
      );
    }
  }

  Widget _channelWidget(BuildContext context, infoItem) {
    ChannelInfoItem channel = infoItem;
    return Row(
      children: [
        FutureBuilder(
          future: AvatarHandler.getAvatarUrl(channel.name, channel.url),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: 300),
                  placeholder: MemoryImage(kTransparentImage),
                  image: FileImage(File(snapshot.data)),
                  height: 80,
                  width: 80,
                ),
              );
            } else {
              return ShimmerContainer(
                height: 80,
                width: 80,
                borderRadius: BorderRadius.circular(100),
              );
            }
          },
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                channel.name,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontSize: 18,
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2
                ),
              ),
              Text(
                "${NumberFormat().format(channel.subscriberCount)} Subs • ${channel.streamCount} videos",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontSize: 12,
                  fontFamily: 'Product Sans',
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _thumbnailWidget(infoItem) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio: 16/9,
          child: Transform.scale(
            scale: 1.01,
            child: infoItem is StreamInfoItem
              ? FadeInImage(
                  fadeInDuration: Duration(milliseconds: 200),
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(infoItem.thumbnails.maxresdefault),
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) =>
                    Image.network(infoItem.thumbnails.hqdefault, fit: BoxFit.cover),
                )
              : FadeInImage(
                  fadeInDuration: Duration(milliseconds: 200),
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(infoItem.thumbnailUrl),
                  fit: BoxFit.cover,
                )
          ),
        ),
        if (infoItem is StreamInfoItem)
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.only(right: 10, bottom: 10),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(3)
            ),
            child: Text(
              "${Duration(seconds: infoItem.duration).inMinutes}:" +
              "${Duration(seconds: infoItem.duration).inSeconds.remainder(60).toString().padRight(2, "0")}",
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 10
              ),
            )
          ),
        ),
        if (infoItem is PlaylistInfoItem)
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
            )
          ),
          height: 25,
          child: Center(
            child: Icon(EvaIcons.musicOutline,
              color: Colors.white, size: 20),
          ),
        )
      ],
    );
  }

  Widget _infoItemDetails(BuildContext context, infoItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoItem is StreamInfoItem
          ? FutureBuilder(
              future: _getChannelLogoUrl(infoItem.uploaderUrl),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                        BlurPageRoute(
                          blurStrength: Provider.of<PreferencesProvider>
                            (context, listen: false).enableBlurUI ? 20 : 0,
                          builder: (_) => 
                          YoutubeChannelPage(
                            url: infoItem.uploaderUrl,
                            name: infoItem.uploaderName,
                            lowResAvatar: snapshot.data,
                            heroTag: infoItem.uploaderUrl + infoItem.id,
                      )));
                    },
                    child: Hero(
                      tag: infoItem.uploaderUrl + infoItem.id,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: FadeInImage(
                          fadeInDuration: Duration(milliseconds: 300),
                          placeholder: MemoryImage(kTransparentImage),
                          image: NetworkImage(snapshot.data),
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                  );
                } else {
                  return ShimmerContainer(
                    height: 50,
                    width: 50,
                    borderRadius: BorderRadius.circular(100),
                  );
                }
              },
            )
          : Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(100)
              ),
              child: Icon(
                Icons.playlist_play_outlined,
                color: Theme.of(context).iconTheme.color,
                size: 32,
              ),
            ),
        SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${infoItem.name}",
                  maxLines: 2,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Product Sans',
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "${infoItem.uploaderName}" +
                  (infoItem is StreamInfoItem
                    ? "${infoItem.viewCount != -1 ? " • " + NumberFormat.compact().format(infoItem.viewCount) + " views" : ""}"
                      " ${infoItem.uploadDate == null ? "" : " • " + infoItem.uploadDate}"
                    : ""),
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).textTheme.bodyText1.color
                      .withOpacity(0.8),
                    fontFamily: 'Product Sans'
                  ),
                )
              ],
            ),
          ),
        ),
        StreamsPopupMenu(
          infoItem: infoItem,
          onDelete: onDelete != null
            ? (item) => onDelete(item)
            : null,
          scaffoldKey: scaffoldKey,
        )
      ],
    );
  }

  Future<String> _getChannelLogoUrl(url) async {
    YoutubeChannel channel = await ChannelExtractor.channelInfo(url);
    return channel.avatarUrl;
  }

  Widget _shimmerTile(context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12, right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Shimmer.fromColors(
                baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                highlightColor: Theme.of(context).cardColor,
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 4),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                  highlightColor: Theme.of(context).cardColor,
                  child: Container(
                    height: 60,
                    width: 60,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).scaffoldBackgroundColor
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                        highlightColor: Theme.of(context).cardColor,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).scaffoldBackgroundColor
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                        highlightColor: Theme.of(context).cardColor,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).scaffoldBackgroundColor
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}