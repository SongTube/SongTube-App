import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/homeScreen/components/videoTile.dart';

class HomePage extends StatelessWidget {
  final int index;
  HomePage(this.index);
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: VideoTile(
        searchItem: manager.youtubeSearchResults[index],
      ),
    );
  }
}