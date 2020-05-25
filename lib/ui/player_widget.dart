// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/player_provider.dart';

// Packages
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PlayerWidget extends StatelessWidget {
  final PlayerState playerState;
  final Function onPlayPauseTap;
  final Function onPlayPauseLongPress;
  final EdgeInsetsGeometry padding;
  PlayerWidget({
    @required this.playerState,
    @required this.onPlayPauseTap,
    @required this.onPlayPauseLongPress,
    this.padding
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // Play/Pause song
        GestureDetector(
          onLongPress: onPlayPauseLongPress,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(30)
            ),
            child: IconButton(
              icon: playerState == PlayerState.playing
              ? Icon(MdiIcons.pause, color: Colors.white)
              : Icon(MdiIcons.play, color: Colors.white),
              onPressed: onPlayPauseTap,
            ),
          ),
        ),
      ],
    );
  }
}