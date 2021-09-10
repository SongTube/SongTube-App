import 'package:flutter/material.dart';

class FadeSizeTransition extends StatelessWidget {
  final Animation<double> animator;
  final Widget child;
  FadeSizeTransition({
    required this.animator,
    required this.child
  });
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animator,
      child: SizeTransition(
        sizeFactor: animator,
        child: child,
      ),
    );
  }
}