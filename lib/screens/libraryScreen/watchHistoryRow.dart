import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/provider/videoPageProvider.dart';

class WatchHistoryRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    List<StreamInfoItem> watchHistory = prefs.watchHistory;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, top: 16, bottom: 12),
          child: Text(
            "Recent",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Product Sans',
            )
          ),
        ),
        Container(
          height: 140,
          child: watchHistory.isNotEmpty
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: watchHistory.length < 10
                  ? watchHistory.length : 10,
                itemBuilder: (context, index) {
                  StreamInfoItem video = watchHistory[index];
                  return GestureDetector(
                    onTap: () {
                      pageProvider.infoItem = video;
                    },
                    child: Container(
                      width: 160,
                      margin: EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 16/9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ImageFade(
                                  fit: BoxFit.cover,
                                  fadeDuration: Duration(milliseconds: 200),
                                  image: NetworkImage(video.thumbnails.hqdefault),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 40,
                            padding: EdgeInsets.only(left: 4, right: 4),
                            child: Text(
                              "${video.name}",
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Product Sans',
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 12, right: 12),
                    child: AspectRatio(
                      aspectRatio: 16/9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Shimmer.fromColors(
                          baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                          highlightColor: Theme.of(context).cardColor,
                          child: Container(
                            color: Theme.of(context).scaffoldBackgroundColor
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
        )
      ],
    );
  }
}