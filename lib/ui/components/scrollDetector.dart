import 'package:flutter/material.dart';

class ScrollDetector extends StatefulWidget {
  final Function onScrollUp;
  final Function onScrollDown;
  final Widget child;
  ScrollDetector({
    @required this.child,
    this.onScrollDown,
    this.onScrollUp
  });

  @override
  _ScrollDetectorState createState() => _ScrollDetectorState();
}

class _ScrollDetectorState extends State<ScrollDetector> {

  double position = 0.0;
  double sensitivityFactor = 100.0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification details) {
        if (details.metrics.pixels - position >= sensitivityFactor && details.metrics.axis == Axis.vertical) {
          position = details.metrics.pixels;
          widget.onScrollDown();
        } else if (position - details.metrics.pixels  >= sensitivityFactor && details.metrics.axis == Axis.vertical) {
          position = details.metrics.pixels;
          widget.onScrollUp();
        }
        return false;
      },
      child: widget.child,
    );
  }
}