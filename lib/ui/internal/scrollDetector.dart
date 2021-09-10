import 'package:flutter/material.dart';

class ScrollDetector extends StatelessWidget {
  final Function? onScrollUp;
  final Function? onScrollDown;
  final Widget child;
  ScrollDetector({
    required this.child,
    this.onScrollDown,
    this.onScrollUp
  });
  final sensitivityFactor = 5;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (ScrollUpdateNotification details) {
        if (details.scrollDelta!.abs() < sensitivityFactor)
          return false;
        if (details.scrollDelta! > 0.0 && details.metrics.axis == Axis.vertical) {
          onScrollDown!();
        } else {
          onScrollUp!();
        }
        return false;
      },
      child: child,
    );
  }
}