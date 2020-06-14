// Flutter
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal
import 'package:songtube/provider/player_provider.dart';

// Packages
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

class PlayerWidget extends StatefulWidget {
  final PlayerState playerState;
  final Function onPlayPauseTap;
  final Function onPlayPauseLongPress;
  final bool showPlayPause;
  final EdgeInsetsGeometry padding;
  final Icon leadingIcon;
  final Function leadingAction;
  PlayerWidget({
    @required this.playerState,
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
              icon: widget.playerState == PlayerState.playing
              ? Icon(MdiIcons.pause, color: Colors.white)
              : Icon(MdiIcons.play, color: Colors.white),
              onPressed: widget.onPlayPauseTap,
            ),
          )
          : Container()
        ),
      ],
    );
  }
}

class FullPlayerWidget extends StatefulWidget {
  @override
  _FullPlayerWidgetState createState() => _FullPlayerWidgetState();
}

class _FullPlayerWidgetState extends State<FullPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    Player playerProvider = Provider.of<Player>(context);
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () => playerProvider.showMediaPlayer = false,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent
          ),
        ),
        Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                    image: NetworkImage(playerProvider.queue[playerProvider.queueIndex].coverUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              StreamBuilder(
                stream: playerProvider.audioPlayer.onDurationChanged,
                builder: (context, snapshot) {
                  Duration audioDuration = snapshot.data;
                  return StreamBuilder<Object>(
                    stream: playerProvider.audioPlayer.onAudioPositionChanged,
                    builder: (context, snapshot) {
                      Duration data = snapshot.data;
                      double currentPosition;
                      data != null
                        ? currentPosition = data.inMilliseconds / audioDuration.inMilliseconds
                        : currentPosition = 0;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
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
                                value: currentPosition,
                                onChanged: (value) async {
                                  Duration _position = Duration(
                                    milliseconds: (value * await playerProvider.audioPlayer.getDuration()).round());
                                  playerProvider.audioPlayer.seek(_position);
                                },
                              ),
                            ),
                          ),
                          if (data != null || audioDuration != null)
                          Padding(
                            padding: EdgeInsets.only(left: 24, right: 24),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "${data.inMinutes}:${(data.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                                  style: TextStyle(
                                    fontFamily: "Varela",
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${audioDuration.inMinutes}:${(audioDuration.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                                  style: TextStyle(
                                    fontFamily: "Varela",
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }
                  );
                }
              ),
              Column(
                children: <Widget>[
                  // Title
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      playerProvider.queue[playerProvider.queueIndex].title,
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
                    playerProvider.queue[playerProvider.queueIndex].author,
                    style: TextStyle(color: Theme.of(context).iconTheme.color, fontFamily: "Varela")
                  ),
                ],
              ),
              // Music Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Previous button
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color),
                    onPressed: () => playerProvider.playPrevious(),
                  ),
                  // Padding
                  SizedBox(width: 30),
                  // Play/Pause button
                  GestureDetector(
                    onTap: playerProvider.playerState == PlayerState.paused
                      ? () => playerProvider.play()
                      : () => playerProvider.pause(),
                    child: Container(
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
                      child: playerProvider.playerState == PlayerState.paused
                        ? Icon(Icons.play_arrow, size: 50, color: Colors.white)
                        : Icon(Icons.pause, size: 50, color: Colors.white),
                    ),
                  ),
                  // Padding
                  SizedBox(width: 30),
                  // Next button
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Theme.of(context).iconTheme.color),
                    onPressed: () => playerProvider.playNext(),
                  )
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 12),
                child: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => playerProvider.showMediaPlayer = false,
                ),
              )
            ],
          )
        ),
      ],
    );
  }
}