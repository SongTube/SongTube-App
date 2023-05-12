import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/screens/home/home_music/pages/albums_page.dart';
import 'package:songtube/screens/home/home_music/pages/artists_page.dart';
import 'package:songtube/screens/home/home_music/pages/home_page.dart';
import 'package:songtube/screens/home/home_music/pages/music_page.dart';
import 'package:songtube/screens/home/home_music/pages/playlists_page.dart';
import 'package:songtube/screens/home/home_music/pages/search_page.dart';
import 'package:songtube/ui/animations/blue_page_route.dart';
import 'package:songtube/ui/components/custom_inkwell.dart';
import 'package:songtube/ui/rounded_tab_indicator.dart';
import 'package:songtube/ui/text_styles.dart';

class HomeMusic extends StatefulWidget {
  const HomeMusic({Key? key}) : super(key: key);

  @override
  State<HomeMusic> createState() => _HomeMusicState();
}

class _HomeMusicState extends State<HomeMusic> with TickerProviderStateMixin {

  // TabBar Controller
  late TabController tabController = TabController(length: 5, vsync: this, initialIndex: AppSettings.defaultLandingMusicPage);

  MediaItem? latestEvent;

  // Search Query
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  bool get searching => searchController.text.trim().isNotEmpty;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      audioHandler.mediaItem.listen((event) {
        if (event != null && latestEvent != event) {
          SongItem.fromMediaItem(event).addPlayCount();
          if (mounted) {
            setState(() {});
          }
        }
        latestEvent = event;
      });
      audioHandler.playbackState.listen((event) {
        if (mounted) {
          setState(() {});
        }
      });
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //   systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      //   statusBarColor: Colors.transparent,
      //   statusBarIconBrightness: Theme.of(context).brightness,
      //   statusBarBrightness: Theme.of(context).brightness
      // ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top+8),
          SizedBox(
            height: kToolbarHeight-8,
            child: _appBar()),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: searching ? Container(padding: const EdgeInsets.only(top: 12)) : _tabs(),
          ),
          Divider(height: 1, color: Theme.of(context).dividerColor),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.only(left: 16),
      height: kToolbarHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.05),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Icon(Iconsax.search_normal, size: 18),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                enabled: true,
                focusNode: searchFocusNode,
                controller: searchController,
                style: smallTextStyle(context).copyWith(fontWeight: FontWeight.w500),
                decoration: InputDecoration.collapsed(
                  hintStyle: smallTextStyle(context, opacity: 0.4).copyWith(fontWeight: FontWeight.w500),
                  hintText: 'Search anything...'),
                onChanged: (_) {
                  setState(() {});
                },
              ),
            ),
            if (searchController.text.trim().isNotEmpty)
            CustomInkWell(
              onTap: () {
                searchController.clear();
                searchFocusNode.unfocus();
                setState(() {});
              },
              child: Icon(Icons.clear, color: Theme.of(context).iconTheme.color, size: 18),
            ),
            const SizedBox(width: 16),
          ],
        ),
      )
    );
  }

  Widget _appBar() {
    return _searchBar();
  }

  Widget _tabs() {
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
        tabs: const [
          // Home
          Tab(child: Text('Recents')),
          // Music
          Tab(child: Text('Music')),
          // Playlists
          Tab(child: Text('Playlist')),
          // Albums
          Tab(child: Text('Album')),
          // Artists
          Tab(child: Text('Artist')),
        ],
      ),
    );
  }

  Widget _body() {
    MediaProvider mediaProvider = Provider.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: mediaProvider.fetchMediaRunning && mediaProvider.songs.isEmpty
        ? Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)),
              const SizedBox(height: 8),
              Text('Fetching songs', style: textStyle(context)),
              Text('Please wait a moment...', style: subtitleTextStyle(context, opacity: 0.6))
            ],
          ))
        : Stack(
            children: [
              _tabBar(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                reverseDuration: const Duration(milliseconds: 200),
                switchInCurve: Curves.ease,
                child: searching ? _searchBox() : const SizedBox(),
              )
            ],
          )
    );
  }

  Widget _tabBar() {
    return TabBarView(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      children: [
        // Home
        HomePage(onSwitchIndex: (index) => tabController.animateTo(3)),
        // Music
        const MusicPage(),
        // Playlists
        const PlaylistsPage(),
        // Albums
        const AlbumsPage(),
        // Artists
        const ArtistsPage(),
      ]
    );
  }

  Widget _searchBox() {
    return MusicSearchPage(searchController: searchController);
  }

}