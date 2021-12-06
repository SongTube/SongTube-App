import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/streamSegment.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class PlayerProgressBar extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final Function(double) onSeek;
  final Function onFullScreenTap;
  final List<StreamSegment> segments;
  final Function onSeekStart;
  final bool audioOnly;
  final Function() onAudioOnlySwitch;
  PlayerProgressBar({
    @required this.position,
    @required this.duration,
    @required this.onSeek,
    @required this.segments,
    @required this.audioOnly,
    @required this.onAudioOnlySwitch,
    this.onFullScreenTap,
    this.onSeekStart
  });

  @override
  _PlayerProgressBarState createState() => _PlayerProgressBarState();
}

class _PlayerProgressBarState extends State<PlayerProgressBar> with TickerProviderStateMixin {

  // Current label, modified if segmets are available
  String currentLabel;
  bool isDragging = false;

  StreamSegment currentSegment(double value) {
    int position = value.round();
    if (value < widget.segments[1].startTimeSeconds) {
      return widget.segments.first;
    } else if (value >= widget.segments.last.startTimeSeconds) {
      return widget.segments.last;
    } else {
      List<int> startTimes = List.generate(widget.segments.length, (index)
        => widget.segments[index].startTimeSeconds).toList();
      int closestStartTime = (startTimes.where((e) => e >= position).toList()..sort()).first;
      int nearIndex = (widget.segments.indexWhere((element) =>
        element.startTimeSeconds == closestStartTime))-1;
      return widget.segments[nearIndex];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16, left: 16, right: 16, bottom: 8
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(width: 8),
              Text(
                "${widget.position.inMinutes.toString().padLeft(2, '0')}:"+
                "${widget.position.inSeconds.remainder(60).toString().padLeft(2, '0')}",
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
                  child: FlutterSlider(
                    trackBar: FlutterSliderTrackBar(
                      inactiveTrackBar: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white.withOpacity(0.2)
                      ),
                      activeTrackBar: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).accentColor
                      ),
                    ),
                    tooltip: FlutterSliderTooltip(
                      boxStyle: FlutterSliderTooltipBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white
                        )
                      ),
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 12
                      ),
                      format: (value) {
                        int position = double.parse(value).round();
                        String positionString = "${Duration(seconds: position).inMinutes.toString().padLeft(2, '0')}:"+
                          "${Duration(seconds: position).inSeconds.remainder(60).toString().padLeft(2, '0')}";
                        return positionString;
                      },
                    ),
                    handler: FlutterSliderHandler(
                      child: ClipRRect(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      )
                    ),
                    values: [widget?.position?.inSeconds?.toDouble() ?? 0],
                    onDragCompleted: (_, newPosition, __) {
                      setState(() => isDragging = false);
                      double seekPosition = newPosition;
                      if (widget.segments != null && widget.segments.length >= 2) {
                        StreamSegment segment = currentSegment(newPosition);
                        if (segment.startTimeSeconds < newPosition) {
                          if (newPosition - segment.startTimeSeconds <= 10)
                            seekPosition = segment.startTimeSeconds.toDouble();
                        }
                        if (segment.startTimeSeconds >= newPosition) {
                          if (segment.startTimeSeconds - newPosition <= 10)
                            seekPosition = segment.startTimeSeconds.toDouble();
                        }
                      }
                      widget.onSeek(seekPosition);

                    },
                    max: widget.duration.inSeconds.toDouble() == 0
                      ? 1 : widget.duration.inSeconds.toDouble(),
                    min: 0,
                    onDragStarted: (handlerIndex, lowerValue, upperValue) {
                      widget.onSeekStart();
                      setState(() { isDragging = true; currentLabel = null; });
                    },
                    onDragging: (_, value, ___) {
                      if (widget.segments != null && widget.segments.length >= 2) {
                        if (currentLabel != currentSegment(value).title)
                          setState(() => currentLabel = currentSegment(value).title);
                      }
                    },
                  ),
                ),
              ),
              Text(
                "${widget.duration.inMinutes.toString().padLeft(2, '0')}:"+
                "${widget.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 10
                ),
              ),
              SizedBox(width: 16),
              // Audio Only Switch
              GestureDetector(
                onTap: widget.onAudioOnlySwitch,
                child: Container(
                  color: Colors.transparent,
                  child: Icon(
                    widget.audioOnly
                      ? Icons.music_note_outlined : Icons.music_off_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 16),
              // FullScreen Button
              GestureDetector(
                onTap: widget.onFullScreenTap,
                child: Container(
                  color: Colors.transparent,
                  child: Icon(
                    MediaQuery.of(context).orientation == Orientation.portrait
                      ? Icons.fullscreen_outlined : Icons.fullscreen_exit_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            child: isDragging && currentLabel != null
              ? Container(
                  child: PageTransitionSwitcher(
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                    ) {
                      return FadeThroughTransition(
                        fillColor: Colors.transparent,
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        child: child,
                      );
                    },
                    duration: Duration(milliseconds: 300),
                    child: Text(
                      currentLabel,
                      key: ValueKey<String>(currentLabel),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  height: 30,
                  width: MediaQuery.of(context).size.width-48,
                )
              : Container(
                  height: 8
                )
          )
        ],
      ),
    );
  }
}