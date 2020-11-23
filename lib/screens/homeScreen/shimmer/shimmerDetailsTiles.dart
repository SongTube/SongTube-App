import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDetailsTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 4),
        ),
        Row(
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
          ],
        ),
      ],
    );
  }
}