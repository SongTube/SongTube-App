import 'dart:async';
import 'package:flutter/material.dart';

class ShowUpTransition extends StatefulWidget {
  /// [child] to be Animated
  final Widget child;
  /// Animation Duration, default is 200 Milliseconds
  final Duration duration;
  /// Delay before starting Animation, default is Zero
  final Duration delay;

  ShowUpTransition({
    @required this.child,
    this.duration,
    this.delay,
  });

  @override
  _ShowUpTransitionState createState() => _ShowUpTransitionState();
}

class _ShowUpTransitionState extends State<ShowUpTransition> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: widget.duration == null
          ? Duration(milliseconds: 200)
          : widget.duration
        );
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(widget.delay, () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}