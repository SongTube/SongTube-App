import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/homeScreen/components/shimmerListView.dart';
import 'package:songtube/screens/homeScreen/components/videoTile.dart';

class HomePageMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    if (manager.homeMusicVideoList.isNotEmpty) {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: manager.homeMusicVideoList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16, top: index == 0 ? 12 : 0),
            child: VideoTile(
              searchItem: manager.homeMusicVideoList[index],
            ),
          );
        }
      );
    } else {
      return ShimmerHomePageListView();
    }
  }
}