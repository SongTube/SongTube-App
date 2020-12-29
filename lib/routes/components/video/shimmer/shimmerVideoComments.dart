import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerVideoComments extends StatelessWidget {
  const ShimmerVideoComments();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(left: 12),
      child: Center(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor.withOpacity(0.4),
            highlightColor: Theme.of(context).cardColor,
            child: Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Theme.of(context).cardColor.withOpacity(0.4)
              ),
            ),
          ),
        ),
      ),
    );
  }
}