// Flutter
import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:newpipeextractor_dart/extractors/playlist.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/models/playlist.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/screens/homeScreen/searchBar.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';  

// Packages
import 'package:provider/provider.dart';
import 'package:songtube/screens/homeScreen/pages/favorites.dart';
import 'package:songtube/screens/homeScreen/pages/trending.dart';
import 'package:songtube/screens/homeScreen/pages/watchLater.dart';
import 'package:songtube/ui/components/autoHideScaffold.dart';
import 'package:songtube/ui/components/searchHistory.dart';
import 'package:songtube/ui/dialogs/loadingDialog.dart';
import 'package:songtube/ui/layout/streamsLargeThumbnail.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    ManagerProvider manager = Provider.of<ManagerProvider>(context, listen: false);
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
      int tabIndex = controller.index;
      if (tabIndex == 0) {
        manager.currentHomeTab = HomeScreenTab.Trending;
      } else if (tabIndex == 1) {
        manager.currentHomeTab = HomeScreenTab.Favorites;
      } else if (tabIndex == 2) {
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
    return AutoHideScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).cardColor,
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          kToolbarHeight
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: HomePageAppBar(
            onLoadPlaylist: (id) async {
              showDialog(
                context: context,
                builder: (_) => LoadingDialog()
              );
              YoutubePlaylist playlist = await PlaylistExtractor
                .getPlaylistDetails(id);
              Provider.of<VideoPageProvider>(context, listen: false)
                .infoItem = playlist.toPlaylistInfoItem();
              Navigator.pop(context);
            },
            onLoadVideo: (id) async {
              showDialog(
                context: context,
                builder: (_) => LoadingDialog()
              );
              YoutubeVideo video = await VideoExtractor.getStream(id);
              Provider.of<VideoPageProvider>(context, listen: false)
                .infoItem = video.toStreamInfoItem();
              Navigator.pop(context);
            },
          )
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedSize(
                vsync: this,
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).cardColor,
                  height: manager.showSearchBar ? 0 : 40,
                  child: AnimatedOpacity(
                    opacity: manager.showSearchBar ? 0 : 1.0,
                    duration: Duration(milliseconds: 200),
                    child: Padding(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: TabBar(
                        controller: controller,
                        onTap: (int tabIndex) {
                          if (tabIndex == 0) {
                            manager.currentHomeTab = HomeScreenTab.Trending;
                          } else if (tabIndex == 1) {
                            manager.currentHomeTab = HomeScreenTab.Favorites;
                          } else if (tabIndex == 2) {
                            manager.currentHomeTab = HomeScreenTab.WatchLater;
                          }
                        },
                        labelStyle: TextStyle(
                          fontSize: 14,
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
                          indicatorSize: MD2IndicatorSize.tiny,
                          indicatorHeight: 4,
                          indicatorColor: Theme.of(context).accentColor,
                        ),
                        tabs: [
                          Tab(text: Languages.of(context).labelTrending),
                          Tab(text: Languages.of(context).labelFavorites),
                          Tab(text: Languages.of(context).labelWatchLater)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey[600].withOpacity(0.1),
                indent: 12,
                endIndent: 12
              ),
              Expanded(
                child: manager.showSearchBar
                    ? Container(
                        color: Theme.of(context).cardColor,
                        child: StreamsLargeThumbnailView(
                            infoItems: manager?.youtubeSearch?.dynamicSearchResultsList ?? [],
                            onReachingListEnd: () {
                              manager.searchYoutube(
                                query: manager.youtubeSearch.query
                              );
                            },
                          ),
                        )
                    : TabBarView(
                        controller: controller,
                        children: [
                          HomePageTrending(),
                          HomePageFavorites(),
                          HomePageWatchLater()
                        ]
                      )
              ),
            ],
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: manager.searchBarFocusNode.hasFocus
              ? Column(
                children: [
                  Container(
                    height: manager.showSearchBar ? 0 : 40,
                    color: Theme.of(context).cardColor,
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Consumer<ManagerProvider>(
                        builder: (context, manager, _) {
                          return SearchHistoryList(
                            searchQuery: manager.searchController.text
                              .replaceAll('#', '')
                              .replaceAll('&', ''),
                            onItemTap: (String item) {
                              manager.searchController.text = item;
                              manager.searchBarFocusNode.unfocus();
                              manager.youtubeSearchQuery = item;
                              controller.animateTo(0);
                              manager.searchYoutube(query: item, forceReload: true);
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
