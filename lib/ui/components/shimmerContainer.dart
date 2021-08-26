import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final double? aspectRatio;
  ShimmerContainer({
    this.height,
    this.width,
    this.borderRadius,
    this.margin,
    this.aspectRatio
  });
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
      highlightColor: Theme.of(context).cardColor,
      child: aspectRatio != null
        ? AspectRatio(
            aspectRatio: aspectRatio!,
            child: Container(
              height: height,
              width: width,
              margin: margin == null ? EdgeInsets.zero : margin,
              decoration: BoxDecoration(
                borderRadius: borderRadius == null ? BorderRadius.zero : borderRadius,
                color: Theme.of(context).scaffoldBackgroundColor
              ),
            ),
          )
        : Container(
            height: height,
            width: width,
            margin: margin == null ? EdgeInsets.zero : margin,
            decoration: BoxDecoration(
              borderRadius: borderRadius == null ? BorderRadius.zero : borderRadius,
              color: Theme.of(context).scaffoldBackgroundColor
            ),
          ),
    );
  }
}