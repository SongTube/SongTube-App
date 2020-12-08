// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:songtube/internal/languages.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoDownloadMenu extends StatefulWidget {
  final List<VideoStreamInfo> videoList;
  final Function(List<dynamic>) onOptionSelect;
  final Function onBack;
  final double audioSize;
  VideoDownloadMenu({
    @required this.videoList,
    @required this.onOptionSelect,
    @required this.audioSize,
    @required this.onBack
  });

  @override
  _VideoDownloadMenuState createState() => _VideoDownloadMenuState();
}

class _VideoDownloadMenuState extends State<VideoDownloadMenu> {

  void _onOptionSelect(VideoStreamInfo video) {
    List<dynamic> list = [
      "Video",
      video,
      "1.0", "0", "0"
    ];
    widget.onOptionSelect(list);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Menu Title
        Container(
          margin: EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(EvaIcons.arrowBackOutline),
                onPressed: widget.onBack
              ),
              SizedBox(width: 4),
              Text(Languages.of(context).labelSelectVideo, style: TextStyle(
                fontSize: 20,
                fontFamily: "YTSans"
              )),
            ],
          ),
        ),
        Expanded(
          child: GroupedListView<VideoStreamInfo, String>(
            stickyHeaderBackgroundColor: Theme.of(context)
              .scaffoldBackgroundColor,
            physics: BouncingScrollPhysics(),
            elements: widget.videoList,
            groupBy: (element) =>
              (element.videoQualityLabel.split("p").first+"p"),
            groupSeparatorBuilder: (String groupByValue) =>
              Container(
                padding: EdgeInsets.only(
                  top: 8, bottom: 8,
                  left: 16, right: 16
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 16,
                      color: Colors.black.withOpacity(0.06),
                      offset: Offset(0,12)
                    )
                  ]
                ),
                child: Row(
                  children: [
                    Icon(EvaIcons.monitorOutline,
                      color: Theme.of(context).accentColor),
                    SizedBox(width: 8),
                    Text(
                      groupByValue,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'YTSans',
                      ),
                    ),
                  ],
                ),
              ),
            useStickyGroupSeparators: true,
            order: GroupedListOrder.DESC,
            groupComparator: (item1, item2) =>
              int.parse(item1.split("p").first)
              .compareTo(int.parse(item2.split("p").first)),
            itemComparator: (item1, item2) =>
              (item1.size.totalMegaBytes)
              .compareTo((item2.size.totalMegaBytes)),
            itemBuilder: (context, VideoStreamInfo element) {
              return GestureDetector(
                onTap: () {
                  _onOptionSelect(element);
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: 12,
                    right: 12
                  ),
                  height: 100,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(width: 24),
                      Icon(EvaIcons.videoOutline, size: 36),
                      SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${element.container.name.toUpperCase()}",
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.left,
                              softWrap: false,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16
                              ),
                            ),
                            Text(
                              "${element.bitrate.kiloBitsPerSecond.toStringAsFixed(0)} Kbit/s",
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.left,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 12
                              ),
                            ),
                            Text(
                              "${(element.size.totalMegaBytes + widget.audioSize).toStringAsFixed(2)} MB",
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.left,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 12
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            element.framerate.framesPerSecond > 50
                            ? Text(
                                "${element.framerate.framesPerSecond} FPS",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'YTSans',
                                ),
                              ) : Container(),
                            element.videoQualityLabel.contains("HDR")
                            ? Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context).accentColor
                                ),
                                child: Text(
                                  "HDR",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5
                                  ),
                                ),
                              ) : Container()
                          ],
                        ),
                      )
                    ],
                  )
                ),
              );
            }
          ),
        ),
      ],
    );
  }
}