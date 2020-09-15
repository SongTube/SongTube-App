// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/screens/media/downloadListView.dart';
import 'package:songtube/screens/media/musicListView.dart';
import 'package:songtube/screens/media/videoListView.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class MediaScreen extends StatefulWidget {
  @override
  _MediaScreenState createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(
            double.infinity,
            kToolbarHeight*2
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, -2), //(x,y)
                  blurRadius: 10.0,
                  spreadRadius: 0.6
                ),
              ],
            ),
            child: AppBar(
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
                  )),
                  Tab(child: Text(
                    "Downloads",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Varela',
                      color: Theme.of(context).iconTheme.color
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            MediaMusicList(),
            MediaVideoList(),
            MediaDownloadList()
          ],
        ),
      ),
    );
  }
}