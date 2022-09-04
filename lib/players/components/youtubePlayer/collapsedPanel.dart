import 'package:audio_service/audio_service.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:provider/provider.dart';
import 'package:songtube/players/components/musicPlayer/ui/marqueeWidget.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoPageCollapsed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    String title = pageProvider?.infoItem?.name ?? "";
    String author = pageProvider?.infoItem?.uploaderName ?? "";
    String thumbnailUrl = pageProvider.infoItem is StreamInfoItem
      ? pageProvider?.infoItem?.thumbnails?.hqdefault ?? ""
      : pageProvider?.infoItem?.thumbnailUrl ?? "";
    return Container(
      height: kBottomNavigationBarHeight * 1.15,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10)
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
                  margin: EdgeInsets.only(left: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: pageProvider.infoItem is StreamInfoItem
                    ? FadeInImage(
                        fadeInDuration: Duration(milliseconds: 400),
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(thumbnailUrl),
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
                    margin: EdgeInsets.only(left: 8),
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
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Product Sans',
                              fontSize: 14,
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
                            fontFamily: 'Product Sans',
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
          Container(
            color: Colors.transparent,
            child: IconButton(
              icon: pageProvider?.playerKey?.currentState?.controller?.value?.isPlaying ?? false
                ? Icon(MdiIcons.pause, size: 22)
                : Icon(MdiIcons.play, size: 22),
              onPressed: pageProvider?.playerKey?.currentState?.controller?.value?.isPlaying ?? false
                ? () { pageProvider.playerKey.currentState.controller.pause(); pageProvider.setState(); }
                : () { pageProvider.playerKey.currentState.controller.play(); pageProvider.setState(); }
            ),
          ),
          InkWell(
            onTap: () {
              if (pageProvider.playerKey.currentState.audioOnly && AudioService.running) {
                AudioService.stop();
              }
              pageProvider.closeVideoPanel();

            },
            child: Ink(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(EvaIcons.close),
              )
            ),
          ),
          SizedBox(width: 16)
        ],
      ),
    );
  }
}