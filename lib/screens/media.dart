// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/screens/mediaScreen/tabs/downloadsTab.dart';
import 'package:songtube/screens/mediaScreen/tabs/musicTab.dart';
import 'package:songtube/screens/mediaScreen/tabs/videosTab.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class MediaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
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
                        EvaIcons.musicOutline,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Text(
                      "Media",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "YTSans",
                        color: Theme.of(context).textTheme.bodyText1.color
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        EvaIcons.searchOutline,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {

                      },
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
                "Downloads",
                style: TextStyle(
                  fontFamily: 'YTSans',
                ),
              )),
              Tab(child: Text(
                "Music",
                style: TextStyle(
                  fontFamily: 'YTSans',
                ),
              )),
              Tab(child: Text(
                "Videos",
                style: TextStyle(
                  fontFamily: 'YTSans',
                ),
              ))
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MediaDownloadTab(),
            MediaMusicTab(),
            MediaVideoTab()
          ],
        ),
      ),
    );
  }
}