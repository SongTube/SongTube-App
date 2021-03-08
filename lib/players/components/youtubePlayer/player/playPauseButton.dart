import 'package:flutter/material.dart';

class PlayPauseButton extends StatelessWidget {
  final bool isBuffering;
  final bool isPlaying;
  final Function onPlayPause;
  PlayPauseButton({
    @required this.isBuffering,
    @required this.isPlaying,
    @required this.onPlayPause
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlayPause,
      child: isBuffering
        ? CircularProgressIndicator(
            value: null,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          )
        : isPlaying
          ? Icon(
              Icons.pause,
              size: 42,
              color: Colors.white,
            )
          : Icon(
              Icons.play_arrow,
              size: 42,
              color: Colors.white,
            ),
    );
  }
}