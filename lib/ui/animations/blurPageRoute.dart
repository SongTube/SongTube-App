import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlurPageRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> {

  Duration duration;
  bool keepState;
  double blurStrength;
  Curve animationCurve;
  Offset slideOffset;

  BlurPageRoute({
    this.duration = const Duration(milliseconds: 500),
    this.keepState = false,
    this.blurStrength = 20,
    @required this.builder,
    RouteSettings settings,
    this.maintainState = true,
    bool fullscreenDialog = false,
    this.animationCurve = Curves.easeOutQuart,
    this.opaque = false,
    this.slideOffset = const Offset(0.0, 10.0)
  }) : assert(builder != null),
       assert(maintainState != null),
       assert(fullscreenDialog != null),
       super(settings: settings, fullscreenDialog: fullscreenDialog) {
  }

  /// Builds the primary contents of the route.
  final WidgetBuilder builder;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // Create transition from bottom to top, like bottom sheet
    return SlideTransition(
      position: CurvedAnimation(
        parent: animation,
        curve: animationCurve,
      ).drive(
        Tween<Offset>(
          begin: slideOffset,
          end: Offset(0.0, 0.0),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurStrength*animation.value,
          sigmaY: blurStrength*animation.value
        ),
        child: child
      ),
    );
  }

  @override
  final bool maintainState;

  @override
  Duration get transitionDuration => duration;

  @override
  bool opaque;

}