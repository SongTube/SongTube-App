// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/globals/globals.dart';

// Packages
import 'package:audio_service/audio_service.dart';

class MusicPlayerPadding extends StatelessWidget {
  final bool searchBarOpen;
  MusicPlayerPadding(this.searchBarOpen);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackState>(
      stream: audioHandler.playbackState,
      builder: (context, snapshot) {
        final playbackState = snapshot.data;
        return Container(
          height: searchBarOpen ? 0 : playbackState.processingState == AudioProcessingState.idle
            ? 0 : kToolbarHeight * 1.15
        );
      }
    );
  }
}