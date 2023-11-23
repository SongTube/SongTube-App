import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/providers/media_provider.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText(this.text, {
    required this.style,
    this.letterSpacing,
    this.auto = false,
    this.opacity,
    this.maxLines,
    this.textAlign,
    Key? key}) : super(key: key);
  final String text;
  final TextStyle style;
  final double? letterSpacing;
  final bool auto;
  final double? opacity;
  final int? maxLines;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    if (auto) {
      return Consumer<MediaProvider>(
        builder: (context, provider, _) {
          return AnimatedSwitcher(
            duration: kAnimationShortDuration,
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Text(
              text,
              textAlign: textAlign,
              key: ValueKey('$text-${provider.currentColors.vibrant ?? style.color?.value}'),
              style: style.copyWith(letterSpacing: letterSpacing, color: (provider.currentColors.vibrant ?? style.color)?.withOpacity(opacity ?? 1)),
            ),
          );
        }
      );
    } else {
      return AnimatedSwitcher(
        duration: kAnimationShortDuration,
        child: Text(
          text,
          key: ValueKey('$text-${style.color?.value}'),
          style: style.copyWith(letterSpacing: letterSpacing),
        ),
      );
    }
  }
}