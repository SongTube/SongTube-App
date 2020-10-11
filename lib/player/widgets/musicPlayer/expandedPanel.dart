// Dart
import 'dart:io';
import 'dart:math';
import 'dart:ui';

// Flutter
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// Internal
import 'package:songtube/internal/services/playerService.dart';
import 'package:songtube/player/widgets/musicPlayer/ui/marqueeWidget.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/player/widgets/musicPlayer/dialogs/settingsDialog.dart';
import 'package:songtube/player/widgets/musicPlayer/ui/randomButton.dart';
import 'package:songtube/player/widgets/musicPlayer/ui/repeatButton.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:rxdart/rxdart.dart';

class ExpandedPlayer extends StatelessWidget {
  final PanelController controller;
  final AsyncSnapshot<ScreenState> snapshot;
  ExpandedPlayer({
    this.controller,
    this.snapshot,
  });
  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);
  @override
  Widget build(BuildContext context) {
    final screenState = snapshot.data;
    final mediaItem = screenState?.mediaItem;
    final state = screenState?.playbackState;
    final playing = state?.playing ?? false;
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              child: appData.useBlurBackground
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: FadeInImage(
                      fadeOutDuration: Duration.zero,
                      image: FileImage(image),
                      placeholder: MemoryImage(kTransparentImage),
                      fadeInDuration: Duration(milliseconds: 400),  
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  )
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              color: appData.useBlurBackground
                ? dominantColor.withOpacity(0.4)
                : Theme.of(context).scaffoldBackgroundColor,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 22.0,
                  sigmaY: 22.0,
                ),
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
                              text: "Playing From\n",
                              style: TextStyle(
                                letterSpacing: 2,
                                color: textColor,
                                fontFamily: 'YTSans'
                              )
                            ),
                            TextSpan(
                              text: "${mediaItem.album}",
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
                    appData.useExpandedArtwork
                      ? Expanded(
                          child: artworkWidget(image),
                        )
                      : artworkWidget(image),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Title
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: MarqueeWidget(
                              animationDuration: Duration(seconds: 10),
                              backDuration: Duration(seconds: 5),
                              pauseDuration: Duration(seconds: 2),
                              direction: Axis.horizontal,
                              child: Text(
                                mediaItem.title,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "YTSans",
                                  color: textColor
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            ),
                          ),
                          // Artist
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 8),
                            child: Text(
                              mediaItem.artist,
                              style: TextStyle(
                                color: textColor.withOpacity(0.6),
                                fontFamily: "YTSans",
                                fontSize: 16
                              ),
                            ),
                          ),
                          // Progress Indicator
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: positionIndicator(mediaItem, state, vibrantColor, textColor)
                          ),
                          // MediaControls
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Random Button
                              MusicPlayerRandomButton(
                                iconColor: textColor,
                                enabledColor: dominantColor
                              ),
                              // Previous button
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 18,
                                  color: textColor.withOpacity(0.7)
                                ),
                                onPressed: () => AudioService.skipToPrevious(),
                              ),
                              // Padding
                              SizedBox(width: 20),
                              // Play/Pause button
                              GestureDetector(
                                onTap: playing
                                  ? () => AudioService.pause()
                                  : () => AudioService.play(),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: dominantColor,
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        offset: Offset(0,3),
                                        blurRadius: 8,
                                        spreadRadius: 1 
                                      )
                                    ]
                                  ),
                                  child: playing
                                    ? Icon(Icons.pause, size: 25, 
                                        color: appData.useBlurBackground
                                          ? textColor
                                          : Colors.white
                                      )
                                    : Icon(Icons.play_arrow, size: 25,
                                        color: appData.useBlurBackground
                                          ? textColor
                                          : Colors.white
                                      )
                                ),
                              ),
                              // Padding
                              SizedBox(width: 20),
                              // Next button
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: textColor.withOpacity(0.7)
                                ),
                                onPressed: () => AudioService.skipToNext(),
                              ),
                              // Repeat Button
                              MusicPlayerRepeatButton(
                                iconColor: textColor,
                                enabledColor: dominantColor
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 16),
                            child: Row(
                              children: [
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: IconButton(
                                    icon: Icon(
                                      EvaIcons.dropletOutline,
                                      color: textColor.withOpacity(0.6)
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => MusicPlayerSettingsDialog(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget artworkWidget(File image) {
    return Container(
      height: 320,
      width: 320,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black87.withOpacity(0.2),
            offset: Offset(0,0), //(x,y)
            blurRadius: 14.0,
            spreadRadius: 2.0 
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget positionIndicator(MediaItem mediaItem, PlaybackState state, Color dominantColor, Color textColor) {
    double seekPos;
    return StreamBuilder(
      stream: Rx.combineLatest2<double, double, double>(
          _dragPositionSubject.stream,
          Stream.periodic(Duration(milliseconds: 1000)),
          (dragPosition, _) => dragPosition),
      builder: (context, snapshot) {
        Duration position = state.currentPosition;
        Duration duration = mediaItem?.duration;
        return duration != null
          ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
                    valueIndicatorTextStyle: TextStyle(
                      color: dominantColor,
                    ),
                    trackHeight: 2,
                  ),
                  child: Slider(
                    activeColor: dominantColor.withOpacity(0.7),
                    inactiveColor: Colors.black12.withOpacity(0.1),
                    min: 0.0,
                    max: duration.inMilliseconds?.toDouble(),
                    value: seekPos ?? max(0.0, min(
                      position.inMilliseconds.toDouble(),
                      duration.inMilliseconds?.toDouble()
                    )),
                    onChanged: (value) {
                      _dragPositionSubject.add(value);
                    },
                    onChangeEnd: (value) {
                      AudioService.seekTo(Duration(milliseconds: value.toInt()));
                      seekPos = value;
                      _dragPositionSubject.add(null);
                    },
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${position.inMinutes}:${(position.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                      style: TextStyle(
                        fontFamily: "YTSans",
                        fontSize: 12,
                        color: textColor.withOpacity(0.6)
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${duration.inMinutes}:${(duration.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                      style: TextStyle(
                        fontFamily: "YTSans",
                        fontSize: 12,
                        color: textColor.withOpacity(0.6)
                      ),
                    )
                  ],
                ),
              )
            ],
          )
          : Container();
      },
    );
  }
}