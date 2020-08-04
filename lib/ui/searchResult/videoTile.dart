import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

class VideoTile extends StatefulWidget {
  final yt.SearchVideo video;
  final Function onSelect;
  VideoTile({
    @required this.video,
    @required this.onSelect
  });
  @override
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> with TickerProviderStateMixin {
  
  // Show Detials
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10
            ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              setState(() => showDetails = !showDetails);
            },
            child: Ink(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: showDetails ? Radius.zero : Radius.circular(20),
                  bottomRight: showDetails ? Radius.zero : Radius.circular(20),
                ),
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
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8),
                    height: 100,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        fadeInDuration: Duration(milliseconds: 200),
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage("http://img.youtube.com/vi/${widget.video.videoId}/mqdefault.jpg"),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 16, left: 8, right: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${widget.video.videoTitle}",
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${widget.video.videoAuthor}",
                                style: TextStyle(
                                  color: Colors.grey[600]
                                ),
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                height: 30,
                                width: 30,
                                margin: EdgeInsets.only(bottom: 8),
                                child: Icon(Icons.expand_more, size: 20, color: Colors.grey[600]),
                              ),
                              GestureDetector(
                                onTap: () {
                                  manager.getVideoDetails("https://www.youtube.com/watch?v=${widget.video.videoId}");
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Theme.of(context).accentColor,
                                  ),
                                  child: Icon(EvaIcons.downloadOutline, size: 20, color: Colors.white),
                                ),
                              )
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          vsync: this,
          child: Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            height: showDetails ? 400 : 0,
            width: showDetails ? double.infinity : 0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
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
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}