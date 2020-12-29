// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/players/service/screenStateStream.dart';
import 'package:songtube/players/service/playerService.dart';

// Packages
import 'package:audio_service/audio_service.dart';

class MusicPlayerPadding extends StatelessWidget {
  final bool searchBarOpen;
  MusicPlayerPadding(this.searchBarOpen);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ScreenState>(
      stream: screenStateStream,
      builder: (context, snapshot) {
        final screenState = snapshot.data;
        final state = screenState?.playbackState;
        final processingState =
          state?.processingState ?? AudioProcessingState.none;
        return Container(
          height: searchBarOpen
            ? 0 : processingState == AudioProcessingState.stopped ||
              processingState == AudioProcessingState.none
                ? 0
                : kToolbarHeight * 1.15
        );
      }
    );
  }
}