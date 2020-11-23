import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:songtube/players/components/musicPlayer/ui/marqueeWidget.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerCollapsed extends StatefulWidget {
  final YoutubePlayerController playerController;
  final String artworkUrl;
  final String videoTitle;
  final String videoAuthor;
  YoutubePlayerCollapsed({
    @required this.playerController,
    @required this.artworkUrl,
    @required this.videoTitle,
    @required this.videoAuthor
  });

  @override
  _YoutubePlayerCollapsedState createState() => _YoutubePlayerCollapsedState();
}

class _YoutubePlayerCollapsedState extends State<YoutubePlayerCollapsed> {
  //ignore: close_sinks
  final BehaviorSubject<double> _dragPositionSubject =
    BehaviorSubject.seeded(null);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          // Song AlbumArt & Title and Author
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      height: 50,
                      width: 50,
                      fadeInDuration: Duration(milliseconds: 400),
                      placeholder: MemoryImage(kTransparentImage),
                      image: widget.artworkUrl != null
                        ? NetworkImage(widget.artworkUrl)
                        : MemoryImage(kTransparentImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MarqueeWidget(
                          animationDuration: Duration(seconds: 8),
                          backDuration: Duration(seconds: 3),
                          pauseDuration: Duration(seconds: 2),
                          direction: Axis.horizontal,
                          child: Text(
                            "${widget.videoTitle}",
                            style: TextStyle(
                              fontFamily: 'YTSans',
                              fontSize: 16
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "${widget.videoAuthor}",
                          style: TextStyle(
                            fontFamily: 'YTSans',
                            fontSize: 11,
                            color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6)
                          ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // Play/Pause
          SizedBox(width: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              StreamBuilder(
                stream: Rx.combineLatest2<double, double, double>(
                  _dragPositionSubject.stream,
                  Stream.periodic(Duration(milliseconds: 1000)),
                  (dragPosition, _) => dragPosition),
                builder: (context, snapshot) {
                  Duration position = widget.playerController.value.position;
                  Duration duration = widget.playerController.value.metaData.duration;
                  double positionValue = 0;
                  if (position.inMilliseconds != 0 && duration.inMilliseconds != 0) {
                  positionValue = position.inMilliseconds/duration.inMilliseconds;
                  }
                  return CircularProgressIndicator(
                    strokeWidth: 3,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
                    value: positionValue
                  );
                }
              ),
              Consumer<ManagerProvider>(
                builder: (context, provider, _) {
                  return Container(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: provider.youtubePlayerState == PlayerState.playing
                        ? Icon(MdiIcons.pause, size: 22)
                        : Icon(MdiIcons.play, size: 22),
                      onPressed: () {
                        if (provider.youtubePlayerState == PlayerState.playing) {
                          widget.playerController.pause();
                        } else {
                          widget.playerController.play();
                        }
                        setState(() {});
                      }
                    ),
                  );
                }
              ),
            ],
          ),
          SizedBox(width: 16)
        ],
      ),
    );
  }
}