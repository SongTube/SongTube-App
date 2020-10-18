import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:songtube/player/components/musicPlayer/ui/playerArtwork.dart';
import 'package:songtube/player/components/musicPlayer/ui/playerControls.dart';

class PlayerBody extends StatelessWidget {
  final File artworkFile;
  final bool expandArtwork;
  final PanelController controller;
  final Color textColor;
  final double artworkRoundedCorners;
  final String playingFrom;
  final Color vibrantColor;
  final MediaItem mediaItem;
  final bool playing;
  final Color dominantColor;
  final PlaybackState state;
  PlayerBody({
    @required this.artworkFile,
    this.expandArtwork = true,
    @required this.controller,
    @required this.textColor,
    this.artworkRoundedCorners = 20,
    @required this.playingFrom,
    @required this.vibrantColor,
    @required this.mediaItem,
    @required this.playing,
    @required this.dominantColor,
    @required this.state
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.expand_more, color: textColor),
            onPressed: () {
              controller.close();
            },
          ),
          title: RichText(
            textAlign: TextAlign.center,
            maxLines: 2,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Playing From\n",
                  style: TextStyle(
                    letterSpacing: 2,
                    color: textColor,
                    fontFamily: 'YTSans'
                  )
                ),
                TextSpan(
                  text: "$playingFrom",
                  style: TextStyle(
                    color: textColor.withOpacity(0.6),
                    fontSize: 12,
                    fontFamily: 'YTSans'
                  )
                )
              ]
            ),
          ),
        ),
        expandArtwork
          ? Expanded(
              child: PlayerArtwork(image: artworkFile)
            )
          : PlayerArtwork(image: artworkFile),
        PlayerControls(
          vibrantColor: vibrantColor,
          mediaItem: mediaItem,
          playing: playing,
          textColor: textColor,
          dominantColor: dominantColor,
          state: state,
        )
      ],
    );
  }
}