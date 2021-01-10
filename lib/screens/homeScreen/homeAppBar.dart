import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/routes/playlist.dart';
import 'package:songtube/routes/video.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/components/searchBar.dart';
import 'package:songtube/ui/dialogs/loadingDialog.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class HomePageAppBar extends StatefulWidget {
  final bool openSearch;
  final TabController tabController;
  final Function onSearch;
  HomePageAppBar({
    this.openSearch,
    this.tabController,
    this.onSearch
  });

  @override
  _HomePageAppBarState createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return SliverAppBar(
      titleSpacing: 0,
      pinned: true,
      floating: true,
      snap: true,
      backgroundColor: Theme.of(context).cardColor,
      title: AnimatedSwitcher(
        reverseDuration: Duration(milliseconds: 200),
        duration: Duration(milliseconds: 400),
        child: STSearchBar(
          controller: manager.urlController,
          focusNode: manager.searchBarFocusNode,
          onSearch: (searchQuery) async {
            widget.onSearch();
            manager.searchBarFocusNode.unfocus();
            manager.showSearchBar = false;
            if (VideoId.parseVideoId(searchQuery) != null) {
              String id = VideoId.parseVideoId(searchQuery);
              showDialog(
                context: context,
                builder: (_) => LoadingDialog()
              );
              YoutubeExplode yt = YoutubeExplode();
              Video video = await yt.videos.get(id);
              manager.updateMediaInfoSet(video, null);
              Navigator.pop(context);
              Navigator.push(context,
                BlurPageRoute(
                  blurStrength: prefs.enableBlurUI ? 20 : 0,
                  slideOffset: Offset(0.0, 10.0),
                  builder: (_) => YoutubePlayerVideoPage(
                    url: video.id.value,
                    thumbnailUrl: video.thumbnails.highResUrl,
                  )
              ));
              return;
            }
            if (PlaylistId.parsePlaylistId(searchQuery) != null) {
              String id = PlaylistId.parsePlaylistId(searchQuery);
              showDialog(
                context: context,
                builder: (_) => LoadingDialog()
              );
              YoutubeExplode yt = YoutubeExplode();
              Playlist playlist = await yt.playlists.get(id);
              manager.updateMediaInfoSet(playlist, null);
              Navigator.pop(context);
              Navigator.push(context,
                BlurPageRoute(
                  blurStrength: prefs.enableBlurUI ? 20 : 0,
                  slideOffset: Offset(0.0, 10.0),
                  builder: (_) => YoutubePlayerPlaylistPage()
              ));
              return;
            }
            manager.youtubeSearchQuery = manager.urlController.text;
            manager.updateYoutubeSearchResults(updateResults: true);
            if (searchQuery.length > 1) {
              Future.delayed(Duration(milliseconds: 400), () =>
                config.addStringtoSearchHistory(searchQuery.trim()
              ));
            }
          },
          onChanged: (_) {
            setState(() {});
          },
          onBack: () {
            manager.showSearchBar = false;
          },
          onClear: () {
            manager.urlController.clear();
            setState(() {});
          },
          leadingIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              DateTime.now().month == 12
                ? 'assets/images/logo_christmas.png'
                : 'assets/images/ic_launcher.png',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          searchHint: "SongTube",
          onTap: () {
            manager.showSearchBar = true;
          }
        )
      ),
      bottom: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          48
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 32),
          child: TabBar(
            controller: widget.tabController,
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
    );
  }
}

