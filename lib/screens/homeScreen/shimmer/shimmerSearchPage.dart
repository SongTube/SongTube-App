import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:songtube/ui/animations/showUp.dart';

class ShimmerSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 11,
      itemBuilder: (context, index) {
        return ShowUpTransition(
          duration: Duration(milliseconds: 400),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor.withOpacity(0.4),
            highlightColor: Theme.of(context).cardColor,
            child: Container(
              margin: EdgeInsets.only(
                top: index == 0 ? 20 : 10,
                bottom: index == 10 ? 20 : 10,
                left: 20,
                right: 20
              ),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).cardColor
              ),
            ),
          ),
        );
      },
    );
  }
}