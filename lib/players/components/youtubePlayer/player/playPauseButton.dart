import 'package:flutter/material.dart';

class PlayPauseButton extends StatelessWidget {
  final bool isPlaying;
  final Function onPlayPause;
  PlayPauseButton({
    @required this.isPlaying,
    @required this.onPlayPause
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPlayPause,
      borderRadius: BorderRadius.circular(100),
      child: Ink(
        padding: const EdgeInsets.all(16.0),
        child: isPlaying
          ? Icon(
              Icons.pause,
              size: 32,
              color: Colors.white,
            )
          : Icon(
              Icons.play_arrow,
              size: 32,
              color: Colors.white,
            ),
      ),
    );
  }
}