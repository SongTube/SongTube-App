// Dart
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:provider/provider.dart';

// Internal
import 'package:songtube/internal/services/playerService.dart';
import 'package:songtube/internal/screenStateStream.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:songtube/player/internal/artworkGenerator.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

// UI
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:songtube/ui/animations/showUp.dart';

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
          if (mediaItem != null) {
            return Column(
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
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.2),
                          offset: Offset(0,0), //(x,y)
                          blurRadius: 10.0,
                          spreadRadius: 2.0 
                        )
                      ],
                    ),
                    child: FutureBuilder(
                      future: ArtworkGenerator.generateArtwork(
                        File(mediaItem.id),
                        mediaItem.extras["albumId"]
                      ),
                      builder: (context, AsyncSnapshot<File> image) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                            fadeOutDuration: Duration(milliseconds: 300),
                            fadeInDuration: Duration(milliseconds: 300),
                            placeholder: MemoryImage(kTransparentImage),
                            image: image.hasData
                              ? FileImage(image.data)
                              : MemoryImage(kTransparentImage),
                            fit: BoxFit.cover,
                          ),
                        );
                      }
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
                            color: Theme.of(context).textTheme.bodyText1.color
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
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontFamily: "Varela"
                        )
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
                          color: Theme.of(context).iconTheme.color.withOpacity(0.7)
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
                            color: Theme.of(context).accentColor,
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
                                color: Colors.white)
                            : Icon(Icons.play_arrow, size: 25,
                                color: Colors.white),
                        ),
                      ),
                      // Padding
                      SizedBox(width: 30),
                      // Next button
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Theme.of(context).iconTheme.color.withOpacity(0.7)
                        ),
                        onPressed: () => AudioService.skipToNext(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20)
              ],
            );
          } else {
            return Container();
          }
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
                    activeColor: Theme.of(context).accentColor.withOpacity(0.7),
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
                        color: Theme.of(context).textTheme.bodyText1.color
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${duration.inMinutes}:${(duration.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                      style: TextStyle(
                        fontFamily: "Varela",
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodyText1.color
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