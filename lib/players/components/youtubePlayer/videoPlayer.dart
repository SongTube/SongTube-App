import 'dart:math';
import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/streams/audioOnlyStream.dart';
import 'package:newpipeextractor_dart/models/streams/videoOnlyStream.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_screen/flutter_screen.dart';
import 'package:songtube/players/components/youtubePlayer/player/playPauseButton.dart';
import 'package:songtube/players/components/youtubePlayer/player/playerAppBar.dart';
import 'package:songtube/players/components/youtubePlayer/player/playerProgressBar.dart';
import 'package:video_player/video_player.dart';
import 'package:volume/volume.dart';

class StreamManifestPlayer extends StatefulWidget {
  final String videoTitle;
  final List<VideoOnlyStream> streams;
  final AudioOnlyStream audioStream;
  final Function onVideoEnded;
  final Function onFullscreenTap;
  final bool isFullscreen;
  final Function onEnterPipMode;
  final double borderRadius;
  final bool forceHideControls;
  StreamManifestPlayer({
    Key key,
    @required this.videoTitle,
    @required this.streams,
    @required this.audioStream,
    this.onVideoEnded,
    this.onFullscreenTap,
    this.isFullscreen,
    this.onEnterPipMode,
    this.borderRadius,
    this.forceHideControls = false
  }) : super(key: key);
  @override
  StreamManifestPlayerState createState() => StreamManifestPlayerState();
}

class StreamManifestPlayerState extends State<StreamManifestPlayer> {

  // Player Variables (width is set automatically)
  bool isPlaying;
  bool hideControls = false;
  bool videoEnded = false;
  bool buffering = true;

  // Reverse and Forward Animation
  bool showReverse = false;
  bool showForward = false;

  // UI
  bool _showControls   = true;
  bool get showControls => _showControls;
  set showControls(bool value) {
    if (value == false) {
      _showControls = false;
    } else {
      if (!widget.forceHideControls) {
        _showControls = true;
      }
    }
  }
  bool _showBackdrop   = true;
  bool get showBackdrop => _showBackdrop;
  set showBackdrop(bool value) {
    if (value == false) {
      _showBackdrop = false;
    } else {
      if (!widget.forceHideControls) {
        _showBackdrop = true;
      }
    }
  }

  String currentVolumePercentage;
  String currentBrightnessPercentage;

  // Gestures
  bool showVolumeUI     = false;
  bool showBrightnessUI = false;
  int tapId = 0;

  // ignore: close_sinks
  final BehaviorSubject<double> _dragPositionSubject =
    BehaviorSubject.seeded(null);

  // Player Controller
  VideoPlayerController _controller;
  VideoPlayerController get controller => _controller;

  @override
  void initState() {
    super.initState();
    isPlaying = false;
    Volume.controlVolume(AudioManager.STREAM_MUSIC).then((value) async {
      currentVolumePercentage =
        "${(((await Volume.getVol)/(await Volume.getMaxVol)) * 100).round()}";
    });
    FlutterScreen.brightness.then((value) {
      currentBrightnessPercentage =
        "${((value/1) * 100).round()}";
    });
    FlutterScreen.keepOn(true);
    Future.delayed(Duration(seconds: 2), () {
      setState(() => hideControls = true);
    });
    List<String> playerStreamsUrls = [];
    widget.streams.forEach((element) {
      playerStreamsUrls.add(element.url);
    });
    int indexToPlay = widget.streams.indexWhere((element)
      => element.resolution.contains("720"));
    if (indexToPlay == -1)
      indexToPlay = 0;
    _controller = VideoPlayerController.network(
      widget.streams[indexToPlay].url, audioDataSource: widget.audioStream.url,
      formatHint: VideoFormat.other
    )..initialize().then((value) {
      _controller.play().then((_) {
        setState(() {isPlaying = true; buffering = false;});
      });
    });
    _controller.addListener(() {
      if (_controller.value.isBuffering && buffering == false) {
        setState(() => buffering = true);
        setState(() { showControls = true; showBackdrop = true; });
      }
      if (!_controller.value.isBuffering && buffering == true) {
        setState(() => buffering = false);
        setState(() { showControls = false; showBackdrop = false; });
      }
    });
    Future.delayed(Duration(seconds: 10), () {
      _controller.addListener(() {
        int currentPosition = _controller?.value?.position?.inSeconds ?? null;
        int totalDuration = _controller?.value?.duration?.inSeconds ?? null;
        if (currentPosition == totalDuration && currentPosition != null && totalDuration != null) {
          if (!videoEnded) {
            videoEnded = true;
            Future.delayed((Duration(seconds: 2)),
              () => widget.onVideoEnded());
          }
        }
      });
    });
  }

  @override
  void dispose() {
    FlutterScreen.keepOn(false);
    if (_controller != null)
      _controller.dispose();
    super.dispose();
  }

  Future<void> handleVolumeGesture(double primaryDelta) async {
    tapId = Random().nextInt(10);
    int currentId = tapId;
    int maxVolume = await Volume.getMaxVol;
    int currentVolume = await Volume.getVol;
    int newVolume = (currentVolume +
      primaryDelta * 0.2 *
      (-1)).round();
    currentVolumePercentage = newVolume > maxVolume
      ? "100" : newVolume < 0 ? "0" : "${((newVolume/maxVolume) * 100).round()}";
    setState(() {});
    Volume.setVol(newVolume > maxVolume ? maxVolume : newVolume,
      showVolumeUI: ShowVolumeUI.HIDE);
    if (!showVolumeUI) {
      setState(() {
        showControls     = false;
        showVolumeUI     = true;
        showBackdrop     = true;
        showBrightnessUI = false;
      });
    }
    Future.delayed(Duration(seconds: 3), () {
      if (currentId == tapId && mounted) {
        setState(() {
          showControls     = false;
          showVolumeUI     = false;
          showBackdrop     = false;
          showBrightnessUI = false;
        });
      }
    });
  }

  void handleBrightnessGesture(double primaryDelta) async {
    tapId = Random().nextInt(10);
    int currentId = tapId;
    double currentBrightness = await FlutterScreen.brightness;
    double newBrightness =
      currentBrightness + ((primaryDelta*-1)*0.01);
    currentBrightnessPercentage = newBrightness > 1 ? "100" :
      newBrightness < 0 ? "0" : "${((newBrightness/1)*100).round()}";
    setState(() {});
    FlutterScreen.setBrightness(
      newBrightness > 1 ? 1 : newBrightness < 0 ? 0 : newBrightness
    );
    if (!showVolumeUI) {
      setState(() {
        showControls     = false;
        showVolumeUI     = false;
        showBackdrop     = true;
        showBrightnessUI = true;
      });
    }
    Future.delayed(Duration(seconds: 3), () {
      if (currentId == tapId && mounted) {
        setState(() {
          showControls     = false;
          showVolumeUI     = false;
          showBackdrop     = false;
          showBrightnessUI = false;
        });
      }
    });
  }

  void showControlsHandler() {
    if (!showControls) {
      tapId = Random().nextInt(10);
      int currentId = tapId;
      setState(() {
        showControls = true;
        showBackdrop = true;
      });
      Future.delayed(Duration(seconds: 5), () {
        if (currentId == tapId && mounted && showControls == true) {
          setState(() {
            showControls = false;
            showBackdrop = false;
          });
        }
      });
    } else {
      setState(() {
        showControls = false;
        showBackdrop = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Material(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Video Beign Played
            Container(
              child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller?.value?.aspectRatio ?? 16/9,
                    child: VideoPlayer(_controller)
                  )
                : Container(color: Colors.black),
            ),
            // Show/Hide Controls & Expand Player Gesture Detector
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => showControlsHandler(),
                    onDoubleTap: () {
                      if (_controller.value.isInitialized) {
                        Duration seekNewPosition;
                        if (_controller.value.position < Duration(seconds: 10)) {
                          seekNewPosition = Duration.zero;
                        } else {
                          seekNewPosition = _controller.value.position - Duration(seconds: 10);
                        }
                        _controller.seekTo(seekNewPosition);
                        setState(() => showReverse = true);
                        Future.delayed(Duration(milliseconds: 250), ()
                          => setState(() => showReverse = false));
                      }
                    },
                    onVerticalDragUpdate: MediaQuery.of(context).orientation == Orientation.landscape
                      ? (update) {
                          handleBrightnessGesture(update.primaryDelta);
                        }
                      : null,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      width: double.infinity,
                      height: double.infinity,
                      color: !showBackdrop
                        ? Colors.transparent
                        : Colors.black.withOpacity(0.3),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 250),
                          reverseDuration: Duration(milliseconds: 500),
                          child: showBrightnessUI
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(EvaIcons.sun,
                                  color: Colors.white,
                                  size: 32),
                                SizedBox(width: 12),
                                Text(
                                  "$currentBrightnessPercentage%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    letterSpacing: 0.2,
                                    fontFamily: 'Product Sans',
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ],
                            )
                            : Container()
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => showControlsHandler(),
                    onDoubleTap: () {
                      if (_controller.value.isInitialized) {
                        _controller.seekTo(_controller.value.position + Duration(seconds: 10));
                        setState(() => showForward = true);
                        Future.delayed(Duration(milliseconds: 250), ()
                          => setState(() => showForward = false));
                      }
                    },
                    onVerticalDragUpdate: MediaQuery.of(context).orientation == Orientation.landscape
                      ? (update) {
                          handleVolumeGesture(update.primaryDelta);
                        }
                      : null,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      width: double.infinity,
                      height: double.infinity,
                      color: !showBackdrop
                        ? Colors.transparent
                        : Colors.black.withOpacity(0.3),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 250),
                          reverseDuration: Duration(milliseconds: 500),
                          child: showVolumeUI
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(EvaIcons.volumeUp,
                                  color: Colors.white,
                                  size: 32),
                                SizedBox(width: 12),
                                Text(
                                  "$currentVolumePercentage%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    letterSpacing: 0.2,
                                    fontFamily: 'Product Sans',
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ],
                            )
                            : Container()
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            IgnorePointer(
              ignoring: true,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(50),
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 250),
                        child: showReverse
                          ? Icon(Icons.replay_10_outlined,
                              color: Colors.white,
                              size: 40)
                          : Container()
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(50),
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 250),
                        child: showForward
                          ? Icon(Icons.forward_10_outlined,
                              color: Colors.white,
                              size: 40)
                          : Container()
                      ),
                    ),
                  )
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              child: showControls ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Player AppBar
                    Align(
                      alignment: Alignment.topLeft,
                      child: PlayerAppBar(
                        videoTitle: widget.videoTitle,
                        streams: widget.streams,
                        onStreamSelect: (String url) {
                          _controller.changeVideoUrl(url);
                        },
                        onEnterPipMode: widget.onEnterPipMode,
                      ),
                    ),
                    // Play/Pause Buttons
                    PlayPauseButton(
                      isBuffering: buffering,
                      isPlaying: isPlaying,
                      onPlayPause: () async {
                        if (controller.value.isPlaying) {
                          await controller.pause();
                          isPlaying = false;
                        } else {
                          await controller.play();
                          isPlaying = true;
                        }
                        setState(() {});
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: StreamBuilder<Object>(
                        stream: Rx.combineLatest2<double, double, double>(
                          _dragPositionSubject.stream,
                          Stream.periodic(Duration(milliseconds: 1000)),
                          (dragPosition, _) => dragPosition),
                        builder: (context, snapshot) {
                          return PlayerProgressBar(
                            position: controller.value.position,
                            duration: controller == null
                              ? Duration(seconds: 2)
                              : controller.value.duration,
                            onSeek: (double newPosition) {
                              controller.seekTo(Duration(seconds: newPosition.round()));
                            },
                            onFullScreenTap: widget.onFullscreenTap,
                          );
                        }
                      ),
                    )
                  ],
                ),
              ) : Container()
            ),
          ],
        ),
      ),
    );
  }
}