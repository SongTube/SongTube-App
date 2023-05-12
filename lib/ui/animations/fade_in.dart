// Dart
import 'dart:async';

// Flutter
import 'package:flutter/material.dart';

class FadeInTransition extends StatefulWidget {
  /// [child] to be Animated
  final Widget child;
  /// Animation Duration, default is 200 Milliseconds
  final Duration? duration;
  /// Animation Curve, default is Linear
  final Curve? curve;
  /// Delay before starting Animation
  final Duration? delay;

  const FadeInTransition({
    required this.child,
    this.duration,
    this.curve,
    this.delay,
    Key? key
  }) : super(key: key);

  @override
  _FadeInTransitionState createState() => _FadeInTransitionState();
}

class _FadeInTransitionState extends State<FadeInTransition> with TickerProviderStateMixin {
  
  late final AnimationController _animController =
    AnimationController(vsync: this, duration: widget.duration ?? const Duration(milliseconds: 200));

  @override
  void initState() {
    super.initState();
    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(widget.delay!, () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _animController,
        curve: widget.curve ?? Curves.linear
      ),
      child: widget.child,
    );
  }
}