import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    this.borderRadius,
    this.onTap,
    this.onLongPress,
    required this.child,
    Key? key}) : super(key: key);
  final BorderRadius? borderRadius;
  final Widget child;
  final Function()? onTap;
  final Function()? onLongPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
      borderRadius: borderRadius ?? BorderRadius.circular(100),
      onTap: onTap,
      child: child,
    );
  }
}