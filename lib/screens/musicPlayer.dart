// Dart
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:rxdart/rxdart.dart';

// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/internal/playerService.dart';
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:songtube/ui/animations/FadeIn.dart';
import 'package:songtube/ui/animations/showUp.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

class ExpandPlayer extends StatelessWidget {
  final Function onTap;
  ExpandPlayer({
    @required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Container(
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).accentColor
          ),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: Row(
              children: <Widget>[
                SizedBox(width: 12),
                Text(
                  "Playing",
                  style: TextStyle(
                    fontFamily: "Varela",
                    fontWeight: FontWeight.w600
                  )
                ),
                SizedBox(width: 12),
              ],
            )
          ),
        ),
      ),
    );
  }
}

class FullPlayerWidget extends StatelessWidget {
  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);
  final String pushedFrom;
  FullPlayerWidget({
    @required this.pushedFrom
  });
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "$pushedFrom",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.7),
            fontSize: 16
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color.withOpacity(0.7)
        ),
      ),
      body: StreamBuilder<ScreenState>(
        stream: manager.screenStateStream,
          builder: (context, snapshot) {
            final screenState = snapshot.data;
            final mediaItem = screenState?.mediaItem;
            final state = screenState?.playbackState;
            final processingState =
                state?.processingState ?? AudioProcessingState.none;
            final playing = state?.playing ?? false;
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (processingState == AudioProcessingState.none) ...[
                    Text("No audio in Queue")
                  ] else ...[
                    FadeInTransition(
                      delay: Duration(milliseconds: 100),
                      duration: Duration(milliseconds: 200),
                      child: Container(
                        height: 320,
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.2),
                              offset: Offset(0, 3), //(x,y)
                              blurRadius: 6.0,
                              spreadRadius: 1.0 
                            )
                          ]
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
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
                      duration: Duration(milliseconds: 200),
                      child: positionIndicator(mediaItem, state)
                    ),
                    ShowUpTransition(
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
                                color: Theme.of(context).textTheme.bodyText1.color,
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
                            style: TextStyle(color: Theme.of(context).iconTheme.color, fontFamily: "Varela")
                          ),
                        ],
                      ),
                    ),
                    ShowUpTransition(
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
                                      color: Colors.black12.withOpacity(0.2),
                                      offset: Offset(0, 3), //(x,y)
                                      blurRadius: 6.0,
                                      spreadRadius: 1.0 
                                    )
                                  ]
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
                              color: Theme.of(context).iconTheme.color.withOpacity(0.7)
                            ),
                            onPressed: () => AudioService.skipToNext(),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20)
                  ],
                ],
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
          Stream.periodic(Duration(milliseconds: 200)),
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
                    activeColor: Theme.of(context).accentColor,
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
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${duration.inMinutes}:${(duration.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                      style: TextStyle(
                        fontFamily: "Varela",
                        fontSize: 12,
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