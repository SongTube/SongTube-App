import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/players/components/musicPlayer/ui/playerArtwork.dart';
import 'package:songtube/players/components/musicPlayer/ui/playerControls.dart';
import 'package:songtube/ui/components/fancyScaffold.dart';
import 'package:songtube/ui/sheets/musicEqualizer.dart';

class PlayerBody extends StatelessWidget {
  final File artworkFile;
  final bool expandArtwork;
  final FloatingWidgetController controller;
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
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom,
        child: Column(
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
                        text: Languages.of(context).labelPlayingFrom+"\n",
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
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () async {
                        final equalizerMap = await AudioService.customAction('retrieveEqualizer');
                        final loudnessMap = await AudioService.customAction('retrieveLoudnessGain');
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)
                            )
                          ),
                          context: context,
                          builder: (context) => MusicEqualizerSheet(
                            equalizerMap: equalizerMap, loudnessMap: loudnessMap)
                        );
                      },
                      icon: Icon(Icons.equalizer_rounded, color: textColor),
                    ),
                  )
                ],
              ),
              Expanded(
                child: PlayerArtwork(
                  image: artworkFile,
                  textColor: textColor,
                  expandArtwork: expandArtwork,
                )
              ),
              PlayerControls(
                vibrantColor: vibrantColor,
                mediaItem: mediaItem,
                playing: playing,
                textColor: textColor,
                dominantColor: dominantColor,
                state: state,
              )
          ],
        ),
      ),
    );
  }
}