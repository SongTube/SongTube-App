// Dart
import 'dart:math';
import 'dart:ui';
import 'package:rxdart/rxdart.dart';

// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/internal/player_service.dart';

// Packages
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:audio_service/audio_service.dart';

class PlayerWidget extends StatefulWidget {
  final Function onPlayPauseTap;
  final Function onPlayPauseLongPress;
  final bool showPlayPause;
  final EdgeInsetsGeometry padding;
  final Icon leadingIcon;
  final Function leadingAction;
  PlayerWidget({
    @required this.onPlayPauseTap,
    @required this.onPlayPauseLongPress,
    @required this.showPlayPause,
    this.padding,
    @required this.leadingIcon,
    @required this.leadingAction
  });

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // Expand Less/More Icon
        Container(
          width: 40,
          height: 40,
          color: Colors.transparent,
          child: IconButton(
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: widget.leadingIcon
            ),
            onPressed: widget.leadingAction
          ),
        ),
        // Padding
        SizedBox(width: 10),
        // Play/Pause song
        AnimatedSize(
          duration: Duration(milliseconds: 150),
          vsync: this,
          child: widget.showPlayPause
          ? Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  offset: Offset(0, 3), //(x,y)
                  blurRadius: 6.0,
                  spreadRadius: 0.05 
                )
              ]
            ),
            child: IconButton(
              icon: Icon(MdiIcons.pause, color: Colors.white),
              onPressed: widget.onPlayPauseTap,
            ),
          )
          : Container()
        ),
      ],
    );
  }
}

class FullPlayerWidget extends StatelessWidget {
  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<ScreenState>(
        stream: _screenStateStream,
        builder: (context, snapshot) {
          final screenState = snapshot.data;
          final queue = screenState?.queue;
          final mediaItem = screenState?.mediaItem;
          final state = screenState?.playbackState;
          final processingState =
              state?.processingState ?? AudioProcessingState.none;
          final playing = state?.playing ?? false;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (processingState == AudioProcessingState.none) ...[
                audioPlayerButton(),
              ] else ...[
                if (queue != null && queue.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.skip_previous),
                        iconSize: 64.0,
                        onPressed: mediaItem == queue.first
                            ? null
                            : AudioService.skipToPrevious,
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_next),
                        iconSize: 64.0,
                        onPressed: mediaItem == queue.last
                            ? null
                            : AudioService.skipToNext,
                      ),
                    ],
                  ),
                if (mediaItem?.title != null) Text(mediaItem.title),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (playing) pauseButton() else playButton(),
                    stopButton(),
                  ],
                ),
                positionIndicator(mediaItem, state),
                Text("Processing state: " +
                    "$processingState".replaceAll(RegExp(r'^.*\.'), '')),
                StreamBuilder(
                  stream: AudioService.customEventStream,
                  builder: (context, snapshot) {
                    return Text("custom event: ${snapshot.data}");
                  },
                ),
                StreamBuilder<bool>(
                  stream: AudioService.notificationClickEventStream,
                  builder: (context, snapshot) {
                    return Text(
                      'Notification Click Status: ${snapshot.data}',
                    );
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  /// Encapsulate all the different data we're interested in into a single
  /// stream so we don't have to nest StreamBuilders.
  Stream<ScreenState> get _screenStateStream =>
      Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState, ScreenState>(
          AudioService.queueStream,
          AudioService.currentMediaItemStream,
          AudioService.playbackStateStream,
          (queue, mediaItem, playbackState) =>
              ScreenState(queue, mediaItem, playbackState));

  RaisedButton audioPlayerButton() => startButton(
        'AudioPlayer',
        () {
          AudioService.start(
            backgroundTaskEntrypoint: audioPlayerTaskEntrypoint,
            androidNotificationChannelName: 'SongTube',
            // Enable this if you want the Android service to exit the foreground state on pause.
            //androidStopForegroundOnPause: true,
            androidNotificationColor: 0xFF2196f3,
            androidNotificationIcon: 'mipmap/ic_stat_music_note',
            androidEnableQueue: true,
          );
        },
      );

  RaisedButton startButton(String label, VoidCallback onPressed) =>
      RaisedButton(
        child: Text(label),
        onPressed: onPressed,
      );

  IconButton playButton() => IconButton(
        icon: Icon(Icons.play_arrow),
        iconSize: 64.0,
        onPressed: AudioService.play,
      );

  IconButton pauseButton() => IconButton(
        icon: Icon(Icons.pause),
        iconSize: 64.0,
        onPressed: AudioService.pause,
      );

  IconButton stopButton() => IconButton(
        icon: Icon(Icons.stop),
        iconSize: 64.0,
        onPressed: AudioService.stop,
      );

  Widget positionIndicator(MediaItem mediaItem, PlaybackState state) {
    double seekPos;
    return StreamBuilder(
      stream: Rx.combineLatest2<double, double, double>(
          _dragPositionSubject.stream,
          Stream.periodic(Duration(milliseconds: 200)),
          (dragPosition, _) => dragPosition),
      builder: (context, snapshot) {
        double position =
            snapshot.data ?? state.currentPosition.inMilliseconds.toDouble();
        double duration = mediaItem?.duration?.inMilliseconds?.toDouble();
        return Column(
          children: [
            if (duration != null)
              Slider(
                min: 0.0,
                max: duration,
                value: seekPos ?? max(0.0, min(position, duration)),
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
              ),
            Text("${state.currentPosition}"),
          ],
        );
      },
    );
  }
}