import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PlayerSlider extends StatelessWidget {
  final PlaybackState state;
  final MediaItem mediaItem;
  final Color sliderColor;
  final Color textColor;
  PlayerSlider({
    @required this.state,
    @required this.mediaItem,
    @required this.sliderColor,
    @required this.textColor
  });
  final BehaviorSubject<double> _dragPositionSubject =
    BehaviorSubject.seeded(null);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Rx.combineLatest2<double, double, double>(
          _dragPositionSubject.stream,
          Stream.periodic(Duration(milliseconds: 1000)),
          (dragPosition, _) => dragPosition),
      builder: (context, snapshot) {
        Duration position = state?.currentPosition ?? Duration.zero;
        Duration duration = mediaItem?.duration ?? Duration(seconds: 1);
        return duration != null
          ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
                    valueIndicatorTextStyle: TextStyle(
                      color: sliderColor,
                    ),
                    trackHeight: 2,
                  ),
                  child: Slider(
                    activeColor: sliderColor.withOpacity(0.7),
                    inactiveColor: Colors.black12.withOpacity(0.1),
                    min: 0.0,
                    max: duration.inMilliseconds?.toDouble(),
                    value: max(0.0, min(
                      position.inMilliseconds.toDouble(),
                      duration.inMilliseconds?.toDouble()
                    )),
                    onChanged: (value) {
                      _dragPositionSubject.add(value);
                    },
                    onChangeEnd: (value) {
                      AudioService.seekTo(Duration(milliseconds: value.toInt()));
                      _dragPositionSubject.add(null);
                    },
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${position.inMinutes}:${(position.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                      style: TextStyle(
                        fontFamily: "YTSans",
                        fontSize: 12,
                        color: textColor.withOpacity(0.6)
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${duration.inMinutes}:${(duration.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                      style: TextStyle(
                        fontFamily: "YTSans",
                        fontSize: 12,
                        color: textColor.withOpacity(0.6)
                      ),
                    )
                  ],
                ),
              )
            ],
          )
          : Container();
      },
    );
  }
}