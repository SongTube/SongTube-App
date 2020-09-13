// Dart
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/internal/playerService.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:songtube/screens/musicPlayer/screenStateStream.dart';
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:songtube/ui/animations/showUp.dart';
import 'package:transparent_image/transparent_image.dart';

class ExpandedPlayer extends StatelessWidget {
  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ScreenState>(
        stream: screenStateStream,
        builder: (context, snapshot) {
          final screenState = snapshot.data;
          final mediaItem = screenState?.mediaItem;
          final state = screenState?.playbackState;
          final playing = state?.playing ?? false;
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: FileImage(File(mediaItem.artUri.replaceFirst("file://", ""))),
                colorFilter: ColorFilter.mode(
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
                  BlendMode.darken
                )
              )
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInTransition(
                    delay: Duration(milliseconds: 100),
                    duration: Duration(milliseconds: 200),
                    child: Container(
                      height: 320,
                      width: 320,
                      margin: EdgeInsets.only(top: kToolbarHeight*0.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.2),
                            offset: Offset(0, 3), //(x,y)
                            blurRadius: 6.0,
                            spreadRadius: 1.0 
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          fadeOutDuration: Duration(milliseconds: 300),
                          fadeInDuration: Duration(milliseconds: 300),
                          placeholder: MemoryImage(kTransparentImage),
                          image: FileImage(File(mediaItem.artUri.replaceFirst("file://", ""))),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  ShowUpTransition(
                    forward: true,
                    duration: Duration(milliseconds: 200),
                    child: positionIndicator(mediaItem, state)
                  ),
                  ShowUpTransition(
                    forward: true,
                    delay: Duration(milliseconds: 100),
                    duration: Duration(milliseconds: 200),
                    child: Column(
                      children: <Widget>[
                        // Title
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            mediaItem.title,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Varela",
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 4),
                        // Artist
                        Text(
                          mediaItem.artist,
                          style: TextStyle(color: Colors.white, fontFamily: "Varela")
                        ),
                      ],
                    ),
                  ),
                  ShowUpTransition(
                    forward: true,
                    delay: Duration(milliseconds: 200),
                    duration: Duration(milliseconds: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Previous button
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                            color: Colors.white.withOpacity(0.7)
                          ),
                          onPressed: () => AudioService.skipToPrevious(),
                        ),
                        // Padding
                        SizedBox(width: 30),
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
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: playing
                              ? Icon(Icons.pause, size: 25, color: Colors.white)
                              : Icon(Icons.play_arrow, size: 25, color: Colors.white),
                          ),
                        ),
                        // Padding
                        SizedBox(width: 30),
                        // Next button
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Colors.white.withOpacity(0.7)
                          ),
                          onPressed: () => AudioService.skipToNext(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget positionIndicator(MediaItem mediaItem, PlaybackState state) {
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
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
                    valueIndicatorTextStyle: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  child: Slider(
                    activeColor: Colors.white.withOpacity(0.6),
                    inactiveColor: Colors.black12.withOpacity(0.2),
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
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${position.inMinutes}:${(position.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                      style: TextStyle(
                        fontFamily: "Varela",
                        fontSize: 12,
                        color: Colors.white
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${duration.inMinutes}:${(duration.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                      style: TextStyle(
                        fontFamily: "Varela",
                        fontSize: 12,
                        color: Colors.white
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