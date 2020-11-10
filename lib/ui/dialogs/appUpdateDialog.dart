import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/models/updateDetails.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateDialog extends StatelessWidget {
  final UpdateDetails details;
  AppUpdateDialog(this.details);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      title: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 90,
                width: 90,
                child: AvatarGlow(
                  repeat: true,
                  endRadius: 45,
                  showTwoGlows: false,
                  glowColor: Theme.of(context).accentColor,
                  repeatPauseDuration: Duration(milliseconds: 50),
                  child: Image.asset(
                    'assets/images/ic_launcher.png',
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Text(
                "SongTube",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontFamily: 'YTSans',
                  fontSize: 24
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                "New version available",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color
                    .withOpacity(0.8),
                  fontSize: 16
                ),
              ),
              Spacer(),
              Text(
                "${details.version}",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 16
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "What's new:",
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 16
              ),
            ),
          )
        ],
      ),
      content: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MarkdownBody(data: details.updateDetails)
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Later",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color
                .withOpacity(0.8),
              fontFamily: 'YTSans',
              fontSize: 16
            ),
          )
        ),
        InkWell(
          onTap: () {
            launch("https://t.me/songtubechannel");
          },
          child: Ink(
            height: 50,
            width: 100,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'YTSans',
                  fontSize: 16
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}