// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/screens/mediaScreen/downloadsTab.dart';
import 'package:songtube/screens/mediaScreen/musicTab.dart';
import 'package:songtube/screens/mediaScreen/videosTab.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class MediaScreen extends StatelessWidget {
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
                  ],
                ),
              ),
            ),
          ),
          bottom: TabBar(
            labelStyle: TextStyle(
              fontFamily: 'Varela',
              fontWeight: FontWeight.w500
            ),
            labelColor: Theme.of(context).textTheme.bodyText1.color,
            unselectedLabelColor: Theme.of(context).textTheme.bodyText1.color,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Theme.of(context).accentColor,
            tabs: [
              Tab(child: Text(
                "Downloads",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Varela',
                  color: Theme.of(context).iconTheme.color
                ),
              )),
              Tab(child: Text(
                "Music",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Varela',
                  color: Theme.of(context).iconTheme.color
                ),
              )),
              Tab(child: Text(
                "Videos",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Varela',
                  color: Theme.of(context).iconTheme.color
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