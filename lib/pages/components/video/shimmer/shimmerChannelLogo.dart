import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerChannelLogo extends StatelessWidget {
  const ShimmerChannelLogo();
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).cardColor.withOpacity(0.4),
      highlightColor: Theme.of(context).cardColor,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).cardColor.withOpacity(0.4)
        ),
      ),
    );
  }
}