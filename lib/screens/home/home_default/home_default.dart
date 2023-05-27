import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:iconsax/iconsax.dart';
import 'package:newpipeextractor_dart/utils/url.dart';
import 'package:provider/provider.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/screens/home/home_default/pages/favorites_page.dart';
import 'package:songtube/screens/home/home_default/pages/search_page.dart';
import 'package:songtube/screens/home/home_default/pages/subscriptions_page.dart';
import 'package:songtube/screens/home/home_default/pages/trending_page.dart';
import 'package:songtube/screens/home/home_default/pages/video_playlists_page.dart';
import 'package:songtube/ui/animations/show_up.dart';
import 'package:songtube/ui/components/custom_inkwell.dart';
import 'package:songtube/ui/components/nested_will_pop_scope.dart';
import 'package:songtube/ui/rounded_tab_indicator.dart';
import 'package:songtube/ui/search_suggestions.dart';
import 'package:songtube/ui/sheets/search_filters.dart';
import 'package:songtube/ui/text_styles.dart';

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
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top+8),
          SizedBox(
            height: kToolbarHeight-8,
            child: _appBar()),
          _tabs(),
          Divider(height: 1.5, color: Theme.of(context).dividerColor.withOpacity(0.08), thickness: 1.5),
          Expanded(
            child: Stack(
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
            )
          ),
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
            height: kToolbarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.05),
            ),
            child: CustomInkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                uiProvider.homeSearchNode.requestFocus();
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset(
                      DateTime.now().month == 12
                        ? 'assets/images/logo_christmas.png'
                        : 'assets/images/ic_launcher.png',
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(right: 16),
                      height: kToolbarHeight,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            const Icon(Iconsax.search_normal, size: 18),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                enabled: true,
                                focusNode: uiProvider.homeSearchNode,
                                controller: searchController,
                                style: smallTextStyle(context).copyWith(fontWeight: FontWeight.w500),
                                decoration: InputDecoration.collapsed(
                                  hintStyle: smallTextStyle(context, opacity: 0.4).copyWith(fontWeight: FontWeight.w500),
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
                              child: Icon(Icons.clear, color: Theme.of(context).iconTheme.color, size: 18),
                            ),
                            FutureBuilder<String?>(
                              future: clipboardLink(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: CustomInkWell(
                                      onTap: () {
                                        contentProvider.loadVideoPlayer(snapshot.data);
                                      },
                                      child: Icon(Icons.link_rounded, color: Theme.of(context).primaryColor, size: 18),
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
            showModalBottomSheet(
              context: internalNavigatorKey.currentContext!,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => SearchFiltersSheet());
          },
          icon: Icon(Iconsax.filter_edit, size: 18, color: contentProvider.searchFilters.isNotEmpty ? Theme.of(context).primaryColor : null)),
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
        labelColor: Theme.of(context).textTheme.bodyText1!.color,
        unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
        labelStyle: smallTextStyle(context).copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.4),
        unselectedLabelStyle: smallTextStyle(context).copyWith(fontWeight: FontWeight.normal, letterSpacing: 0.4),
        physics: const BouncingScrollPhysics(),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: RoundedTabIndicator(color: Theme.of(context).primaryColor, height: 3, radius: 100, bottomMargin: 0),
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
        physics: const BouncingScrollPhysics(),
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