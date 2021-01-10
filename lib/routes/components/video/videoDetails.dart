import 'package:flutter/material.dart';
import 'package:songtube/internal/models/infoSets/mediaInfoSet.dart';
import 'package:songtube/routes/components/video/shimmer/shimmerChannelLogo.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoDetails extends StatelessWidget {
  final MediaInfoSet infoset;
  VideoDetails({
    @required this.infoset
  });
  @override
  Widget build(BuildContext context) {
    String channelLogo = infoset.channelDetails != null
      ? infoset.channelDetails.logoUrl : null;
    String title = infoset.videoFromSearch.videoTitle;
    String author = infoset.videoFromSearch.videoAuthor;
    String duration = infoset.videoDetails != null
      ? infoset.videoDetails.duration.inMinutes.remainder(60).toString().padLeft(2, '0') + " min "
        + infoset.videoDetails.duration.inSeconds.remainder(60).toString().padLeft(2, '0') + " sec"
      : null;
    String date = infoset.videoDetails != null
      ? "${infoset.videoDetails.uploadDate.year}/" +
        "${infoset.videoDetails.uploadDate.month}/" +
        "${infoset.videoDetails.uploadDate.day}"
      : null;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 12, right: 12, bottom: 12
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: channelLogo != null
                  ? Container(
                      height: 60,
                      width: 60,
                      margin: EdgeInsets.only(right: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: FadeInImage(
                          fadeInDuration: Duration(milliseconds: 400),
                          placeholder: MemoryImage(kTransparentImage),
                          image: channelLogo != null
                            ? NetworkImage(channelLogo)
                            : MemoryImage(kTransparentImage)
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(right: 12),
                      child: const ShimmerChannelLogo()
                    )
              ),
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
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    // Video Author
                    Padding(
                      padding: const EdgeInsets.only(right: 16, bottom: 8),
                      child: Text(
                        author,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontFamily: "Varela",
                          fontSize: 12
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        // Video Duration and Weight
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Text(
                duration ?? "  ",
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                date ?? "  ",
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}