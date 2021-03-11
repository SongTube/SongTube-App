import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerVideoEngagement extends StatelessWidget {
  const ShimmerVideoEngagement();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor.withOpacity(0.4),
          highlightColor: Theme.of(context).cardColor,
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).cardColor.withOpacity(0.4)
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor.withOpacity(0.4),
          highlightColor: Theme.of(context).cardColor,
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).cardColor.withOpacity(0.4)
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor.withOpacity(0.4),
          highlightColor: Theme.of(context).cardColor,
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).cardColor.withOpacity(0.4)
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor.withOpacity(0.4),
          highlightColor: Theme.of(context).cardColor,
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).cardColor.withOpacity(0.4)
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor.withOpacity(0.4),
          highlightColor: Theme.of(context).cardColor,
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).cardColor.withOpacity(0.4)
            ),
          ),
        ),
        SizedBox(height: 8)
      ],
    );
  }
}