// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen/flutter_screen.dart';

// Internal
import 'package:songtube/internal/models/videoFile.dart';

// Packages
import 'package:songtube/players/components/videoPlayer/controls.dart';
import 'package:songtube/players/components/videoPlayer/progressBar.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  final VideoFile video;
  AppVideoPlayer(
    this.video,
  );
  @override
  _AppVideoPlayerState createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {

  // Video Player Controller
  VideoPlayerController _controller;

  // Player Variables (width is set automatically)
  double width;
  bool isLandscape;
  bool hideControls = false;

  // Position Controller
  StreamController<Duration> positionController =
    new StreamController<Duration>.broadcast();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(
        video: File(widget.video.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        if (_controller.value.duration < Duration(seconds: 15)) {
          _controller.setLooping(true);
        }
        // Check if we need to rotate the screen or not
        if (_controller.value.aspectRatio <= 1) {
          isLandscape = false;
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitDown,
            DeviceOrientation.portraitUp,
          ]);
        } else {
          isLandscape = true;
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
        }
        // Prevent the screen of beign turned off automatically
        FlutterScreen.keepOn(true);
        setState(() {
          _controller.play();
        });
        // Update current Playback Position
        updater();
      }, onError: (_) async {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              title: Text(
                "Not Supported",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
              content: Text(
                "This video is not natively supported by your device",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Theme.of(context).accentColor
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
        Navigator.pop(context);
      });
    Future.delayed(Duration(seconds: 2), () {
      setState(() => hideControls = true);
    });
  }

  // Update Playback Position each second, once the
  // playback position is equal to the total video
  // duration, show Thankyou Image
  void updater() async {
    while (true) {
      if (!mounted) break;
      await Future.delayed(Duration(seconds: 1), () {
        try {
          if (!positionController.isClosed && mounted) {
            positionController.add(_controller.value.position);
          }
        } catch (_) {}
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    positionController.close();
    _controller.dispose();
    // Show Top, Bottom system Bars and rotate screen
    // to portrait on VideoPlayer dispose
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    FlutterScreen.keepOn(false);
  }

  @override
  Widget build(BuildContext context) {
    // Hide Top and Bottom system Bars
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Video Player
            Container(
              child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
            ),
            // Video PlayBack Controls & Progress Bar
            GestureDetector(
              onTap: () => setState(() => hideControls = !hideControls),
              child: VideoPlayerControls(
                progressBar: videoPlayerProgressBar(),
                videoTitle: widget.video.name,
                playing: _controller.value.isPlaying,
                onPlayPause: _controller.value.isPlaying
                  ? () => setState(() => _controller.pause())
                  : () => setState(() => _controller.play()),
                onExit: () => Navigator.pop(context),
                showControls: hideControls,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget videoPlayerProgressBar() {
    return VideoPlayerProgressBar(
      controller: _controller,
      position: positionController.stream,
    );
  }
}