import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/routes/video.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/components/autohideScaffold.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class WatchHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    List<Video> history = prefs.watchHistory;
    return AutoHideScaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text(
          "Watch History",
          style: TextStyle(
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyText1.color
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color),
      ),
      body: history.isNotEmpty ? ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          Video video = history[index];
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
              manager.updateMediaInfoSet(video, history);
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
      ) : Center(
        child: Text(
          "History is Empty!",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16
          ),
        ),
      )
    );
  }
}