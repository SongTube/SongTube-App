import 'dart:async';

// Flutter
import 'package:flutter/material.dart';

enum SlideFromSlide {top, bottom, left, right}

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

  const ShowUpTransition({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.delay = Duration.zero,
    this.slideSide = SlideFromSlide.bottom,
    this.forward = true,
    Key? key
  }) : super(key: key);

  @override
  ShowUpTransitionState createState() => ShowUpTransitionState();
}

class ShowUpTransitionState extends State<ShowUpTransition> 
  with SingleTickerProviderStateMixin {
  
  late final _animController = AnimationController(vsync: this, duration: widget.duration);
  late final _animOffset =
    Tween<Offset>(
      begin: selectedSlide,
      end: Offset.zero
    ).animate(CurvedAnimation(
      curve: Curves.fastLinearToSlowEaseIn,
      parent: _animController
    ));

  List<Offset> slideSides = const [
    Offset(-0.20,0.0), // LEFT
    Offset(0.20,0.0),  // RIGHT
    Offset(0.0,0.20), // BOTTOM
    Offset(0.0,-0.20),  // TOP
  ];
  late Offset selectedSlide;

  @override
  void initState() {
    switch (widget.slideSide) {
      case SlideFromSlide.left:
        selectedSlide = slideSides[0]; break;
      case SlideFromSlide.right:
        selectedSlide = slideSides[1]; break;
      case SlideFromSlide.bottom:
        selectedSlide = slideSides[2]; break;
      case SlideFromSlide.top:
        selectedSlide = slideSides[3]; break;
    }
    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.forward) {
      Timer(widget.delay, () {
        if (mounted) {
          _animController.forward();
        }
      });
    } else {
      if (mounted) {
        _animController.reverse();
      }
    }
    return IgnorePointer(
      ignoring: !widget.forward,
      child: FadeTransition(
        opacity: _animController,
        child: SlideTransition(
          position: _animOffset,
          child: widget.child,
        ),
      ),
    );
  }
}