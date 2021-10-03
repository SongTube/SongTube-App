// Dart
import 'dart:io';
import 'dart:ui';

// Flutter
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal
import 'package:songtube/players/service/playerService.dart';
import 'package:songtube/players/components/musicPlayer/ui/playerBackground.dart';
import 'package:songtube/players/components/musicPlayer/ui/playerBody.dart';
import 'package:songtube/players/service/screenStateStream.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/mediaProvider.dart';

// Packages
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/components/fancyScaffold.dart';

class ExpandedPlayer extends StatelessWidget {
  static FloatingWidgetConfig config () {
    return FloatingWidgetConfig(
      
    );
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ScreenState>(
      stream: screenStateStream,
      builder: (context, snapshot) {
        final screenState = snapshot.data;
        final mediaItem = screenState?.mediaItem;
        final state = screenState?.playbackState;
        final playing = state?.playing ?? false;
        PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
        ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
        MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
        File image = mediaProvider.artwork;
        Color dominantColor = prefs.enablePlayerBlurBackground
          ? mediaProvider.dominantColor == null ? Colors.white : mediaProvider.dominantColor
          : Theme.of(context).accentColor;
        Color textColor = prefs.enablePlayerBlurBackground
          ? dominantColor.computeLuminance() > 0.5 ? Colors.black : Colors.white
          : Theme.of(context).textTheme.bodyText1.color;
        Color vibrantColor = prefs.enablePlayerBlurBackground
          ? mediaProvider.vibrantColor == null ? Colors.white : mediaProvider.vibrantColor
          : Theme.of(context).accentColor;
        return PlayerBackground(
          backgroundImage: File(AudioService.currentMediaItem?.extras["artwork"] ?? ''),
          enableBlur: prefs.enablePlayerBlurBackground,
          blurIntensity: 50,
          backdropColor: prefs.enablePlayerBlurBackground
            ? dominantColor
            : Theme.of(context).scaffoldBackgroundColor,
          backdropOpacity: 0.4,
          child: PlayerBody(
            controller: mediaProvider.fwController,
            playingFrom: mediaItem?.album ?? '',
            textColor: textColor,
            artworkFile: image,
            vibrantColor: vibrantColor,
            playing: playing,
            mediaItem: mediaItem,
            dominantColor: dominantColor,
            state: state,
            expandArtwork: config.useExpandedArtwork,
          )
        );
      }
    );
  }
}