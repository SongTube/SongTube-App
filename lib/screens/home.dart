// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/screens/homeScreen/homeAppBar.dart';

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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    ManagerProvider manager = Provider.of<ManagerProvider>(context, listen: false);
    controller = TabController(length: 5, vsync: this);
    controller.addListener(() {
      int tabIndex = controller.index;
      if (tabIndex == 0) {
        manager.currentHomeTab = HomeScreenTab.Home;
      } else if (tabIndex == 1) {
        manager.currentHomeTab = HomeScreenTab.Trending;
      } else if (tabIndex == 2) {
        manager.currentHomeTab = HomeScreenTab.Music;
      } else if (tabIndex == 3) {
        manager.currentHomeTab = HomeScreenTab.Favorites;
      } else if (tabIndex == 4) {
        manager.currentHomeTab = HomeScreenTab.WatchLater;
      } 
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).cardColor,
      body: Stack(
        children: [
          NestedScrollView(
            physics: BouncingScrollPhysics(),
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, value) {
              return [
                HomePageAppBar(
                  openSearch: manager.showSearchBar,
                  tabController: controller,
                  onSearch: () {
                    controller.animateTo(0);
                  }
                )
              ];
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
                    controller: controller,
                    children: [
                      HomePage(),
                      HomePageTrending(),
                      HomePageMusic(),
                      HomePageFavorites(),
                      HomePageWatchLater()
                    ]
                  ),
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: manager.showSearchBar
              ? Column(
                children: [
                  Container(
                    height: kToolbarHeight + 48,
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: SearchHistoryList(
                        onItemTap: (String item) {
                          manager.searchBarFocusNode.unfocus();
                          manager.youtubeSearchQuery = item;
                          controller.animateTo(0);
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
}
