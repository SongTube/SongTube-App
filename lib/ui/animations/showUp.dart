// Dart
import 'dart:async';

// Flutter
import 'package:flutter/material.dart';

enum SlideFromSlide {TOP, BOTTOM, LEFT, RIGHT}

class ShowUpTransition extends StatefulWidget {
  /// [child] to be Animated
  final Widget child;
  /// Animation Duration, default is 200 Milliseconds
  final Duration duration;
  /// Delay before starting Animation, default is Zero
  final Duration delay;
  /// Bring forward/reverse the Animation
  final bool forward;
  /// From which direction start the [Slide] animation
  final SlideFromSlide slideSide;

  ShowUpTransition({
    @required this.child,
    this.duration,
    this.delay,
    this.slideSide = SlideFromSlide.LEFT,
    @required this.forward
  });

  @override
  _ShowUpTransitionState createState() => _ShowUpTransitionState();
}

class _ShowUpTransitionState extends State<ShowUpTransition> 
  with SingleTickerProviderStateMixin {
  
  AnimationController _animController;
  Animation<Offset> _animOffset;

  List<Offset> slideSides = [
    Offset(-0.20,0.0), // LEFT
    Offset(0.20,0.0),  // RIGHT
    Offset(0.0,0.20), // BOTTOM
    Offset(0.0,-0.20),  // TOP
  ];
  Offset selectedSlide;



  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: widget.duration == null
          ? Duration(milliseconds: 400)
          : widget.duration
        );
    switch (widget.slideSide) {
      case SlideFromSlide.LEFT:
        selectedSlide = slideSides[0]; break;
      case SlideFromSlide.RIGHT:
        selectedSlide = slideSides[1]; break;
      case SlideFromSlide.BOTTOM:
        selectedSlide = slideSides[2]; break;
      case SlideFromSlide.TOP:
        selectedSlide = slideSides[3]; break;
    }
    _animOffset =
        Tween<Offset>(
          begin: selectedSlide,
          end: Offset.zero
        ).animate(CurvedAnimation(
          curve: Curves.fastLinearToSlowEaseIn,
          parent: _animController
        )); 
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(widget.delay == null ? Duration.zero : widget.delay, () {
      if (widget.forward) {
        if (mounted)
          _animController.forward();
      } else {
        if (mounted)
          _animController.reverse();
      }
    });
    return widget.forward
      ? FadeTransition(
        child: SlideTransition(
          position: _animOffset,
          child: widget.child,
        ),
        opacity: _animController,
      )
      : Container();
  }
}