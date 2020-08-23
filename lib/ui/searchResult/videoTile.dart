import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

class VideoTile extends StatelessWidget {
  final yt.SearchVideo video;
  final yt.YoutubeExplode client;
  final Function onSelect;
  VideoTile({
    @required this.video,
    @required this.client,
    @required this.onSelect
  });
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return InkWell(
      onTap: () => manager
        .getVideoDetails("https://www.youtube.com/watch?v=${video.videoId}"),
      child: Ink(
        height: 310,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              offset: Offset(0, 3), //(x,y)
              blurRadius: 6.0,
              spreadRadius: 0.01 
            )
          ]
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 230,
              width: double.infinity,
              child: FadeInImage(
                fadeInDuration: Duration(milliseconds: 200),
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage("http://img.youtube.com/vi/${video.videoId}/hqdefault.jpg"),
                fit: BoxFit.fitWidth,
              )
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: FutureBuilder(
                        future: client.channels.getByVideo(video.videoId),
                        builder: (context, AsyncSnapshot<yt.Channel> result) {
                          if (result.hasData) {
                            return Image.network(result.data.logoUrl);
                          } else {
                            return Image.asset('assets/images/grey.jpg');
                          }
                        },
                      )
                    )
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                    color: Theme.of(context).cardColor,
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