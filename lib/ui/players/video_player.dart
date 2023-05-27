import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pip/flutter_pip.dart';
import 'package:flutter_pip/models/pip_ratio.dart';
import 'package:flutter_pip/platform_channel/channel.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:songtube/internal/models/content_wrapper.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/ui/players/video_player/collapsed.dart';
import 'package:songtube/ui/players/video_player/expanded.dart';
import 'package:songtube/ui/players/video_player/player_widget.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> with TickerProviderStateMixin {
  
  // Content Provider
  ContentProvider get contentProvider => Provider.of(context);

  // UiProvider
  UiProvider get uiProvider => Provider.of(context);

  // Current Content
  ContentWrapper get content => contentProvider.playingContent!;

  // Aspect Ratio of video
  double get aspectRatio => (contentProvider.playingContent?.videoPlayerController.videoPlayerController?.value.aspectRatio != null
    ? contentProvider.playingContent?.videoPlayerController.videoPlayerController?.value.aspectRatio ?? 16/9
    : 16/9).clamp(1, 16/9);

  // State Key for video player
  final playerKey = const GlobalObjectKey<State>('videoPlayerKey');

  // Function to enter PiP mode
  void enterPipMode() {
    final size = Provider.of<ContentProvider>(context, listen: false).playingContent?.videoPlayerController.videoPlayerController?.value.size;
    FlutterPip.enterPictureInPictureMode(pipRatio: size != null ? PipRatio(width: size.width.round(), height: size.height.round()) : null);
  }

  // Fullscreen status
  bool fullscreenEnabled = false;

  @override
  Widget build(BuildContext context) {
    ContentProvider contentProvider = Provider.of(context);
    // Player Widget
    final player = VideoPlayerWidget(
      key: playerKey,
      content: content,
      onAspectRatioUpdate: (aspectRatio) {
        setState(() {
          
        });
      },
      onFullscreen: () {
        setState(() {
          fullscreenEnabled = !fullscreenEnabled;
        });
      },
      onOpenChapters: () {
        contentProvider.showDescription = true;
      },
    );

    // Portrait UI
    Widget portrait() {
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
        SystemUiOverlay.bottom,
        SystemUiOverlay.top,
      ]);
      ScreenBrightness().resetScreenBrightness();
      return PipWidget(
        onSuspending: () {
          if (AppSettings.enableAutoPictureInPictureMode && !AppSettings.enableBackgroundPlayback && Provider.of<UiProvider>(context, listen: false).fwController.isPanelOpen) {
            enterPipMode();
          }
        },
        pictureInPictureChild: player,
        child: AnimatedBuilder(
          animation: uiProvider.fwController.animationController,
          builder: (context, child) {
            return SizedBox(
              height: Tween<double>(begin: kToolbarHeight * 1.6, end: (MediaQuery.of(context).size.height)-38-kToolbarHeight-(kToolbarHeight*0.7)).animate(uiProvider.fwController.animationController).value,
              child: child!,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
              ),
              boxShadow: uiProvider.fwController.lockNotificationListener
                ? [BoxShadow(
                    blurRadius: 12,
                    offset: const Offset(0,0),
                    color: Theme.of(context).shadowColor.withOpacity(0.2)
                  )]
                : null,
            ),
            child: GestureDetector(
              onTap: () {
                if (uiProvider.fwController.animationController.value == 0) {
                  uiProvider.fwController.animationController
                    .animateTo(1, curve: Curves.fastLinearToSlowEaseIn, duration: const Duration(seconds: 1));
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Artwork Carousel
                      AnimatedBuilder( 
                        animation: uiProvider.fwController.animationController,
                        builder: (context, child) {
                          return Builder(
                            builder: (context) {
                              const initialHeight = kToolbarHeight * 1.3;
                              final initialWidth = initialHeight*aspectRatio;
                              final finalWidth =  MediaQuery.of(context).size.width-24;
                              final finalHeight = finalWidth/aspectRatio;
                              return AnimatedSize(
                                duration: const Duration(milliseconds: 150),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 11.5, right: 8).copyWith(
                                    top: Tween<double>(begin: 9, end: MediaQuery.of(context).padding.top).animate(uiProvider.fwController.animationController).value,
                                    bottom: Tween<double>(begin: 6, end: 0).animate(uiProvider.fwController.animationController).value
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                  constraints: BoxConstraintsTween(
                                    begin: BoxConstraints.tightFor(width: initialWidth, height: initialHeight),
                                    end: BoxConstraints.tightFor(width: finalWidth, height: finalHeight))
                                      .evaluate(uiProvider.fwController.animationController),
                                  child: child
                                ),
                              );
                            }
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: player
                        )
                      ),
                      // Song Title and Artist
                      Expanded(
                        child: AnimatedBuilder(
                          animation: uiProvider.fwController.animationController,
                          builder: (context, child) {
                            return Opacity(
                              opacity: (1 - (2 * uiProvider.fwController.animationController.value)) > 0
                                ? (1 - (2 * uiProvider.fwController.animationController.value)) : 0,
                              child: child
                            );
                          },
                          child: VideoPlayerCollapsed(content: content)
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: AnimatedBuilder(
                      animation: uiProvider.fwController.animationController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: (uiProvider.fwController.animationController.value - (1 - uiProvider.fwController.animationController.value)) > 0
                            ? (uiProvider.fwController.animationController.value - (1 - uiProvider.fwController.animationController.value)) : 0,
                          child: Transform.translate(
                            offset: Offset(0, Tween<double>(begin: 180, end: 0).animate(uiProvider.fwController.animationController).value),
                            child: child)
                        );
                      },
                      child: VideoPlayerExpanded(content: content)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Fullscreen UI
    Widget fullscreen() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      return player;
    }

    return Material(
      color: Colors.transparent,
      child: fullscreenEnabled
        ? fullscreen()
        : portrait(),
    );

  }
}