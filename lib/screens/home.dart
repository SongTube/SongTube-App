// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/screens/homeScreen/homeAppBar.dart';
import 'package:songtube/screens/homeScreen/homeCategoryList.dart';
import 'package:songtube/screens/homeScreen/shimmer/shimmerVideoTile.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:songtube/ui/components/searchHistory.dart';

import 'homeScreen/components/videoTile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NotificationListener(
        child: CustomScrollView(
          controller: manager.homeScrollController,
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            HomePageAppBar(manager.showSearchBar),
            SliverPersistentHeader(
              floating: true,
              delegate: HomePageCategoryList(
                minHeight: 50, maxHeight: 50
              )
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: sliverListChild(context, index),
                  );
                },
                childCount: manager.showSearchBar
                  ? 1 : manager.youtubeSearchResults.isNotEmpty
                  ? manager.youtubeSearchResults.length
                  : 20
              ),
            ),
          ]
        ),
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            if (manager.homeScrollController.position.pixels >
                manager.homeScrollController.position.maxScrollExtent-400) {
              if (manager.searchStreamRunning == false) {
                manager.updateYoutubeSearchResults();
              }
            }
          }
          return true;
        },
      ),
    );
  }

  Widget sliverListChild(BuildContext context, int index) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    if (manager.showSearchBar) {
      return SearchHistoryList(
        margin: EdgeInsets.zero,
        borderRadius: 0,
        onItemTap: (String item) {
          manager.searchBarFocusNode.unfocus();
          manager.showSearchBar = false;
          manager.youtubeSearchQuery = item;
          manager.updateYoutubeSearchResults(updateResults: true);
          if (item.length > 1) {
            Future.delayed(Duration(milliseconds: 400), () =>
              config.addStringtoSearchHistory(item.trim()
            ));
          }
        }
      );
    }
    if (manager.youtubeSearchResults.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(
          top: index == 0 ? 0 : 8,
          bottom: manager.youtubeSearchResults.length-1 == index ? 16 : 0
        ),
        child: VideoTile(
          searchItem: manager.youtubeSearchResults[index],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
          top: index == 0 ? 0 : 8,
          bottom: manager.youtubeSearchResults.length-1 == index ? 16 : 0
        ),
        child: ShimmerVideoTile(),
      );
    }
  }

}
