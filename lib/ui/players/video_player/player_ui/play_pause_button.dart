import 'package:flutter/material.dart';
import 'package:songtube/ui/animations/animated_icon.dart';

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
          color: Theme.of(context).cardColor.withOpacity(0.7)
        ),
        padding: const EdgeInsets.all(16.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          switchInCurve: Curves.ease,
          switchOutCurve: Curves.ease,
          child: isPlaying
            ? Semantics(
              label: 'Pause',
              child: const AppAnimatedIcon(
                  Icons.pause,
                  size: 26,
                  key: ValueKey('playerPauseButton'),
                ),
            )
            : Semantics(
              label: 'Play',
              child: const AppAnimatedIcon(
                  Icons.play_arrow,
                  size: 26,
                  key: ValueKey('playerPlayButton'),
                ),
            ),
        ),
      ),
    );
  }
}