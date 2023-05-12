import 'package:flutter/material.dart';

class InfiniteScrollingAdapter extends StatelessWidget {
  const InfiniteScrollingAdapter({
    required this.child, 
    required this.onReachingEnd,
    super.key});
  final Widget child;
  final Function() onReachingEnd;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        double maxScroll = notification.metrics.maxScrollExtent;
        double currentScroll = notification.metrics.pixels;
        double delta = 200.0;
        if (maxScroll - currentScroll <= delta) {
          onReachingEnd();
        }
        return false;
      },
      child: child,
    );
  }
}