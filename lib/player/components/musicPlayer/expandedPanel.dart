// Dart
import 'dart:io';
import 'dart:ui';

// Flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal
import 'package:songtube/player/service/playerService.dart';
import 'package:songtube/player/components/musicPlayer/ui/playerBackground.dart';
import 'package:songtube/player/components/musicPlayer/ui/playerBody.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/mediaProvider.dart';

// Packages
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ExpandedPlayer extends StatelessWidget {
  final PanelController controller;
  final AsyncSnapshot<ScreenState> snapshot;
  ExpandedPlayer({
    this.controller,
    this.snapshot,
  });
  @override
  Widget build(BuildContext context) {
    final screenState = snapshot.data;
    final mediaItem = screenState?.mediaItem;
    final state = screenState?.playbackState;
    final playing = state?.playing ?? false;
    ConfigurationProvider appData = Provider.of<ConfigurationProvider>(context);
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    File image = mediaProvider.artwork;
    Color dominantColor = appData.useBlurBackground
      ? mediaProvider.dominantColor == null ? Colors.white : mediaProvider.dominantColor
      : Theme.of(context).accentColor;
    Color textColor = appData.useBlurBackground
      ? dominantColor.computeLuminance() > 0.5 ? Colors.black : Colors.white
      : Theme.of(context).textTheme.bodyText1.color;
    Color vibrantColor = appData.useBlurBackground
      ? mediaProvider.vibrantColor == null ? Colors.white : mediaProvider.vibrantColor
      : Theme.of(context).accentColor;
    return Scaffold(
      backgroundColor: !appData.useBlurBackground
        ? Theme.of(context).scaffoldBackgroundColor
        : dominantColor,
      body: PlayerBackground(
        backgroundImage: File(mediaItem.artUri.replaceAll("file://", "")),
        enableBlur: appData.useBlurBackground,
        blurIntensity: 50,
        backdropColor: appData.useBlurBackground
          ? dominantColor
          : Theme.of(context).scaffoldBackgroundColor,
        backdropOpacity: 0.4,
        child: PlayerBody(
          controller: controller,
          playingFrom: mediaItem.album,
          textColor: textColor,
          artworkFile: image,
          vibrantColor: vibrantColor,
          playing: playing,
          mediaItem: mediaItem,
          dominantColor: dominantColor,
          state: state,
          expandArtwork: appData.useExpandedArtwork,
        )
      )
    );
  }
}