import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/ui/components/autohideScaffold.dart';
import 'package:transparent_image/transparent_image.dart';

class WatchHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    List<StreamInfoItem> history = prefs.watchHistory;
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
          StreamInfoItem video = history[index];
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
              pageProvider.infoItem = video;
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
                            child: AspectRatio(
                              aspectRatio: 16/9,
                              child: FadeInImage(
                                fadeInDuration: Duration(milliseconds: 300),
                                placeholder: MemoryImage(kTransparentImage),
                                image: NetworkImage(
                                  video.thumbnails.hqdefault
                                ),
                                fit: BoxFit.cover,
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
                                "${Duration(seconds: video.duration).inMinutes}:" +
                                "${Duration(seconds: video.duration).inSeconds.remainder(60).toString().padRight(2, "0")}" +
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