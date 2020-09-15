// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class NoDownloads extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShowUpTransition(
      duration: Duration(milliseconds: 400),
      slideSide: SlideFromSlide.BOTTOM,
      forward: true,
      child: Container(
        padding: EdgeInsets.all(8),
        height: 240,
        width: MediaQuery.of(context).size.width*0.6,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(EvaIcons.cloudDownloadOutline, size: 100, color: Theme.of(context).accentColor),
              SizedBox(height: 8),
              Text(
                "No downloads yet",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Varela'
                ),
              ),
              SizedBox(height: 4),
              Text("All your ongoing downloads will be shown here", textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}