import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class RelatedVideosList extends StatelessWidget {
  final List<Video> relatedVideos;
  final bool shrinkWrap;
  final Function(int) onVideoTap;
  RelatedVideosList({
    @required this.relatedVideos,
    @required this.onVideoTap,
    this.shrinkWrap = true,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: relatedVideos.length,
      itemBuilder: (context, index) {
        Video video = relatedVideos[index];
        return GestureDetector(
          onTap: () => onVideoTap(index),
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
    );
  }
}