import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_fade/image_fade.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/content_wrapper.dart';
import 'package:songtube/internal/models/playback_quality.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/ui/animations/animated_text.dart';
import 'package:songtube/ui/components/shimmer_container.dart';
import 'package:songtube/ui/players/video_player/pages/quality_selection.dart';
import 'package:songtube/ui/players/video_player/player_ui/play_pause_button.dart';
import 'package:songtube/ui/players/video_player/player_ui/player_app_bar.dart';
import 'package:songtube/ui/players/video_player/player_ui/player_progress_bar.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/ui_utils.dart';
import 'package:video_player/video_player.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:wakelock/wakelock.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    required this.content,
    required this.onAspectRatioUpdate,
    required this.onFullscreen,
    required this.onOpenChapters,
    super.key});
  final ContentWrapper content;
  final Function(double) onAspectRatioUpdate;
  final Function() onFullscreen;
  final Function() onOpenChapters;
  @override
  State<VideoPlayerWidget> createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {

  VideoPlayerController? controller;
  // Player Variables (width is set automatically)
  bool finishedPlaying = false;
  bool isPlaying = false;
  bool hideControls = true;
  bool videoEnded = false;
  bool buffering = true;
  bool isSeeking = false;
  bool showVolumeUI     = false;
  bool showBrightnessUI = false;
  String? currentVolumePercentage;
  String? currentBrightnessPercentage;
  VideoPlaybackQuality? currentQuality;
  bool lockPlayer = true;
  bool interfaceLocked = false;
  bool audioOnly = false;

  // Reverse and Forward Animation
  bool showReverse = false;
  bool showForward = false;

  Timer? overlayDismissTimer;

  YoutubeVideo? _youtubeVideo;
  YoutubeVideo? get youtubeVideo => _youtubeVideo;
  set youtubeVideo(YoutubeVideo? video) {
    if (video == null) {
      _youtubeVideo = null;
      finishedPlaying = false;
      showAutoplay = false;
      controller?.removeListener(() { });
      controller?.dispose().then((value) {
        setState(() {
          controller = null;
        });
      });
    } else {
      if (youtubeVideo != video) {
        _youtubeVideo = video;
        finishedPlaying = false;
        currentQuality = null;
        loadVideo();
      }
    }
  }

  Duration? get currentPosition => controller?.value.position;

  void handleSeek(Duration position) {
    Future.delayed(const Duration(seconds: 1), () {
      finishedPlaying = false;
    });
    controller?.seekTo(position);
  }

  // ignore: close_sinks
  final BehaviorSubject<double> _dragPositionSubject =
    BehaviorSubject.seeded(0);

  // UI
  bool _showControls   = true;
  bool get showControls {
    return _showControls;
  }
  set showControls(bool value) {
    setState(() {
      _showControls = value;
    });
  }
  bool _showBackdrop   = true;
  bool get showBackdrop {
    return _showBackdrop;
  }
  set showBackdrop(bool value) {
    setState(() {
      _showBackdrop = value;
    });
  }

  void showControlsHandler() {
    if (!showControls) {
      setState(() {
        showControls = true;
        showBackdrop = true;
      });
      if ((controller?.value.isPlaying ?? false) && !interfaceLocked) {
        Future.delayed(const Duration(seconds: 5), () {
          if (interfaceLocked) {
            return;
          }
          if (!(controller?.value.isPlaying ?? true)) {
            return;
          }
          if (mounted && showControls == true && !isSeeking) {
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

  Future<void> handleVolumeGesture(double primaryDelta) async {
    double sensitivity = 1 / 15;
    bool isDraggingUp = primaryDelta < 0;

    double currentVolume = await VolumeController().getVolume();

    // volume is maximum or minimum
    if ((currentVolume >= 1 && isDraggingUp) ||
        (currentVolume <= 0 && !isDraggingUp) ||
        primaryDelta == 0) {
      setState(() {
        showControls = false;
        showVolumeUI = true;
        showBackdrop = true;
        showBrightnessUI = false;
      });
      return;
    }

    double newVolume = isDraggingUp
        ? currentVolume + sensitivity
        : currentVolume - sensitivity;
    currentVolumePercentage = "${(newVolume * 100).round()}";
    VolumeController().setVolume(newVolume, showSystemUI: false);

    if (showVolumeUI) {
      setState(() {});
    } else {
      setState(() {
        showControls     = false;
        showVolumeUI     = true;
        showBackdrop     = true;
        showBrightnessUI = false;
      });
    }

    rescheduleOverlayHideTimer();
  }

  void handleBrightnessGesture(double primaryDelta) async {
    double sensitivity = 0.01;
    bool isDraggingUp = primaryDelta < 0;

    double currentBrightness = await ScreenBrightness().current;

    // brightness is maximum or minimum
    if ((currentBrightness >= 0.99 && isDraggingUp) ||
        (currentBrightness <= 0.01 && !isDraggingUp) ||
        primaryDelta == 0) {
      setState(() {
        showControls = false;
        showVolumeUI = false;
        showBackdrop = true;
        showBrightnessUI = true;
      });
      return;
    }

    double newBrightness = isDraggingUp
        ? currentBrightness + sensitivity
        : currentBrightness - sensitivity;
    currentBrightnessPercentage = "${(newBrightness * 100).round()}";
    ScreenBrightness().setScreenBrightness(newBrightness);

    if (showBrightnessUI) {
      setState(() {});
    } else {
      setState(() {
        showControls = false;
        showVolumeUI = false;
        showBackdrop = true;
        showBrightnessUI = true;
      });
    }

    rescheduleOverlayHideTimer();
  }

  void rescheduleOverlayHideTimer() {
    overlayDismissTimer?.cancel();
    overlayDismissTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showControls = false;
          showVolumeUI = false;
          showBackdrop = false;
          showBrightnessUI = false;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    youtubeVideo = widget.content.videoDetails;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    Wakelock.enable();
    super.initState();
  }

  void loadVideo({Duration? position}) async {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => hideControls = true);
    });
    finishedPlaying = false;
    showAutoplay = false;
    lockPlayer = true;
    if (controller != null) {
      controller!.removeListener(() { });
    }
    // Choose video quality
    currentQuality ??= widget.content.videoOptions!.firstWhere((element) => element.resolution.contains(AppSettings.lastVideoQuality), orElse: () {
      return widget.content.videoOptions!.last;
    });
    if (currentQuality!.resolution == 'Audio Only') {
      audioOnly = true;
    } else {
      audioOnly = false;
    }
    setState(() {});
    controller = VideoPlayerController.network(
      videoDataSource: currentQuality!.videoUrl,
      audioDataSource: currentQuality!.audioUrl
    );
    controller?.initialize().then((_) async {
      if (position != null) {
        await controller?.seekTo(position);
      }
      await controller?.play();
      lockPlayer = false;
      setState(() {isPlaying = true; buffering = false;});
      setState(() { showControls = false; showBackdrop = false; });
      widget.onAspectRatioUpdate(controller?.value.aspectRatio ?? 16/9);
    });
    controller?.addListener(() {
      // Playing Chjeck
      if (controller?.value.isPlaying != isPlaying) {
        setState(() {
          isPlaying = controller?.value.isPlaying ?? false;
        });
      }
      // Buffering Checks
      if ((controller?.value.isBuffering ?? false) && buffering == false) {
        setState(() => buffering = true);
      }
      if (!(controller?.value.isBuffering ?? false) && buffering == true) {
        setState(() => buffering = false);
      }
      // AutoPlay Logic
      if (!lockPlayer) {
        final autoplayCondition = controller != null && controller?.value.position.inSeconds == controller?.value.duration.inSeconds;
        if (autoplayCondition) {
          if (!finishedPlaying) {
            finishedPlaying = true;
            controller?.pause();
            setState(() {
              showAutoplay = true;
            });
            runAutoplay();
          }
        }
      }

    });
  }

  // Autoplay Details
  bool showAutoplay = false;
  int autoplayDelay = 10;
  int autoplayCurrent = 10;

  // Autoplay Logic
  void runAutoplay() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (showAutoplay == false) {
        timer.cancel();
        autoplayCurrent = autoplayDelay;
        return;
      }
      setState(() {
        autoplayCurrent -= 1;
      });
      if (autoplayCurrent == 0) {
        timer.cancel();
        autoplayCurrent = autoplayDelay;
        playNext();
      }
    });
  }

  // Load next video in provider
  void playNext() {
    final contentProvider = Provider.of<ContentProvider>(context, listen: false);
    if (widget.content.infoItem is StreamInfoItem) {
      contentProvider.loadVideoPlayer(
        contentProvider.playingContent!.videoSuggestionsController.relatedStreams?.first,
        previousUrl: contentProvider.playingContent?.infoItem.url);
    } else {
      contentProvider.loadNextPlaylistVideo();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.content.videoPlayerController._addState(this);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        color: Colors.black,
        child: controller != null
          ? _videoPlayer()
          : _thumbnail(),
      ),
    );
  }

  Widget _videoPlayer() {
    UiProvider uiProvider = Provider.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSwitcher(
          duration: kAnimationDuration,
          child: audioOnly ? _thumbnail() : AspectRatio(
            aspectRatio: controller?.value.aspectRatio ?? 16/9,
            child: VideoPlayer(controller!)),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: showAutoplay
            ? autoplayOverlay()
            : AnimatedBuilder(
                animation: uiProvider.fwController.animationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: (uiProvider.fwController.animationController.value - (1 - uiProvider.fwController.animationController.value)) > 0
                      ? (uiProvider.fwController.animationController.value - (1 - uiProvider.fwController.animationController.value)) : 0,
                    child: child,
                  );
                },
                child: audioOnly ? _audioOnlyOverlay() : _playbackControlsOverlay(),
              ),
        )
      ],
    );
  }

  Widget _audioOnlyOverlay() {
    return Column(
      children: [
        // Play/Pause Button
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: !buffering ? VideoPlayerPlayPauseButton(
              isPlaying: isPlaying,
              onPlayPause: () async {
                if (controller?.value.isPlaying ?? false) {
                  await controller?.pause();
                  isPlaying = false;
                } else {
                  await controller?.play();
                  isPlaying = true;
                  showControlsHandler();
                }
                setState(() {});
              },
            ) : const SizedBox(),
          ),
        ),
        // Progress Indicator
        Container(
          height: kToolbarHeight+16,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black.withOpacity(0.2), Colors.black.withOpacity(0.4), Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp
            ),
          ),
          child: _progressBar(),
        )
      ],
    );
  }

  Widget _thumbnail() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: audioOnly ? 1 : 0.6,
          child: ImageFade(
            fadeDuration: const Duration(milliseconds: 300),
            placeholder: const ShimmerContainer(height: null, width: null),
            fit: BoxFit.cover,
            image: NetworkImage(widget.content.videoDetails?.videoInfo.thumbnailUrl ?? '')),
        ),
        if (!audioOnly)
        Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          ),
        ),
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
                onTap: showControlsHandler,
                onDoubleTap: () {
                  if (controller?.value.isInitialized ?? false) {
                    Duration seekNewPosition;
                    if ((currentPosition ?? const Duration(seconds: 0)) < const Duration(seconds: 10)) {
                      seekNewPosition = Duration.zero;
                    } else {
                      seekNewPosition = (currentPosition ?? const Duration(seconds: 0)) - const Duration(seconds: 10);
                    }
                    handleSeek(seekNewPosition);
                    setState(() => showReverse = true);
                    Future.delayed(const Duration(milliseconds: 500), ()
                      => setState(() => showReverse = false));
                  }
                },
                onVerticalDragUpdate: MediaQuery.of(context).orientation == Orientation.landscape
                  ? (update) { handleBrightnessGesture(update.primaryDelta ?? 0); } : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: kAnimationCurve,
                  width: double.infinity,
                  height: double.infinity,
                  color: !showBackdrop
                    ? Colors.transparent
                    : Theme.of(context).cardColor.withOpacity(0.8),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 300),
                      child: showBrightnessUI
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(EvaIcons.sun,
                              color: Colors.white,
                              size: 32),
                            const SizedBox(width: 12),
                            Text(
                              "$currentBrightnessPercentage%",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 36,
                                letterSpacing: 0.2,
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
                onTap: showControlsHandler,
                onDoubleTap: () {
                  if (controller?.value.isInitialized ?? false) {
                    handleSeek((currentPosition ?? const Duration(seconds: 0)) + const Duration(seconds: 10));
                    setState(() => showForward = true);
                    Future.delayed(const Duration(milliseconds: 500), ()
                      => setState(() => showForward = false));
                  }
                },
                onVerticalDragUpdate: MediaQuery.of(context).orientation == Orientation.landscape
                  ? (update) { handleVolumeGesture(update.primaryDelta ?? 0); } : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: kAnimationCurve,
                  width: double.infinity,
                  height: double.infinity,
                  color: !showBackdrop
                    ? Colors.transparent
                    : Theme.of(context).cardColor.withOpacity(0.8),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 300),
                      child: showVolumeUI
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(EvaIcons.volumeUp,
                              color: Colors.white,
                              size: 32),
                            const SizedBox(width: 12),
                            Text(
                              "$currentVolumePercentage%",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 36,
                                letterSpacing: 0.2,
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
                  margin: const EdgeInsets.all(50),
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: showReverse
                      ? const Icon(Icons.replay_10_rounded,
                          color: Colors.white,
                          size: 40)
                      : Container()
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(50),
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: showForward
                      ? const Icon(Icons.forward_10_rounded,
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
          duration: const Duration(milliseconds: 200),
          child: showControls ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Player AppBar
                Align(
                  alignment: Alignment.topLeft,
                  child: VideoPlayerAppBar(
                    interfaceLocked: interfaceLocked,
                    videoTitle: widget.content.videoDetails?.videoInfo.name ?? '',
                    onMinimize: () {
                      Provider.of<UiProvider>(context, listen: false).fwController.close();
                    },
                    onLockInterface: () {
                      setState(() {
                        interfaceLocked = !interfaceLocked;
                        if (!interfaceLocked) {
                          showControlsHandler();
                        }
                      });
                    },
                  ),
                ),
                // Play/Pause Buttons
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: !buffering ? VideoPlayerPlayPauseButton(
                    isPlaying: isPlaying,
                    onPlayPause: () async {
                      if (controller?.value.isPlaying ?? false) {
                        await controller?.pause();
                        isPlaying = false;
                      } else {
                        await controller?.play();
                        isPlaying = true;
                        showControlsHandler();
                      }
                      setState(() {});
                    },
                  ) : const SizedBox(),
                ),
                _progressBar()
              ],
            ),
          ) : Container()
        ),
        // Player buffering indicator
        Center(
          child: buffering
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 2)
            : Container()
        )
      ],
    );
  }

  Widget _progressBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Builder(
        builder: (context) {
          return StreamBuilder<Object>(
            stream: Rx.combineLatest2<double, double, double>(
              _dragPositionSubject.stream,
              Stream.periodic(const Duration(milliseconds: 1000), ((computationCount) {
                return computationCount.toDouble();
              })),
              (dragPosition, _) => dragPosition),
            builder: (context, snapshot) {
              return VideoPlayerProgressBar(
                onPresetTap: () {
                  UiUtils.showModal(
                    context: internalNavigatorKey.currentContext!,
                    modal: PlaybackQualitySheet(
                      content: widget.content,
                      currentPlaybackSpeed: controller?.value.playbackSpeed ?? 1.00,
                      onPlaybackSpeedChange: (speed) {
                        controller?.setPlaybackSpeed(speed);
                      },
                      currentQuality: currentQuality!,
                      onChangeQuality: (quality) async {
                        final position = controller?.value.position;
                        controller?.removeListener(() { });
                        await controller?.dispose();
                        AppSettings.lastVideoQuality = quality.resolution;
                        setState(() { controller = null; currentQuality = quality; });
                        loadVideo(position: position);
                  }));
                },
                audioOnly: false,
                segments: widget.content.videoDetails?.segments,
                onShowSegments: () {
                  widget.onOpenChapters();
                },
                position: controller?.value.position ?? const Duration(seconds: 0),
                duration: controller?.value.duration ?? const Duration(seconds: 1),
                onSeek: (double newPosition) {
                  handleSeek(Duration(seconds: newPosition.round()));
                  setState(() => isSeeking = false);
                },
                onFullScreenTap: () {
                  widget.onFullscreen();
                },
                onSeekStart: () {
                  setState(() => isSeeking = true);
                },
              );
            }
          );
        }
      ),
    );
  }

  Widget autoplayOverlay() {
    ContentProvider contentProvider = Provider.of(context);
    final nextStream = contentProvider.playingContent!.infoItem is PlaylistInfoItem
      ? contentProvider.nextPlaylistVideo
      : contentProvider.playingContent!.videoSuggestionsController.relatedStreams?.first;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: Theme.of(context).cardColor.withOpacity(0.9)),
        if (nextStream != null)
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Next Video Details
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: AspectRatio(
                          aspectRatio: 16/9,
                          child: Image.network(
                            nextStream is StreamInfoItem
                              ? nextStream.thumbnails!.hqdefault
                              : (nextStream as PlaylistInfoItem).thumbnailUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedText('${Languages.of(context)!.labelPlayingNextIn} $autoplayCurrent', style: subtitleTextStyle(context, bold: true), auto: true),
                        Text('${nextStream.name}', style: smallTextStyle(context).copyWith(), maxLines: 2),
                        Text('by ${nextStream.uploaderName}', style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12), maxLines: 1),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              // Cancel or Play Now Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Cancel
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showAutoplay = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 6, bottom: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: AnimatedText(Languages.of(context)!.labelCancel, style: subtitleTextStyle(context, bold: true), auto: false),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Play Now
                  GestureDetector(
                    onTap: () {
                      playNext();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 6, bottom: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: AnimatedText(Languages.of(context)!.labelPlayNow, style: subtitleTextStyle(context, bold: true), auto: true),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

}

class VideoPlayerWidgetController {

  VideoPlayerWidgetState? _videoPlayerWidgetState;

  void _addState(VideoPlayerWidgetState state) {
    _videoPlayerWidgetState = state;
  }

  // Get the VideoPlayer Controller
  VideoPlayerController? get videoPlayerController => _videoPlayerWidgetState?.controller;

}