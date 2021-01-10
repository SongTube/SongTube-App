import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class RelatedVideosList extends StatelessWidget {
  final List<Video> related;
  final bool shrinkWrap;
  final Function(int) onVideoTap;
  RelatedVideosList({
    this.related,
    this.onVideoTap,
    this.shrinkWrap = true,
  });
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    List<Video> relatedVideos = related == null
      ? manager.mediaInfoSet.relatedVideos : related;
    return Column(
      children: [
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.only(bottom: 12),
          height: 20,
          child: Row(
            children: [
              SizedBox(width: 16),
              Text(
                Languages.of(context).labelRelated,
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
                child: manager.mediaInfoSet.relatedVideos.isEmpty
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
              CircularCheckBox(
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
          child: manager.mediaInfoSet.relatedVideos.isNotEmpty
            ? ListView.builder(
                shrinkWrap: shrinkWrap,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemCount: relatedVideos.length,
                itemBuilder: (context, index) {
                  Video video = relatedVideos[index];
                  return GestureDetector(
                    onTap: () {
                      if (onVideoTap == null) {
                        manager.updateMediaInfoSet(
                          manager.mediaInfoSet.relatedVideos[index],
                          manager.mediaInfoSet.relatedVideos
                        );
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
                            child: AspectRatio(
                              aspectRatio: 16/9,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage(
                                      fadeInDuration: Duration(milliseconds: 300),
                                      placeholder: MemoryImage(kTransparentImage),
                                      image: NetworkImage(
                                        "https://img.youtube.com/vi/${video.id.value}/mqdefault.jpg"
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      margin: EdgeInsets.all(6),
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Text(
                                        "${video.duration.inMinutes}:" +
                                        "${video.duration.inSeconds.remainder(60).toString().padRight(2, "0")}" +
                                        " min",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
                                    video.title,
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
                                    video.author + " • " +
                                    "${NumberFormat.compact().format(video.engagement.viewCount)}" +
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