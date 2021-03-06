import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newpipeextractor_dart/models/streams/videoStream.dart';
import 'package:rxdart/rxdart.dart';
import 'package:songtube/players/components/videoPlayer/controls.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class StreamManifestPlayer extends StatefulWidget {
  final VideoStream stream;
  final Function onVideoEnded;
  final Function onFullscreenTap;
  final bool isFullscreen;
  StreamManifestPlayer({
    Key key,
    @required this.stream,
    this.onVideoEnded,
    this.onFullscreenTap,
    this.isFullscreen
  }) : super(key: key);
  @override
  StreamManifestPlayerState createState() => StreamManifestPlayerState();
}

class StreamManifestPlayerState extends State<StreamManifestPlayer> {

  // Player Variables (width is set automatically)
  bool hideControls = false;
  bool videoEnded = false;

  // Reverse and Forward Animation
  bool showReverse = false;
  bool showForward = false;

  // ignore: close_sinks
  final BehaviorSubject<double> _dragPositionSubject =
    BehaviorSubject.seeded(null);

  // Player Controller
  VideoPlayerController _controller;
  VideoPlayerController get controller => _controller;

  @override
  void initState() {
    super.initState();
    Wakelock.toggle(on: true);
    Future.delayed(Duration(seconds: 2), () {
      setState(() => hideControls = true);
    });
    _controller = VideoPlayerController.network(
      widget.stream.url
    )..initialize().then((value) {
      _controller.play().then((_) {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    Wakelock.toggle(on: false);
    if (_controller != null)
      _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.isFullscreen) {
          await SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          await SystemChrome.setEnabledSystemUIOverlays
            ([SystemUiOverlay.top, SystemUiOverlay.bottom]);
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Video Player
            Container(
              child: _controller.value.initialized
                ? VideoPlayer(_controller)
                : Container(color: Colors.black),
            ),
            // Video PlayBack Controls & Progress Bar
            GestureDetector(
              onTap: () => setState(() => hideControls = !hideControls),
              child: VideoPlayerControls(
                progressBar: _controller?.value?.duration?.inMinutes != null
                  ? videoPlayerProgressBar() : Container(),
                videoTitle: null,
                playing: _controller.value.isPlaying,
                onPlayPause: _controller.value.isPlaying
                  ? () {
                      _controller.pause();
                      setState(() {});
                      Future.delayed(Duration(seconds: 2), () {
                        setState(() => hideControls = true);
                      });
                    }
                  : () {
                      _controller.play();
                      setState(() {});
                      Future.delayed(Duration(seconds: 2), () {
                        setState(() => hideControls = true);
                      });
                    },
                onExit: () => Navigator.pop(context),
                showControls: hideControls,
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => setState(() => hideControls = !hideControls),
                    onDoubleTap: () {
                      if (_controller.value.initialized) {
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
                ),
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => setState(() => hideControls = !hideControls),
                    onDoubleTap: () {
                      if (_controller.value.initialized) {
                        _controller.seekTo(_controller.value.position + Duration(seconds: 10));
                        setState(() => showForward = true);
                        Future.delayed(Duration(milliseconds: 250), ()
                          => setState(() => showForward = false));
                      }
                    },
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
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget videoPlayerProgressBar() {
    return StreamBuilder(
      stream: Rx.combineLatest2<double, double, double>(
        _dragPositionSubject.stream,
        Stream.periodic(Duration(milliseconds: 1000)),
        (dragPosition, _) => dragPosition),
      builder: (context, snapshot) {
        if (_controller.value.duration == _controller.value.position && !videoEnded) {
          videoEnded = true;
          widget.onVideoEnded();
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: Text(
                "${_controller.value.position.inMinutes.toString().padLeft(2, '0')}:" +
                "${_controller.value.position.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white
                ),
              ),
            ),
            Expanded(
              child: VideoProgressIndicator(
                _controller,
                allowScrubbing: true,
                padding: EdgeInsets.zero,
                colors: VideoProgressColors(
                  playedColor: Theme.of(context).accentColor,
                  bufferedColor: Colors.white.withOpacity(0.6),
                  backgroundColor: Colors.white.withOpacity(0.4)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "${_controller.value.duration.inMinutes.toString().padLeft(2, '0')}:" +
                "${_controller.value.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white
                ),
              ),
            ),
            IconButton(
              icon: Icon(widget.isFullscreen
                ? Icons.fullscreen_exit_rounded
                : Icons.fullscreen_rounded,
                color: Colors.white
              ),
              onPressed: widget.onFullscreenTap
            )
          ],
        );
      },
    );
  }
}