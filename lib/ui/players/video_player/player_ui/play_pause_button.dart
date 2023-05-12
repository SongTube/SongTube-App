import 'package:flutter/material.dart';

class VideoPlayerPlayPauseButton extends StatelessWidget {
  final bool isPlaying;
  final Function() onPlayPause;
  const VideoPlayerPlayPauseButton({
    required this.isPlaying,
    required this.onPlayPause,
    Key? key
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPlayPause,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.black.withOpacity(0.2)
        ),
        padding: const EdgeInsets.all(16.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          switchInCurve: Curves.ease,
          switchOutCurve: Curves.ease,
          child: isPlaying
            ? const Icon(
                Icons.pause,
                size: 26,
                color: Colors.white,
                key: ValueKey('playerPauseButton'),
              )
            : const Icon(
                Icons.play_arrow,
                size: 26,
                color: Colors.white,
                key: ValueKey('playerPlayButton'),
              ),
        ),
      ),
    );
  }
}