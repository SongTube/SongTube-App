import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:songtube/players/components/videoPlayer/controls.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class StreamManifestPlayer extends StatelessWidget {
  final StreamManifest manifest;
  final VideoPlayerController controller;
  final bool isFullScreen;
  final Function onVideoEnded;
  final BorderRadius borderRadius;
  StreamManifestPlayer({
    @required this.manifest,
    this.controller,
    this.isFullScreen = false,
    this.onVideoEnded,
    this.borderRadius
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 250),
      child: manifest != null
        ? ClipRRect(
            borderRadius: borderRadius == null
              ? BorderRadius.zero
              : borderRadius,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: _StreamManifestPlayer(
              manifest: manifest,
              isFullScreen: isFullScreen,
              controller: controller,
              onVideoEnded: onVideoEnded,
            ),
          )
        : Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).iconTheme.color
              ),
            ),
          ),
    );
  }
}

class _StreamManifestPlayer extends StatefulWidget {
  final StreamManifest manifest;
  final VideoPlayerController controller;
  final bool isFullScreen;
  final Function onVideoEnded;
  _StreamManifestPlayer({
    @required this.manifest,
    this.controller,
    this.isFullScreen = false,
    this.onVideoEnded,
  });
  @override
  __StreamManifestPlayerState createState() => __StreamManifestPlayerState();
}

class __StreamManifestPlayerState extends State<_StreamManifestPlayer> {

  // Video Player Controller
  VideoPlayerController _controller;

  // Player Variables (width is set automatically)
  bool hideControls = false;
  bool videoEnded = false;

  // ignore: close_sinks
  final BehaviorSubject<double> _dragPositionSubject =
    BehaviorSubject.seeded(null);

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
    _controller = VideoPlayerController.network(
        widget.manifest.muxed.withHighestBitrate().url.toString())
      ..initialize().then((_) async {
        // Prevent the screen of beign turned off automatically
        Wakelock.toggle(on: true);
        await _controller.play();
        setState(() {});
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
                "Playback Error",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
              content: Text(
                "Couldn't play the video, please restart the application or" +
                "your device and try again.",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
              actions: [
                FlatButton(
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
      });
    } else {
      _controller = widget.controller;
    }
    if (widget.isFullScreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
    Future.delayed(Duration(seconds: 2), () {
      setState(() => hideControls = true);
    });
  }

  @override
  void dispose() {
    if (!widget.isFullScreen) {
      _controller.dispose();
      Wakelock.toggle(on: false);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.isFullScreen) {
          await SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          await SystemChrome.setEnabledSystemUIOverlays
            ([SystemUiOverlay.top, SystemUiOverlay.bottom]);
        }
        return Future.value(true);
      },
      child: Material(
        color: Colors.black,
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
            // Video PlayBack Controls & Progress Bar
            GestureDetector(
              onTap: () => setState(() => hideControls = !hideControls),
              child: VideoPlayerControls(
                progressBar: Padding(
                  padding: EdgeInsets.only(left: 8,
                    bottom: widget.isFullScreen ? 8 : 0),
                  child: _controller?.value?.duration?.inMinutes != null
                    ? videoPlayerProgressBar() : Container()
                ),
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
            )
          ],
        ),
      ),
    );
  }

  Widget videoPlayerProgressBar() {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context, listen: false);
    return StreamBuilder(
      stream: Rx.combineLatest2<double, double, double>(
        _dragPositionSubject.stream,
        Stream.periodic(Duration(milliseconds: 1000)),
        (dragPosition, _) => dragPosition),
      builder: (context, snapshot) {
        if (_controller.value.duration == _controller.value.position && !videoEnded) {
          videoEnded = true;
          if (!widget.isFullScreen) {
            widget.onVideoEnded();
          } else {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
            SystemChrome.setEnabledSystemUIOverlays
              ([SystemUiOverlay.top, SystemUiOverlay.bottom]);
            Navigator.pop(context);
          }
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
                  bufferedColor: Colors.white,
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
            Padding(
              padding: widget.isFullScreen
                ? EdgeInsets.only(right: 16)
                : EdgeInsets.zero,
              child: IconButton(
                icon: Icon(widget.isFullScreen
                  ? Icons.fullscreen_exit_rounded
                  : Icons.fullscreen_rounded,
                  color: Colors.white
                ),
                onPressed: () async {
                  if (!widget.isFullScreen) {
                    Navigator.push(context,
                      BlurPageRoute(builder: (_) {
                        return StreamManifestPlayer(
                          manifest: widget.manifest,
                          controller: _controller,
                          isFullScreen: true,
                        );
                      }, blurStrength: prefs.enableBlurUI ? 20 : 0));
                  } else {
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                      DeviceOrientation.portraitDown,
                    ]);
                    SystemChrome.setEnabledSystemUIOverlays
                      ([SystemUiOverlay.top, SystemUiOverlay.bottom]);
                    Navigator.pop(context);
                  }
                }
              ),
            )
          ],
        );
      },
    );
  }
}