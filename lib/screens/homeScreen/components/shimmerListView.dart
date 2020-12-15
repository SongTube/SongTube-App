import 'package:flutter/material.dart';
import 'package:songtube/routes/components/video/shimmer/shimmerVideoTile.dart';

class ShimmerHomePageListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 ? 12 : 0
          ),
          child: ShimmerVideoTile(),
        );
      },
    );
  }
}