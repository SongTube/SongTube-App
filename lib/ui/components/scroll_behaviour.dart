import 'package:flutter/material.dart';

class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior({required this.androidSdkVersion}) : super();
  final int androidSdkVersion;
  @override
  Widget buildOverscrollIndicator(
      BuildContext context,
      Widget child,
      ScrollableDetails details,
  ) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
        if (androidSdkVersion > 30) {
          return StretchingOverscrollIndicator(
            axisDirection: details.direction,
            child: child,
          );
        } else {
          return GlowingOverscrollIndicator(
            axisDirection: details.direction,
            color: Theme.of(context).cardColor,
            child: child,
          );
        }
    case TargetPlatform.fuchsia:
      return GlowingOverscrollIndicator(
        axisDirection: details.direction,
        color: Theme.of(context).colorScheme.secondary,
        child: child,
      );
    }
  }
}