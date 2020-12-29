import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerArtworkEditor extends StatelessWidget {
  const ShimmerArtworkEditor();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(left: 12, right: 12),
      child: Center(
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: Theme.of(context).cardColor.withOpacity(0.4),
              highlightColor: Theme.of(context).cardColor,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor.withOpacity(0.4)
                ),
                width: 100,
                height: 50,
              ),
            ),
            Spacer(),
            Shimmer.fromColors(
              baseColor: Theme.of(context).cardColor.withOpacity(0.4),
              highlightColor: Theme.of(context).cardColor,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor.withOpacity(0.4)
                ),
                width: 100,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}