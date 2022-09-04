import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:songtube/ui/components/shimmerContainer.dart';
import 'package:songtube/ui/layout/components/popupMenu.dart';
import 'package:transparent_image/transparent_image.dart';

class StreamsListTileView extends StatelessWidget {
  final List<StreamInfoItem> streams;
  final Function(StreamInfoItem, int) onTap;
  final bool shrinkWrap;
  final bool removePhysics;
  final bool topPadding;
  final Function(dynamic) onDelete;
  final scaffoldKey;
  StreamsListTileView({
    @required this.streams,
    @required this.onTap,
    this.shrinkWrap = false,
    this.removePhysics = false,
    this.topPadding = true,
    this.onDelete,
    this.scaffoldKey
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: streams.isNotEmpty
        ? ListView.builder(
            physics: removePhysics
              ? NeverScrollableScrollPhysics()
              : AlwaysScrollableScrollPhysics(),
            shrinkWrap: shrinkWrap,
            padding: EdgeInsets.zero,
            itemCount: streams.length,
            itemBuilder: (context, index) {
              StreamInfoItem video = streams[index];
              return FadeInTransition(
                duration: Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () => onTap(video, index),
                  child: Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(
                      left: 12, right: 12,
                      top: topPadding ? index == 0 ? 12 : 0 : 0,
                      bottom: 12
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 80,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: AspectRatio(
                                  aspectRatio: 16/9,
                                  child: FadeInImage(
                                    fadeInDuration: Duration(milliseconds: 300),
                                    placeholder: MemoryImage(kTransparentImage),
                                    image: NetworkImage(video.thumbnails.hqdefault),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin: EdgeInsets.all(6),
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(3)
                                  ),
                                  child: Text(
                                    "${Duration(seconds: video.duration).inMinutes}:" +
                                    "${Duration(seconds: video.duration).inSeconds.remainder(60).toString().padRight(2, "0")}",
                                    style: TextStyle(
                                      fontFamily: 'Product Sans',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 8
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  top: 4,
                                  bottom: 4
                                ),
                                child: Text(
                                  video.name,
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.bodyText1.color,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Product Sans',
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  video.uploaderName + " • " +
                                  "${NumberFormat.compact().format(video.viewCount)}" +
                                  " Views",
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.bodyText1.color
                                      .withOpacity(0.8),
                                    fontFamily: "Product Sans",
                                    fontSize: 12,
                                    letterSpacing: 0.2
                                  ),
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        StreamsPopupMenu(
                          infoItem: video,
                          onDelete: onDelete != null
                            ? (item) => onDelete(item)
                            : null,
                          scaffoldKey: scaffoldKey,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : ListView.builder(
            shrinkWrap: shrinkWrap,
            padding: EdgeInsets.zero,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: 12, right: 12,
                  top: index == 0 ? 12 : 0,
                  bottom: 12
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerContainer(
                      height: 80,
                      width: 150,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerContainer(
                            height: 15,
                            width: double.infinity,
                            borderRadius: BorderRadius.circular(10),
                            margin: EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 4,
                              bottom: 8
                            ),
                          ),
                          ShimmerContainer(
                            height: 15,
                            width: 150,
                            borderRadius: BorderRadius.circular(10),
                            margin: EdgeInsets.only(left: 8),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )
    );
  }
}