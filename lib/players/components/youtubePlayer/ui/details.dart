import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:newpipeextractor_dart/utils/url.dart';
import 'package:provider/provider.dart';
import 'package:songtube/pages/channel.dart';
import 'package:songtube/pages/components/video/shimmer/shimmerChannelLogo.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoDetails extends StatelessWidget {
  final dynamic infoItem;
  final Function onMoreDetails;
  VideoDetails({
    @required this.infoItem,
    this.onMoreDetails
  });
  @override
  Widget build(BuildContext context) {
    String title = infoItem?.name ?? "";
    String views = "${NumberFormat.compact().format(infoItem?.viewCount)} views" ?? "";
    String date = infoItem?.uploadDate ?? "";
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 14, right: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video Title
                    Padding(
                      padding: const EdgeInsets.only(right: 16, bottom: 4),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Product Sans',
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Video Author
                    Padding(
                      padding: const EdgeInsets.only(right: 16, bottom: 8),
                      child: Text(
                        views + " • " + date,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color
                            .withOpacity(0.8),
                          fontFamily: "Product Sans",
                          fontSize: 12,
                          letterSpacing: 0.2
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.expand_more_rounded,
                  color: Theme.of(context).iconTheme.color),
                onPressed: onMoreDetails,
              )
            ],
          ),
        ),
      ],
    );
  }

  

}