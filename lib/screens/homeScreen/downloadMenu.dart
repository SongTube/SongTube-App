import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:songtube/screens/homeScreen/downloadMenu/videoMenu.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;
import 'package:songtube/screens/homeScreen/downloadMenu/audioMenu.dart';

class DownloadMenu extends StatefulWidget {
  final List<youtube.VideoStreamInfo> videoList;
  final Function onSettingsPressed;
  DownloadMenu({
    @required this.videoList,
    @required this.onSettingsPressed
  });
  @override
  _DownloadMenuState createState() => _DownloadMenuState();
}

class _DownloadMenuState extends State<DownloadMenu> with TickerProviderStateMixin {

  // Variables
  double menuSize = 190;
  int subMenu = 0;

  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      height: menuSize,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 8, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                IconButton(
                  icon: Icon(EvaIcons.arrowBackOutline),
                  onPressed: () {
                    setState(() {
                      subMenu = 0;
                      menuSize = 160;
                    });
                  },
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("Download", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700))
                  ),
              ]
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: SizedBox(height: 1),
          ),
          // Downloads Menu
          Expanded(
            child: Stack(
              children: <Widget>[
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 80),
                  child: subMenu == 0
                  ? Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                menuSize = MediaQuery.of(context).size.height*0.55;
                                subMenu = 1;
                              });
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.only(left:16, right:16),
                              padding: EdgeInsets.all(8),
                              duration: Duration(milliseconds: 60),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).cardColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.05),
                                    offset: Offset(0, 3), //(x,y)
                                    blurRadius: 6.0,
                                    spreadRadius: 0.01 
                                  )
                                ]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Theme.of(context).scaffoldBackgroundColor
                                    ),
                                    child: Icon(EvaIcons.musicOutline, size: 35, color: Theme.of(context).iconTheme.color)
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      "Audio",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.9),
                                        fontFamily: "Varela"
                                      )
                                    )
                                  )
                                ]
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                menuSize = MediaQuery.of(context).size.height*0.55;
                                subMenu = 2;
                              });
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.only(left:16, right:16),
                              padding: EdgeInsets.all(8),
                              duration: Duration(milliseconds: 60),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).cardColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.05),
                                    offset: Offset(0, 3), //(x,y)
                                    blurRadius: 6.0,
                                    spreadRadius: 0.01 
                                  )
                                ]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Theme.of(context).scaffoldBackgroundColor
                                    ),
                                    child: Icon(EvaIcons.videoOutline, size: 35, color: Theme.of(context).iconTheme.color)
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      "Video",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.9),
                                        fontFamily: "Varela"
                                      )
                                    )
                                  )
                                ]
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  : subMenu == 1
                    ? AudioDownloadMenu(
                        onDownload: (list) {
                          if (list == null) {
                            setState(() {
                              menuSize = 160;
                              subMenu = 0;
                            });
                            return;
                          }
                          Navigator.pop(context, list);
                        },
                      )
                    : VideoDownloadMenu(
                        videoList: widget.videoList,
                        onOptionSelect: (list) {
                          if (list == null) {
                            setState(() {
                              menuSize = 160;
                              subMenu = 0;
                            });
                            return;
                          }
                          Navigator.pop(context, list);
                        },
                      ),
                ),
              ],
            ),
          ),
          // ------------------------------
        ],
      ),
    );
  }
}