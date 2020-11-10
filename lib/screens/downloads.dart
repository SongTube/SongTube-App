// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/screens/downloadScreen/tabs/cancelledTab.dart';

// Internal
import 'package:songtube/screens/downloadScreen/tabs/downloadsTab.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:songtube/screens/downloadScreen/tabs/queueTab.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class DownloadTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 12,
          shadowColor: Colors.black.withOpacity(0.15),
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
                      Languages.of(context).labelDownloads,
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
          bottom: TabBar(
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Theme.of(context).textTheme.bodyText1.color,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Theme.of(context).accentColor,
            tabs: [
              Tab(child: Text(
                Languages.of(context).labelQueued,
                style: TextStyle(
                  fontFamily: 'YTSans',
                ),
              )),
              Tab(child: Text(
                Languages.of(context).labelCompleted,
                style: TextStyle(
                  fontFamily: 'YTSans',
                ),
              )),
              Tab(child: Text(
                Languages.of(context).labelCancelled,
                style: TextStyle(
                  fontFamily: 'YTSans',
                ),
              ))
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DownloadsQueueTab(),
            DownloadsTab(),
            DownloadsCancelledTab()
          ],
        ),
      ),
    );
  }
}