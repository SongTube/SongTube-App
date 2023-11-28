import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newpipeextractor_dart/utils/url.dart';
import 'package:provider/provider.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/screens/home/home_default/pages/favorites_page.dart';
import 'package:songtube/screens/home/home_default/pages/search_page.dart';
import 'package:songtube/screens/home/home_default/pages/subscriptions_page.dart';
import 'package:songtube/screens/home/home_default/pages/trending_page.dart';
import 'package:songtube/screens/home/home_default/pages/video_playlists_page.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/animations/show_up.dart';
import 'package:songtube/ui/components/custom_inkwell.dart';
import 'package:songtube/ui/search_suggestions.dart';
import 'package:songtube/ui/sheets/search_filters.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/ui_utils.dart';

class HomeDefault extends StatefulWidget {
  const HomeDefault({Key? key}) : super(key: key);

  @override
  State<HomeDefault> createState() => _HomeDefaultState();
}

class _HomeDefaultState extends State<HomeDefault> with TickerProviderStateMixin, WidgetsBindingObserver {

  // TabBar Controller
  late TabController tabController = TabController(length: 4, vsync: this);

  // SearchBar Controller
  late TextEditingController searchController = TextEditingController()..addListener(() {
    setState(() {});
  });

  // Youtube Link Check
  Future<String?> clipboardLink() async {
    final link = (await Clipboard.getData(Clipboard.kTextPlain))?.text;
    if (link != null) {
      if (link.isNotEmpty) {
        final video = await YoutubeId.getIdFromStreamUrl(link);
        final playlist = await YoutubeId.getIdFromPlaylistUrl(link);
        if (video != null || playlist != null) {
          return link;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ContentProvider contentProvider = Provider.of(context);
    UiProvider uiProvider = Provider.of(context);
    if (tabController.length == 5 && (contentProvider.searchContent == null)) {
      tabController = TabController(length: 4, vsync: this);
    }
    if (tabController.length == 4 && (contentProvider.searchContent != null || contentProvider.searchingContent)) {
      tabController = TabController(length: 5, vsync: this);
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Stack(
            children: [
              // HomeScreen Body
              _body(),
              // Search Body, which goes on top to show search history and suggestions
              // when the search bar is focused
              ShowUpTransition(
                forward: uiProvider.homeSearchNode.hasFocus,
                child: SearchSuggestions(
                  searchQuery: searchController.text,
                  onSearch: (suggestion) {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      searchController.text = suggestion;
                    });
                    contentProvider.searchContentFor(suggestion);
                  },
                ),
              )
            ],
          ),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.97),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top+8),
                    SizedBox(
                      height: kToolbarHeight,
                      child: _appBar()),
                    _tabs(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _searchBar() {
    ContentProvider contentProvider = Provider.of(context);
    UiProvider uiProvider = Provider.of(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).cardColor.withOpacity(1)
            ),
            child: CustomInkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                uiProvider.homeSearchNode.requestFocus();
              },
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(right: 16),
                      height: kToolbarHeight,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            const AppAnimatedIcon(EvaIcons.searchOutline, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                enabled: true,
                                focusNode: uiProvider.homeSearchNode,
                                controller: searchController,
                                style: smallTextStyle(context).copyWith(),
                                decoration: InputDecoration.collapsed(
                                  hintStyle: smallTextStyle(context, opacity: 0.6).copyWith(fontWeight: FontWeight.w500),
                                  hintText: Languages.of(context)!.labelSearchYoutube),
                                onSubmitted: (query) {
                                  FocusScope.of(context).unfocus();
                                  setState(() {});
                                  contentProvider.searchContentFor(query);
                                },
                              ),
                            ),
                            if (searchController.text.trim().isNotEmpty)
                            CustomInkWell(
                              onTap: () {
                                searchController.clear();
                                uiProvider.homeSearchNode.requestFocus();
                                setState(() {});
                              },
                              child: const AppAnimatedIcon(Icons.clear, size: 18),
                            ),
                            FutureBuilder<String?>(
                              future: clipboardLink(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: CustomInkWell(
                                      semanticsLabel: Languages.of(context)!.labelSearchFilters,
                                      onTap: () {
                                        contentProvider.loadVideoPlayer(snapshot.data);
                                      },
                                      child: const AppAnimatedIcon(Icons.link_rounded, size: 18),
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            UiUtils.showModal(
              context: internalNavigatorKey.currentContext!,
              modal: SearchFiltersSheet());
          },
          icon: const AppAnimatedIcon(EvaIcons.gridOutline, size: 20)),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _appBar() {
    return _searchBar();
  }

  Widget _tabs() {
    ContentProvider contentProvider = Provider.of(context);
    return SizedBox(
      height: kToolbarHeight,
      child: TabBar(
        padding: const EdgeInsets.only(left: 8),
        controller: tabController,
        isScrollable: true,
        labelColor: Provider.of<MediaProvider>(context).currentColors.vibrant,
        unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
        labelStyle: tabBarTextStyle(context, opacity: 1),
        unselectedLabelStyle: tabBarTextStyle(context, bold: false),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.transparent,
        tabs: [
          if (contentProvider.searchContent != null || contentProvider.searchingContent)
          Tab(child: Text(Languages.of(context)!.labelSearch)),
          // Trending
          Tab(child: Text(Languages.of(context)!.labelTrending)),
          // Subscriptions
          Tab(child: Text(Languages.of(context)!.labelSubscriptions)),
          // Favorites
          Tab(child: Text(Languages.of(context)!.labelPlaylists)),
          // Watch Later
          Tab(child: Text(Languages.of(context)!.labelFavorites)),
        ],
      ),
    );
  }
  
  Widget _body() {
    ContentProvider contentProvider = Provider.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: TabBarView(
        key: ValueKey((contentProvider.searchContent != null || contentProvider.searchingContent) ? 'tabBar5' : 'tabBar4'),
        controller: tabController,
        children: [
          if (contentProvider.searchContent != null || contentProvider.searchingContent)
          const SearchPage(),
          // Trending Page
          const TrendingPage(),
          // Subscriptions Page
          const SubscriptionsPage(),
          // Video Playlists Page
          const VideoPlaylistPage(),
          // Favorites Page
          const FavoritesPage(),
        ]
      ),
    );
  }

}