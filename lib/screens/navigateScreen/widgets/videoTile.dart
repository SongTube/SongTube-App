// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:intl/intl.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoTile extends StatelessWidget {
  final SearchVideo video;
  VideoTile({
    @required this.video
  });
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return InkWell(
      onTap: () => manager
        .getVideoDetails("https://www.youtube.com/watch?v=${video.videoId}"),
      child: Ink(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 8),
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: 200),
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage("http://img.youtube.com/vi/${video.videoId}/mqdefault.jpg"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${video.videoTitle}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500
                            ),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${video.videoAuthor} • "
                            "${NumberFormat.compact().format(video.videoViewCount)} views",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12
                            ),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Icon(EvaIcons.downloadOutline, size: 20, color: Theme.of(context).iconTheme.color),
                  ),
                ],
              ),
            ),
            Divider(height: 1, thickness: 2)
          ],
        ),
      ),
    );
  }
}