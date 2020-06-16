// Dart
import 'dart:math';
import 'dart:ui';
import 'package:rxdart/rxdart.dart';

// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/internal/player_service.dart';
import 'package:songtube/provider/downloads_manager.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

class ExpandPlayer extends StatelessWidget {
  final Function onTap;
  final Widget icon;
  ExpandPlayer({
    @required this.onTap,
    @required this.icon
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
            color: Colors.redAccent
          ),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: Row(
              children: <Widget>[
                SizedBox(width: 8),
                icon,
                SizedBox(width: 4),
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

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - kToolbarHeight*1.5 - kBottomNavigationBarHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 0.0), //(x,y)
            blurRadius: 10.0,
            spreadRadius: 5.0
          ),
        ],
      ),
    child: StreamBuilder<ScreenState>(
      stream: manager.screenStateStream,
        builder: (context, snapshot) {
          final screenState = snapshot.data;
          final mediaItem = screenState?.mediaItem;
          final state = screenState?.playbackState;
          final processingState =
              state?.processingState ?? AudioProcessingState.none;
          final playing = state?.playing ?? false;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (processingState == AudioProcessingState.none) ...[
                Text("No audio in Queue")
              ] else ...[
                Container(
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
                      image: NetworkImage(mediaItem.artUri),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                positionIndicator(mediaItem, state),
                Column(
                  children: <Widget>[
                    // Title
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Previous button
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color),
                      onPressed: () => AudioService.skipToNext(),
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
                          color: Colors.redAccent,
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
                          ? Icon(Icons.pause, size: 35, color: Colors.white)
                          : Icon(Icons.play_arrow, size: 35, color: Colors.white),
                      ),
                    ),
                    // Padding
                    SizedBox(width: 30),
                    // Next button
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, color: Theme.of(context).iconTheme.color),
                      onPressed: () => AudioService.skipToNext(),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 12),
                  child: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => manager.showMediaPlayer = false,
                  ),
                )
              ],
            ],
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
        Duration position = snapshot.data ?? state.currentPosition;
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
                      color: Colors.redAccent,
                    ),
                  ),
                  child: Slider(
                    activeColor: Colors.redAccent,
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
                      // Due to a delay in platform channel communication, there is
                      // a brief moment after releasing the Slider thumb before the
                      // new position is broadcast from the platform side. This
                      // hack is to hold onto seekPos until the next state update
                      // comes through.
                      // TODO: Improve this code.
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