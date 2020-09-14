// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Internal
import 'package:songtube/internal/models/videoFile.dart';

// Packages
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

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

  // Show ThankYou
  bool showThankyou = false;

  // Position Controller
  StreamController<Duration> positionController =
    new StreamController<Duration>.broadcast();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(
        File(widget.video.path))
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
        Wakelock.toggle(on: true);
        setState(() {
          _controller.play();
        });
        // Update current Playback Position
        updater();
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
    Wakelock.toggle(on: false);
  }

  @override
  Widget build(BuildContext context) {
    // Hide Top and Bottom system Bars
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomPadding: false,
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Video Player
            Container(
              child: _controller.value.initialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
            ),
            // Video PlayBack Controls
            AnimatedOpacity(
              duration: Duration(milliseconds: 150),
              opacity: hideControls == true ? 0.0 : 1.0,
              child: _controller.value.initialized
              ? GestureDetector(
                  onTap: () {
                    if (hideControls == false) {
                      setState(() => hideControls = true);
                    } else if (hideControls == true) {
                      setState(() => hideControls = false);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.3),
                    child: Column(
                      children: <Widget>[
                        // Video Title & Author
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                                  child: Icon(EvaIcons.videoOutline, color: Theme.of(context).accentColor),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8, left: 8),
                                  child: Text(
                                    widget.video.name.replaceAll(".webm", '')
                                      .replaceAll(".mp4", '')
                                      .replaceAll(".avi", '')
                                      .replaceAll(".3gpp", '')
                                      .replaceAll(".flv", '')
                                      .replaceAll(".mkv", ''),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                                  setState(() {});
                                },
                                child: Ink(
                                  child: Icon(
                                    _controller.value.isPlaying
                                      ? MdiIcons.pause
                                      : MdiIcons.play,
                                    color: Colors.white,
                                    size: 42,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        // ProgressBar & Video Controls
                        Container(
                          margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              StreamBuilder<Duration>(
                                stream: positionController.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 16, right: 8, top: 4),
                                      child: Text(
                                        "${snapshot.data.inMinutes.toString().padLeft(2, '0')}:" +
                                        "${snapshot.data.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white
                                        ),
                                      )
                                    );
                                  } else {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 16, right: 8, top: 4),
                                      child: Text(
                                        "00:00",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white
                                        ),
                                      )
                                    );
                                  }
                                }
                              ),
                              Expanded(
                                child: VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  colors: VideoProgressColors(
                                    playedColor: Theme.of(context).accentColor,
                                    bufferedColor: Colors.grey[500].withOpacity(0.6),
                                    backgroundColor: Colors.grey[600].withOpacity(0.6)
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 16, top: 4),
                                child: Text(
                                  "${_controller.value.duration.inMinutes.toString().padLeft(2, '0')}:" +
                                  "${_controller.value.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white
                                  ),
                                )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container()
            )
          ],
        ),
      ),
    );
  }
}