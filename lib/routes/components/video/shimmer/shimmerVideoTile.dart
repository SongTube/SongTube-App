import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerVideoTile extends StatelessWidget {
  const ShimmerVideoTile();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12, right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Shimmer.fromColors(
                baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                highlightColor: Theme.of(context).cardColor,
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 4),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                  highlightColor: Theme.of(context).cardColor,
                  child: Container(
                    height: 60,
                    width: 60,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).scaffoldBackgroundColor
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                        highlightColor: Theme.of(context).cardColor,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).scaffoldBackgroundColor
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                        highlightColor: Theme.of(context).cardColor,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).scaffoldBackgroundColor
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}