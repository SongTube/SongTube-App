// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/player/components/videoPlayer/progressBar.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class VideoPlayerControls extends StatelessWidget {
  final VideoPlayerProgressBar progressBar;
  final Function onPlayPause;
  final Function onExit;
  final String videoTitle;
  final bool showControls;
  final bool playing;
  VideoPlayerControls({
    @required this.progressBar,
    @required this.onPlayPause,
    @required this.onExit,
    @required this.videoTitle,
    @required this.showControls,
    @required this.playing
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: showControls == true ? 0.0 : 1.0,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.3),
        child: Column(
          children: <Widget>[
            // Video Title & Author
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: Icon(EvaIcons.videoOutline, color: Theme.of(context).accentColor),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, left: 8),
                      child: Text(
                        videoTitle.replaceAll(".webm", '')
                          .replaceAll(".mp4", '')
                          .replaceAll(".avi", '')
                          .replaceAll(".3gpp", '')
                          .replaceAll(".flv", '')
                          .replaceAll(".mkv", ''),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: onPlayPause,
                    child: Ink(
                      child: Icon(
                        playing
                          ? MdiIcons.pause
                          : MdiIcons.play,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            // ProgressBar
            progressBar
          ],
        ),
      )
    );
  }
}