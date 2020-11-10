import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share/share.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/screens/homeScreen/components/roundTile.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPageEngagementTiles extends StatelessWidget {
  final int likeCount;
  final int dislikeCount;
  final int viewCount;
  final String channelUrl;
  final String videoUrl;
  VideoPageEngagementTiles({
    @required this.likeCount,
    @required this.dislikeCount,
    @required this.viewCount,
    @required this.channelUrl,
    @required this.videoUrl
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Likes Counter
        RoundTile(
          icon: Icon(MdiIcons.thumbUp, color: Theme.of(context).iconTheme.color),
          text: Text(
            NumberFormat.compact().format(likeCount),
            style: TextStyle(
              fontFamily: "Varela",
              fontSize: 10
            ),
            ),
        ),
        // Dislikes Counter
        RoundTile(
          icon: Icon(MdiIcons.thumbDown, color: Theme.of(context).iconTheme.color),
          text: Text(
            NumberFormat.compact().format(dislikeCount),
            style: TextStyle(
              fontFamily: "Varela",
              fontSize: 10
            ),
            ),
        ),
        //
        RoundTile(
          icon: Icon(EvaIcons.eye, color: Theme.of(context).iconTheme.color),
          text: Text(
            NumberFormat.compact().format(viewCount),
            style: TextStyle(
              fontFamily: "Varela",
              fontSize: 10
            ),
          ),
        ),
        // Channel Button
        RoundTile(
          icon: Icon(MdiIcons.youtube, color: Theme.of(context).iconTheme.color),
          text: Text(
            Languages.of(context).labelChannel,
            style: TextStyle(
              fontFamily: "Varela",
              fontSize: 10
            ),
          ),
          onPressed: () {
            if (channelUrl != null)
              launch(channelUrl);
          },
        ),
        // Share button
        RoundTile(
          icon: Icon(EvaIcons.share, color: Theme.of(context).iconTheme.color),
          text: Text(
            Languages.of(context).labelShare,
            style: TextStyle(
              fontFamily: "Varela",
              fontSize: 10
            ),
          ),
          onPressed: () {
            Share.share(videoUrl);
          },
        ),
      ],
    );
  }
}