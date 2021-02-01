// Flutter
import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:songtube/internal/languages.dart';
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
import 'package:songtube/ui/components/autohideScaffold.dart';
import 'package:songtube/ui/components/searchHistory.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  TabController controller;
  String searchQuery = "";

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
    ManagerProvider manager = Provider.of<ManagerProvider>(context, listen: false);
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    return AutoHideScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: HomePageAppBar(
        openSearch: manager.showSearchBar,
        onSearch: () {
          controller.animateTo(0);
        },
        onChanged: (String query) {
          searchQuery = query;
        },
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).cardColor,
                height: 48,
                child: Padding(
                  padding: EdgeInsets.only(left: 32),
                  child: TabBar(
                    controller: controller,
                    onTap: (int tabIndex) {
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
                    },
                    isScrollable: true,
                    labelStyle: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3
                    ),
                    unselectedLabelStyle: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2
                    ),
                    labelColor: Theme.of(context).accentColor,
                    unselectedLabelColor: Theme.of(context).textTheme.bodyText1
                      .color.withOpacity(0.4),
                    indicator: MD2Indicator(
                      indicatorSize: MD2IndicatorSize.normal,
                      indicatorHeight: 4,
                      indicatorColor: Theme.of(context).accentColor,
                    ),
                    tabs: [
                      Tab(text: Languages.of(context).labelHomePage),
                      Tab(text: Languages.of(context).labelTrending),
                      Tab(text: Languages.of(context).labelMusic),
                      Tab(text: Languages.of(context).labelFavorites),
                      Tab(text: Languages.of(context).labelWatchLater)
                    ],
                  ),
                ),
              ),
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
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: manager.showSearchBar
              ? Column(
                children: [
                  Container(
                    height: 48,
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Consumer<ManagerProvider>(
                        builder: (context, manager, _) {
                          return SearchHistoryList(
                            searchQuery: searchQuery,
                            onItemTap: (String item) {
                              manager.urlController.clear();
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
                            },
                          );
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
