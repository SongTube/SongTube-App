import 'package:flutter/material.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    required this.height,
    required this.width,
    this.borderRadius,
    this.margin,
    this.aspectRatio,
    this.color,
    Key? key
  }) : super(key: key);
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final double? aspectRatio;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return aspectRatio != null
      ? AspectRatio(
          aspectRatio: aspectRatio!,
          child: Container(
            height: height,
            width: width,
            margin: margin ?? EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.zero,
              color: color ?? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6)
            ),
          ),
        )
      : Container(
          height: height,
          width: width,
          margin: margin ?? EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.zero,
            color: color ?? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6)
          ),
        );
  }
}