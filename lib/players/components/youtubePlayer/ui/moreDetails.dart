import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:newpipeextractor_dart/models/streamSegment.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class MoreDetailsSheet extends StatefulWidget {
  final YoutubeVideo video;
  final List<StreamSegment> segments;
  final Function(int) onSegmentTap;
  final Function onDispose;
  MoreDetailsSheet({
    this.video,
    this.segments = const [],
    this.onSegmentTap,
    this.onDispose
  });

  @override
  _MoreDetailsSheetState createState() => _MoreDetailsSheetState();
}

class _MoreDetailsSheetState extends State<MoreDetailsSheet> {
  
  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.segments.isEmpty) {
      return _detailsTab(context);
    } else {
      return DefaultTabController(
        length: 2,
        initialIndex: 1,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  _detailsTab(context),
                  _segmentsTab(context)
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: Offset(0, -10),
                    spreadRadius: 0.1,
                    blurRadius: 8
                  )
                ]
              ),
              child: TabBar(
                labelColor: Theme.of(context).accentColor,
                unselectedLabelColor: Theme.of(context).textTheme.bodyText1
                  .color.withOpacity(0.4),
                indicator: MD2Indicator(
                  indicatorSize: MD2IndicatorSize.tiny,
                  indicatorHeight: 4,
                  indicatorColor: Theme.of(context).accentColor,
                ),
                tabs: [
                  Tab(icon: Icon(EvaIcons.listOutline, color: Theme.of(context).iconTheme.color)),
                  Tab(icon: Icon(EvaIcons.mapOutline, color: Theme.of(context).iconTheme.color)),
                ],
              ),
            ),
          ],
        )
      );
    }
  }

  Widget _detailsTab(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                "Description",
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyText1.color
                    .withOpacity(0.7)
                ),
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.clear_rounded,
                color: Theme.of(context).iconTheme.color),
              onPressed: () => Navigator.pop(context),
            ),
            SizedBox(width: 12)
          ],
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[600].withOpacity(0.1),
        ),
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Html(
                data: widget.video.description,
                renderNewlines: true,
                padding: EdgeInsets.all(12),
                defaultTextStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
                customRender: (node, children) {
                  if (node is dom.Element) {
                    if (node.localName == "a") {
                      String text = node.text;
                      Duration duration;
                      try {
                        duration = parseDuration(text);
                      } catch (_) {}
                      return GestureDetector(
                        onTap: () {
                          if (duration != null) {
                            widget.onSegmentTap(duration.inSeconds);
                          } else {
                            launch(node.attributes['href']);
                          }
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Text(
                            text,
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dotted,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return null;
                    }
                  } else {
                    return null;
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _segmentsTab(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                "Chapters",
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyText1.color
                    .withOpacity(0.7)
                ),
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.clear_rounded,
                color: Theme.of(context).iconTheme.color),
              onPressed: () => Navigator.pop(context),
            ),
            SizedBox(width: 12)
          ],
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[600].withOpacity(0.1),
          indent: 12,
          endIndent: 12
        ),
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: widget.segments.length,
            itemBuilder: (context, index) {
              StreamSegment segment = widget.segments[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  leading: AspectRatio(
                    aspectRatio: 16/9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(segment.previewUrl),
                        fadeInDuration: Duration(milliseconds: 300),
                      ),
                    ),
                  ),
                  title: Text(
                    segment.title,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color
                        .withOpacity(0.8),
                      fontFamily: 'Product Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    "${Duration(seconds: segment.startTimeSeconds).inMinutes.toString().padLeft(2, '0')}:"+
                    "${Duration(seconds: segment.startTimeSeconds).inSeconds.remainder(60).toString().padLeft(2, '0')}",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontFamily: 'Product Sans',
                      fontSize: 10,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  onTap: () => widget.onSegmentTap(segment.startTimeSeconds)
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
}