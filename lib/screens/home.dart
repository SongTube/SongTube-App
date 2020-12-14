// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/screens/homeScreen/components/homePageFavoritesEmpty.dart';
import 'package:songtube/screens/homeScreen/components/homePageWatchLaterEmpty.dart';
import 'package:songtube/screens/homeScreen/homeAppBar.dart';
import 'package:songtube/screens/homeScreen/homeCategoryList.dart';
import 'package:songtube/routes/components/video/shimmer/shimmerVideoTile.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:songtube/screens/homeScreen/pages/favorites.dart';
import 'package:songtube/screens/homeScreen/pages/homePage.dart';
import 'package:songtube/screens/homeScreen/pages/music.dart';
import 'package:songtube/screens/homeScreen/pages/trending.dart';
import 'package:songtube/screens/homeScreen/pages/watchLater.dart';
import 'package:songtube/ui/components/searchHistory.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    return Scaffold(
      key: PageStorageKey('this'),
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).cardColor,
      body: Stack(
        children: [
          DefaultTabController(
            length: 5,
            child: NestedScrollView(
              physics: BouncingScrollPhysics(),
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, value) {
                return [ HomePageAppBar(manager.showSearchBar) ];
              },
              body: Column(
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey[600].withOpacity(0.2)
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        HomePage(),
                        HomePageTrending(1),
                        HomePageMusic(1),
                        HomePageFavorites(1),
                        HomePageWatchLater(1)
                      ]
                    ),
                  ),
                ],
              ),
            )
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: manager.showSearchBar
              ? Column(
                children: [
                  Container(
                    height: kToolbarHeight + 50,
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: SearchHistoryList(
                        margin: EdgeInsets.zero,
                        borderRadius: 0,
                        onItemTap: (String item) {
                          manager.searchBarFocusNode.unfocus();
                          manager.youtubeSearchQuery = item;
                          manager.updateYoutubeSearchResults(updateResults: true);
                          Future.delayed(Duration(milliseconds: 100), () {
                            manager.showSearchBar = false;
                          });
                          if (item.length > 1) {
                            Future.delayed(Duration(milliseconds: 400), () =>
                              config.addStringtoSearchHistory(item.trim()
                            ));
                          }
                        }
                      ),
                    ),
                  ),
                ],
              )
              : Container()
          )
        ],
      ),
    );
  }

  Widget _sliverListChild(BuildContext context, int index) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    PreferencesProvider preferences = Provider.of<PreferencesProvider>(context);
    if (manager.currentHomeTab == HomeScreenTab.Home) {
      if (manager.youtubeSearchResults.isNotEmpty)
        return HomePage();
      else 
        return ShimmerVideoTile();
    } else if (manager.currentHomeTab == HomeScreenTab.Trending) {
      if (manager.homeTrendingVideoList.isNotEmpty)
        return HomePageTrending(index);
      else
        return ShimmerVideoTile();
    } else if (manager.currentHomeTab == HomeScreenTab.Music) {
      if (manager.homeMusicVideoList.isNotEmpty)
        return HomePageMusic(index);
      else
        return ShimmerVideoTile();
    } else if (manager.currentHomeTab == HomeScreenTab.Favorites) {
      if (preferences.favoriteVideos.isNotEmpty)
        return HomePageFavorites(index);
      else
        return HomePageFavoritesEmpty();
    } else if (manager.currentHomeTab == HomeScreenTab.WatchLater) {
      if (preferences.watchLaterVideos.isNotEmpty)
        return HomePageWatchLater(index);
      else
        return HomePageWatchLaterEmpty();
    } else {
      return Container();
    }
  }

  int _sliverListChildCount(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    PreferencesProvider provider = Provider.of<PreferencesProvider>(context);
    if (manager.currentHomeTab == HomeScreenTab.Home) {
      if (manager.youtubeSearchResults.isNotEmpty)
        return manager.youtubeSearchResults.length;
      else
        return 20;
    } else if (manager.currentHomeTab == HomeScreenTab.Trending) {
      if (manager.homeTrendingVideoList.isNotEmpty)
        return manager.homeTrendingVideoList.length;
      else
        return 20;
    } else if (manager.currentHomeTab == HomeScreenTab.Music) {
      if (manager.homeMusicVideoList.isNotEmpty)
        return manager.homeMusicVideoList.length;
      else
        return 20;
    } else if (manager.currentHomeTab == HomeScreenTab.Favorites) {
      if (provider.favoriteVideos.isNotEmpty)
        return provider.favoriteVideos.length;
      else
        return 1;
    } else if (manager.currentHomeTab == HomeScreenTab.WatchLater) {
      if (provider.watchLaterVideos.isNotEmpty)
        return provider.watchLaterVideos.length;
      else
        return 1;
    } else {
      return 1;
    }
  }

}
