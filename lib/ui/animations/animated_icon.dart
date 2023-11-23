import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/providers/media_provider.dart';

class AppAnimatedIcon extends StatelessWidget {
  const AppAnimatedIcon(this.icon, {
    this.color, this.size,
    this.opacity,
    Key? key}) : super(key: key);
  final IconData icon;
  final Color? color;
  final double? size;
  final double? opacity;
  @override
  Widget build(BuildContext context) {
    if (color != null) {
      return AnimatedSwitcher(
        duration: kAnimationShortDuration,
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: Icon(icon,
          key: ValueKey('animatedIcon${color?.value}'),
          color: color, size: size)
      );
    } else {
      return Consumer<MediaProvider>(
        builder: (context, provider, _) {
          return AnimatedSwitcher(
            duration: kAnimationShortDuration,
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Icon(icon,
              key: ValueKey('animatedIcon${provider.currentColors?.vibrant}'),
              color: (provider.currentColors?.vibrant ?? Theme.of(context).iconTheme.color)?.withOpacity(opacity ?? 1), size: size)
          );
        }
      );
    }
  }
}