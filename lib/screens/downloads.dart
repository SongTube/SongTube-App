// Flutter
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

// UI
import 'package:songtube/screens/downloadsPages/downloads.dart';
import 'package:songtube/ui/animations/showUp.dart';

class DownloadTab extends StatefulWidget {
  _DownloadTabState createState() => _DownloadTabState();
}

class _DownloadTabState extends State<DownloadTab> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ShowUpTransition(
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
                        fontFamily: "YTSans"
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: Center(child: DownloadingPage())),
        ],
      ),
    );
  }
}