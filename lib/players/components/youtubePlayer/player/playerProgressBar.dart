import 'package:flutter/material.dart';

class PlayerProgressBar extends StatelessWidget {
  final Duration position;
  final Duration duration;
  final Function(double) onSeek;
  final Function onFullScreenTap;
  PlayerProgressBar({
    @required this.position,
    @required this.duration,
    @required this.onSeek,
    this.onFullScreenTap
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(width: 8),
          Text(
            "${position.inMinutes.toString().padLeft(2, '0')}:"+
            "${position.inSeconds.remainder(60).toString().padLeft(2, '0')}",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w600,
              fontSize: 10
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 10,
              child: SliderTheme(
                data: SliderThemeData(
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
                  thumbColor: Theme.of(context).accentColor,
                  inactiveTrackColor: Colors.white.withOpacity(0.2),
                  activeTrackColor: Theme.of(context).accentColor,
                  trackHeight: 1
                ),
                child: Slider(
                  value: position.inSeconds.toDouble(),
                  onChanged: (newPosition) => onSeek(newPosition),
                  max: duration.inSeconds.toDouble(),
                ),
              ),
            ),
          ),
          Text(
            "${duration.inMinutes.toString().padLeft(2, '0')}:"+
            "${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w600,
              fontSize: 10
            ),
          ),
          SizedBox(width: 16),
          GestureDetector(
            onTap: onFullScreenTap,
            child: Container(
              color: Colors.transparent,
              child: Icon(
                MediaQuery.of(context).orientation == Orientation.portrait
                  ? Icons.fullscreen_outlined : Icons.fullscreen_exit_outlined,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}