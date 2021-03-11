import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/ui/layout/streamsLargeThumbnail.dart';

class HomePageTrending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return StreamsLargeThumbnailView(
      infoItems: manager.homeTrendingVideoList
    );
  }
}