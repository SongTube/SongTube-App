import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProgressBar extends StatelessWidget {
  final VideoPlayerController controller;
  final Stream position;
  VideoPlayerProgressBar({
    @required this.controller,
    @required this.position
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<Duration>(
            stream: position,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.only(left: 16, right: 8, top: 4),
                  child: Text(
                    "${snapshot.data.inMinutes.toString().padLeft(2, '0')}:" +
                    "${snapshot.data.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white
                    ),
                  )
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(left: 16, right: 8, top: 4),
                  child: Text(
                    "00:00",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white
                    ),
                  )
                );
              }
            }
          ),
          Expanded(
            child: VideoProgressIndicator(
              controller,
              allowScrubbing: true,
              colors: VideoProgressColors(
                playedColor: Theme.of(context).accentColor,
                bufferedColor: Colors.grey[500].withOpacity(0.6),
                backgroundColor: Colors.grey[600].withOpacity(0.6)
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 16, top: 4),
            child: Text(
              "${controller.value.duration.inMinutes.toString().padLeft(2, '0')}:" +
              "${controller.value.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white
              ),
            )
          )
        ],
      ),
    );
  }
}