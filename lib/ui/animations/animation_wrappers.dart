import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
    required this.child,
    Key? key
  }) : super(key: key);

  final Widget child;
  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionDuration: const Duration(milliseconds: 300),
      transitionType: transitionType,
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      middleColor: Colors.transparent,
      closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      openShape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      openElevation: 0,
      closedElevation: 0,
      openBuilder: (BuildContext context, VoidCallback _) {
        return child;
      },
      onClosed: onClosed,
      closedBuilder: closedBuilder,
    );
  }
}