import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:audio_service/audio_service.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_screen/flutter_screen.dart';
import 'package:songtube/internal/globals.dart';
import 'package:songtube/players/components/youtubePlayer/player/playPauseButton.dart';
import 'package:songtube/players/components/youtubePlayer/player/playerAppBar.dart';
import 'package:songtube/players/components/youtubePlayer/player/playerProgressBar.dart';
import 'package:songtube/players/service/playerService.dart';
import 'package:songtube/players/service/screenStateStream.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';
import 'package:volume/volume.dart';

class StreamManifestPlayer extends StatefulWidget {
  final String videoTitle;
  final List<dynamic> streams;
  final AudioOnlyStream audioStream;
  final Function onAutoPlay;
  final Function onFullscreenTap;
  final bool isFullscreen;
  final Function onEnterPipMode;
  final double borderRadius;
  final bool forceHideControls;
  final String quality;
  final Function(String) onQualityChanged;
  final List<StreamSegment> segments;
  final Function(double) onAspectRatioInit;
  final String videoThumbnail;
  final Duration duration;
  StreamManifestPlayer({
    Key key,
    @required this.videoTitle,
    @required this.streams,
    @required this.audioStream,
    this.onAutoPlay,
    this.onFullscreenTap,
    this.isFullscreen,
    this.onEnterPipMode,
    this.borderRadius,
    this.forceHideControls = false,
    @required this.quality,
    @required this.onQualityChanged,
    this.segments = const [],
    this.onAspectRatioInit,
    @required this.videoThumbnail,
    @required this.duration,
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
  bool isSeeking = false;
  String currentQuality;

  // Reverse and Forward Animation
  bool showReverse = false;
  bool showForward = false;

  // Current Aspect Ratio
  double aspectRatio;

  // UI
  bool _showControls   = true;
  bool get showControls {
    if (audioOnly) {
      return true;
    } else {
      return _showControls;
    }
  }
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
  bool get showBackdrop {
    if (audioOnly) {
      return true;
    } else {
      return _showBackdrop;
    }
  }
  set showBackdrop(bool value) {
    if (value == false) {
      _showBackdrop = false;
    } else {
      if (!widget.forceHideControls) {
        _showBackdrop = true;
      }
    }
  }

  // Show quality menu
  bool showStreamQualityMenu = false;

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

  // Audio Only On/Off
  bool _audioOnly = globalPrefs.getBool('videoPlayerAudioOnly') ?? false;
  bool get audioOnly => _audioOnly;
  set audioOnly(bool value) {
    _audioOnly = value;
    globalPrefs.setBool('videoPlayerAudioOnly', value);
    if (value) {
      setupAudioPlayer();
    } else {
      setupVideoPlayer();
    }
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    isPlaying = false;
    currentQuality = widget.quality;
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
    if (audioOnly) {
      setupAudioPlayer();
    } else {
      setupVideoPlayer();
    }
  }

  void setupVideoPlayer() async {
    int indexToPlay = widget.streams.indexWhere((element)
      => element.resolution.contains(widget.quality));
    if (indexToPlay == -1) {
      indexToPlay = 0;
      currentQuality = widget.streams[indexToPlay].resolution.split("p").first;
    }
    _controller = VideoPlayerController.network(
      videoDataSource: widget.streams[indexToPlay].url,
      audioDataSource: widget.streams[indexToPlay]
        is VideoOnlyStream ? widget.audioStream.url : null,
      formatHint: VideoFormat.other
    )..initialize().then((value) {
      if (Provider.of<PreferencesProvider>(context, listen: false).videoPageAutoPlay) {
        _controller.play().then((_) {
          Duration position;
          if (AudioService.running) {
            if (AudioService.currentMediaItem?.id == widget.audioStream.url) {
              if (AudioService.playbackState.position != null) {
                position = AudioService.playbackState.currentPosition;
              }
            }
          }
          if (position != null) {
            _controller.seekTo(position).then((_) {
              AudioService.stop();
            });
          }
          setState(() {isPlaying = true; buffering = false;});
          setState(() { showControls = false; showBackdrop = false; });
        });
      } else {
        setState(() {isPlaying = false; buffering = false;});
      }
      if (aspectRatio != controller?.value?.aspectRatio ?? null) {
        widget.onAspectRatioInit(controller?.value?.aspectRatio ?? 16/9);
        setState(() =>
          aspectRatio = controller?.value?.aspectRatio ?? null);
      }
    });
    _controller.addListener(() {
      if (_controller.value.isBuffering && buffering == false) {
        setState(() => buffering = true);
      }
      if (!_controller.value.isBuffering && buffering == true) {
        setState(() => buffering = false);
      }
    });
    Future.delayed(Duration(seconds: 10), () {
      _controller.addListener(() {
        int currentPosition = _controller?.value?.position?.inSeconds ?? null;
        int totalDuration = _controller?.value?.duration?.inSeconds ?? null;
        bool autoPlayEnabled = Provider.of<PreferencesProvider>(context, listen : false).youtubeAutoPlay;
        if (currentPosition == totalDuration && currentPosition != null && totalDuration != null && autoPlayEnabled) {
          if (!videoEnded) {
            videoEnded = true;
            Future.delayed((Duration(seconds: 2)),
              () => widget.onAutoPlay());
          }
        }
      });
    });
  }

  void setupAudioPlayer() async {
    if (!AudioService.running) {
      await AudioService.start(
        backgroundTaskEntrypoint: songtubePlayer,
        androidNotificationChannelName: 'SongTube',
        // Enable this if you want the Android service to exit the foreground state on pause.
        //androidStopForegroundOnPause: true,
        androidNotificationColor: 0xFF2196f3,
        androidNotificationIcon: 'drawable/ic_stat_music_note',
        androidEnableQueue: true,
      );
    }
    final mediaItem = MediaItem(
      id: widget.audioStream.url,
      album: 'YouTube',
      title: widget.videoTitle,
      artUri: Uri.parse(widget.videoThumbnail),
      duration: widget.duration,
      artist: 'YouTube',
    );
    await AudioService.updateQueue([mediaItem]);
    if (_controller != null) {
      Duration position;
      position = _controller.value.position;
      await AudioService.playMediaItem(mediaItem);
      await AudioService.seekTo(position);
      _controller.pause();
      _controller.removeListener(() { });
      _controller.dispose();
    } else {
      await AudioService.playMediaItem(mediaItem);
    }
    setState(() {
      buffering = false;
      isPlaying = true;
    });
    runListener();
  }

  void runListener() async {
    AudioService.playbackStateStream.listen((event) {
      if (event.processingState == AudioProcessingState.completed) {
        widget.onAutoPlay();
      }
    });
  }

  void handleSeek(Duration position) {
    if (audioOnly) {
      AudioService.seekTo(position);
    } else {
      controller.seekTo(position);
    }
  }

  Duration get currentPosition => audioOnly
    ? AudioService.playbackState.currentPosition
    : _controller.value.position;

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
      if (controller?.value?.isPlaying ?? false) {
        Future.delayed(Duration(seconds: 5), () {
          if (currentId == tapId && mounted && showControls == true && !isSeeking) {
            setState(() {
              showControls = false;
              showBackdrop = false;
            });
          }
        });
      }
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
        child: audioOnly
          ? _audioPlayer()
          : _videoPlayer()
      ),
    );
  }

  Widget _videoPlayer() {
    return Stack(
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
        // Player Controls and Gestures
        AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: showStreamQualityMenu 
            ? _playbackQualityOverlay()
            : _playbackControlsOverlay()
        )
      ],
    );
  }

  Widget _audioPlayer() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Video Beign Played
        FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: widget.videoThumbnail == null
            ? AssetImage('assets/images/artworkPlaceholder_big.png')
            : NetworkImage(widget.videoThumbnail)
        ),
        // Player Controls and Gestures
        GestureDetector(
          onTap: () => showControlsHandler(),
          child: Container(
            color: Colors.transparent,
            child: _playbackControlsOverlay()))
      ],
    );
  }

  // Full UI for playback controls and gestures
  Widget _playbackControlsOverlay() {
    return Stack(
      children: [
        // Player Gestures Detector
        Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: () => showControlsHandler(),
                onDoubleTap: () {
                  if ((_controller?.value?.isInitialized ?? false) || audioOnly) {
                    Duration seekNewPosition;
                    if (currentPosition < Duration(seconds: 10)) {
                      seekNewPosition = Duration.zero;
                    } else {
                      seekNewPosition = currentPosition - Duration(seconds: 10);
                    }
                    handleSeek(seekNewPosition);
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
                  if ((_controller?.value?.isInitialized ?? false) || audioOnly) {
                    handleSeek(currentPosition + Duration(seconds: 10));
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
        // Player Fast Forward/Backward Animation
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
        // Player controls UI
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
                    audioOnly: audioOnly,
                    currentQuality: currentQuality,
                    videoTitle: widget.videoTitle,
                    streams: widget.streams,
                    onChangeQuality: () {
                      setState(() => showStreamQualityMenu = true);
                    },
                    onEnterPipMode: widget.onEnterPipMode,
                  ),
                ),
                // Play/Pause Buttons
                PlayPauseButton(
                  isPlaying: isPlaying,
                  onPlayPause: () async {
                    if (audioOnly) {
                      if (AudioService.playbackState.playing) {
                        AudioService.pause();
                        isPlaying = false;
                      } else {
                        AudioService.play();
                        isPlaying = true;
                      }
                    } else {
                      if (controller.value.isPlaying) {
                        await controller.pause();
                        isPlaying = false;
                      } else {
                        await controller.play();
                        isPlaying = true;
                      }
                    }
                    setState(() {});
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Builder(
                    builder: (context) {
                      if (audioOnly) {
                        return StreamBuilder<Object>(
                          stream: Rx.combineLatest2<double, double, double>(
                            _dragPositionSubject.stream,
                            Stream.periodic(Duration(milliseconds: 1000)),
                            (dragPosition, _) => dragPosition),
                          builder: (context, snapshot) {
                            return PlayerProgressBar(
                              onAudioOnlySwitch: () {
                                audioOnly = !audioOnly;
                              },
                              audioOnly: audioOnly,
                              segments: widget.segments,
                              position: AudioService.playbackState.currentPosition,
                              duration: widget.duration,
                              onSeek: (double newPosition) {
                                handleSeek(Duration(seconds: newPosition.round()));
                                setState(() => isSeeking = false);
                              },
                              onFullScreenTap: widget.onFullscreenTap,
                              onSeekStart: () {
                                setState(() => isSeeking = true);
                              },
                            );
                          }
                        );
                      } else {
                        return StreamBuilder<Object>(
                          stream: Rx.combineLatest2<double, double, double>(
                            _dragPositionSubject.stream,
                            Stream.periodic(Duration(milliseconds: 1000)),
                            (dragPosition, _) => dragPosition),
                          builder: (context, snapshot) {
                            return PlayerProgressBar(
                              onAudioOnlySwitch: () {
                                audioOnly = !audioOnly;
                              },
                              audioOnly: audioOnly,
                              segments: widget.segments,
                              position: controller.value.position,
                              duration: controller == null
                                ? Duration(seconds: 2)
                                : controller.value.duration,
                              onSeek: (double newPosition) {
                                handleSeek(Duration(seconds: newPosition.round()));
                                setState(() => isSeeking = false);
                              },
                              onFullScreenTap: widget.onFullscreenTap,
                              onSeekStart: () {
                                setState(() => isSeeking = true);
                              },
                            );
                          }
                        );
                      }
                    }
                  ),
                )
              ],
            ),
          ) : Container()
        ),
        // Player buffering indicator
        Center(
          child: buffering
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 2)
            : Container()
        )
      ],
    );
  }

  Widget _playbackQualityOverlay() {
    List<String> qualities = [];
    widget.streams.forEach((stream) {
      if (stream.formatSuffix.contains('webm'))
        qualities.add(stream.formatSuffix + " • " + stream.resolution);
    });
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black.withOpacity(0.3),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.3)
              ]
            )
          ),
        ),
        ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: 40),
          itemCount: qualities.length,
          itemBuilder: (context, index) {
            String quality = qualities[index];
            return GestureDetector(
              onTap: () {
                int index = widget.streams.indexWhere((element) =>
                  element.formatSuffix + " • " + element.resolution == quality);
                _controller.setVideoUrl(widget.streams[index].url);
                widget.onQualityChanged(quality.split("p").first);
                setState(() => currentQuality = quality);
                setState(() => showStreamQualityMenu = false);
                showControlsHandler();
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(12),
                child: Text(
                  "${quality.split("•").last.trim().split("p").first+"p"}"
                  "${quality.split("p").last.contains("60") ? " • 60 FPS" : ""}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Product Sans',
                    fontSize: 22,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            );
          }
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () => setState(() =>
              showStreamQualityMenu = false),
            icon: Icon(Icons.arrow_back_rounded,
              color: Colors.white)
          ),
        ),
      ],
    );
  }

}