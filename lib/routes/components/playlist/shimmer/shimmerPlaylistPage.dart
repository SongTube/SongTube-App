import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPlaylistPage extends StatelessWidget {
  const ShimmerPlaylistPage();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16/9,
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor.withOpacity(0.4),
            highlightColor: Theme.of(context).cardColor,
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor
              ),
            ),
          ),
        ),
        Row(
          children: [
            Shimmer.fromColors(
              baseColor: Theme.of(context).cardColor.withOpacity(0.4),
              highlightColor: Theme.of(context).cardColor,
              child: Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.only(right: 12, left: 12, top: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Theme.of(context).cardColor
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Shimmer.fromColors(
                    baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                    highlightColor: Theme.of(context).cardColor,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Theme.of(context).cardColor
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Shimmer.fromColors(
                    baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                    highlightColor: Theme.of(context).cardColor,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Theme.of(context).cardColor
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8)
          ],
        ),
        SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            itemCount: 20,
            physics: BouncingScrollPhysics(),
            itemExtent: 80,
            itemBuilder: (context,_) {
              return ListTile(
                title: Shimmer.fromColors(
                  baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                  highlightColor: Theme.of(context).cardColor,
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Theme.of(context).cardColor
                    ),
                  ),
                ),
                subtitle: Shimmer.fromColors(
                  baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                  highlightColor: Theme.of(context).cardColor,
                  child: Container(
                    height: 15,
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Theme.of(context).cardColor
                    ),
                  ),
                ),
                leading: Shimmer.fromColors(
                  baseColor: Theme.of(context).cardColor.withOpacity(0.4),
                  highlightColor: Theme.of(context).cardColor,
                  child: Container(
                    height: 80,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor
                    ),
                  ),
                ),
              );
            }
          ),
        )
      ],
    );
  }
}