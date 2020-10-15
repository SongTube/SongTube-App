// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/screens/downloadScreen/downloads.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class DownloadTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: ShowUpTransition(
          forward: true,
          duration: Duration(milliseconds: 400),
          slideSide: SlideFromSlide.TOP,
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Icon(
                      EvaIcons.cloudDownloadOutline,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Text(
                    "Downloads",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "YTSans",
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: DownloadingPage(),
        )
      ),
    );
  }
}