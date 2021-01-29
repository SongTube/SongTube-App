import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/players/components/musicPlayer/ui/marqueeWidget.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoPageCollapsed extends StatelessWidget {
  final bool isPlaylist;
  VideoPageCollapsed({
    this.isPlaylist = false
  });
  //ignore: close_sinks
  final BehaviorSubject<double> _dragPositionSubject =
    BehaviorSubject.seeded(null);
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    String title = !isPlaylist
      ? manager.mediaInfoSet.videoFromSearch.videoTitle
      : manager.mediaInfoSet.playlistFromSearch.playlistTitle;
    String author = !isPlaylist
      ? manager.mediaInfoSet.videoFromSearch.videoAuthor : "";
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.only(left: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: !isPlaylist
                    ? FadeInImage(
                        fadeInDuration: Duration(milliseconds: 400),
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(
                          manager.mediaInfoSet.videoFromSearch
                            .videoThumbnails[0].url.toString()
                        ),
                        fit: BoxFit.cover,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Icon(
                          MdiIcons.playlistMusic,
                          color: Theme.of(context).iconTheme.color
                        ),
                      )
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
                            "$title",
                            style: TextStyle(
                              fontFamily: 'YTSans',
                              fontSize: 16
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ),
                        if (author != "")
                        SizedBox(height: 2),
                        if (author != "")
                        Text(
                          "$author",
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
                  Duration position = manager?.playerController?.value?.position ?? Duration(microseconds: 0);
                  Duration duration = manager?.playerController?.value?.duration ?? Duration(seconds: 1);
                  return CircularProgressIndicator(
                    strokeWidth: 3,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
                    value: (position.inMilliseconds/duration.inMilliseconds),
                  );
                }
              ),
              IconButton(
                icon: manager?.playerController?.value?.isPlaying ?? false
                  ? Icon(MdiIcons.pause, size: 22)
                  : Icon(MdiIcons.play, size: 22),
                onPressed: manager?.playerController?.value?.isPlaying ?? false
                  ? () { manager.playerController.pause(); manager.setState(); }
                  : () { manager.playerController.play(); manager.setState(); }
              ),
            ],
          ),
          SizedBox(width: 16)
        ],
      ),
    );
  }
}