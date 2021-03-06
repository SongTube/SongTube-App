import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:transparent_image/transparent_image.dart';

class RelatedVideosList extends StatelessWidget {
  final List<StreamInfoItem> related;
  final bool shrinkWrap;
  final Function(int) onVideoTap;
  final bool isPlaylist;
  final bool showAutoPlay;
  RelatedVideosList({
    this.related,
    this.onVideoTap,
    this.shrinkWrap = true,
    this.isPlaylist = false,
    this.showAutoPlay = true,
  });
  @override
  Widget build(BuildContext context) {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return Column(
      children: [
        SizedBox(height: 8),
        if (showAutoPlay)
        Container(
          margin: EdgeInsets.only(bottom: 12),
          height: 20,
          child: Row(
            children: [
              SizedBox(width: 16),
              Text(
                !isPlaylist
                  ? Languages.of(context).labelRelated
                  : Languages.of(context).labelPlaylist,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontFamily: 'YTSans'
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(width: 8),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: related.isEmpty
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      )
                    )
                  : Container()
              ),
              Spacer(),
              Text(
                Languages.of(context).labelAutoPlay,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontFamily: 'YTSans'
                ),
                textAlign: TextAlign.left,
              ),
              Switch(
                activeColor: Theme.of(context).accentColor,
                value: prefs.youtubeAutoPlay,
                onChanged: (bool value) {
                  prefs.youtubeAutoPlay = value;
                }
              ),
              SizedBox(width: 4)
            ],
          ),
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: related.isNotEmpty
            ? ListView.builder(
                shrinkWrap: shrinkWrap,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemCount: related.length,
                itemBuilder: (context, index) {
                  StreamInfoItem video = related[index];
                  return GestureDetector(
                    onTap: () {
                      if (onVideoTap == null) {
                        pageProvider.infoItem = video;
                      } else {
                        onVideoTap(index);
                      }
                    },
                    child: Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(12),
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
                                    child: Transform.scale(
                                      scale: 1.01,
                                      child: FadeInImage(
                                        fadeInDuration: Duration(milliseconds: 300),
                                        placeholder: MemoryImage(kTransparentImage),
                                        image: NetworkImage(video.thumbnails.hqdefault),
                                        fit: BoxFit.fitWidth,
                                      ),
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
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
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
                                      fontSize: 11,
                                      color: Theme.of(context).textTheme
                                        .bodyText1.color.withOpacity(0.8)
                                    ),
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
          : Container(),
        ),
      ],
    );
  }
}
