// Flutter
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(30)
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
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () => playerProvider.showMediaPlayer = false,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 300,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          fadeOutDuration: Duration(milliseconds: 300),
                          fadeInDuration: Duration(milliseconds: 300),
                          placeholder: MemoryImage(kTransparentImage),
                          image: NetworkImage(playerProvider.queue[playerProvider.queueIndex].coverUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // Music Controls
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // Previous button
                                    IconButton(
                                      icon: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            left: 1.0,
                                            top: 2.0,
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.grey[800].withOpacity(0.5)
                                            ),
                                          ),
                                          Icon(Icons.arrow_back_ios, color: Colors.white),
                                        ],
                                      ),
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
                                          color: Colors.grey[800].withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(40)
                                        ),
                                        child: playerProvider.playerState == PlayerState.paused
                                          ? Icon(Icons.play_arrow, size: 50)
                                          : Icon(Icons.pause, size: 50)
                                      ),
                                    ),
                                    // Padding
                                    SizedBox(width: 30),
                                    // Next button
                                    IconButton(
                                      icon: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            left: 1.0,
                                            top: 2.0,
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.grey[800].withOpacity(0.5)
                                            ),
                                          ),
                                          Icon(Icons.arrow_forward_ios, color: Colors.white),
                                        ],
                                      ),
                                      onPressed: () => playerProvider.playNext(),
                                    )
                                  ],
                                ),
                                // Slider
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
                                        return SliderTheme(
                                          data: SliderTheme.of(context).copyWith(
                                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                                            overlayColor: Theme.of(context).accentColor.withOpacity(0.25),
                                            overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
                                            valueIndicatorTextStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: Slider(
                                            activeColor: Colors.white,
                                            inactiveColor: Theme.of(context).canvasColor.withOpacity(0.4),
                                            value: currentPosition,
                                            onChanged: (value) async {
                                              Duration _position = Duration(
                                                milliseconds: (value * await playerProvider.audioPlayer.getDuration()).round());
                                              playerProvider.audioPlayer.seek(_position);
                                            },
                                          ),
                                        );
                                      }
                                    );
                                  }
                                ),
                                // Title
                                Padding(
                                  padding: const EdgeInsets.only(left: 8, right: 8),
                                  child: Text(
                                    playerProvider.queue[playerProvider.queueIndex].title,
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // Artist
                                Text(
                                  playerProvider.queue[playerProvider.queueIndex].author,
                                  style: TextStyle(color: Colors.grey[300])
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}