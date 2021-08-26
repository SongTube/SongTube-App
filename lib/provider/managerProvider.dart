// Dart
import 'dart:async';

// Flutter
import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/extractors/playlist.dart';
import 'package:newpipeextractor_dart/extractors/search.dart';
import 'package:newpipeextractor_dart/extractors/trending.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:newpipeextractor_dart/models/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:songtube/internal/models/subscription.dart';

enum HomeScreenTab { Trending, Music, Favorites, WatchLater }

class ManagerProvider extends ChangeNotifier {

  // ----------------
  // Initialize Class
  // ----------------
  //
  ManagerProvider() {
    // Variables
    searchBarFocusNode = FocusNode();
    searchController = new TextEditingController();
    // HomeScreen
    homeScrollController = ScrollController();
    // Home Screen
    currentHomeTab = HomeScreenTab.Trending;
    homeTrendingVideoList = [];
    homeMusicVideoList = [];
    searchRunning = false;
    TrendingExtractor.getTrendingVideos().then((value) {
      homeTrendingVideoList = value;
      notifyListeners();
    });
    PlaylistExtractor.getPlaylistStreams(
      'https://www.youtube.com/playlist?list=PLFgquLnL59akA2PflFpeQG9L01VFg90wS'
    ).then((value) {
      homeMusicVideoList = value;
      notifyListeners();
    });
    loadChannelsFeed();
  }

  // -------------
  // App Variables
  // -------------
  //
  // Library
  GlobalKey? _internalScaffoldKey;
  GlobalKey? _scaffoldStateKey;
  // Home Screen
  ScrollController? homeScrollController;
  // Navitate Screen
  String? youtubeSearchQuery;
  // SearchBar
  FocusNode? searchBarFocusNode;

  // Current search filters
  List<String> searchFilters = [];

  // -----------
  // Home Screen
  // -----------
  late bool searchRunning;
  YoutubeSearch? youtubeSearch;
  Future<void> searchYoutube({String? query, bool forceReload = false}) async {
    searchRunning = true;      
    notifyListeners();
    if (query == null) return null;
    if (youtubeSearch == null) {
      youtubeSearch = await SearchExtractor.searchYoutube(query, searchFilters);
      notifyListeners();
    } else if (youtubeSearch != null && forceReload) {
      youtubeSearch = null;
      notifyListeners();
      youtubeSearch = await SearchExtractor.searchYoutube(query, searchFilters);
      notifyListeners();
    } else if (youtubeSearch != null) {
      await youtubeSearch!.getNextPage();
      notifyListeners();
    }
    searchRunning = false;
    notifyListeners();
  }

  HomeScreenTab? _currentHomeTab;
  HomeScreenTab? get currentHomeTab => _currentHomeTab;
  set currentHomeTab(HomeScreenTab? tab) {
    _currentHomeTab = tab;
    notifyListeners();
  }
  // Trending Video List
  List<StreamInfoItem>? homeTrendingVideoList;
  // Music Video List
  List<StreamInfoItem>? homeMusicVideoList;

  // ---------------
  // SearchBar TextController
  //
  TextEditingController? searchController;
  // ----------------------------------

  void setState() {
    notifyListeners();
  }

  // -------------------
  // Getters and Setters
  // -------------------
  //
  // Library
  GlobalKey? get internalScaffoldKey => _internalScaffoldKey;
  set internalScaffoldKey(GlobalKey? key) {
    _internalScaffoldKey = key;
    notifyListeners();
  }
  // Library
  GlobalKey? get scaffoldStateKey => _scaffoldStateKey;
  set scaffoldStateKey(GlobalKey? key) {
    _scaffoldStateKey = key;
    notifyListeners();
  }
  bool get showSearchBar {
    if (youtubeSearch != null) {
      return true;
    } else if (searchBarFocusNode!.hasFocus) {
      return true;
    } else if (searchRunning) {
      return true;
    } else {
      return false;
    }
  }

  // -------------
  // Channels Feed
  // -------------
  // 
  // Feed list
  List<StreamInfoItem> channelsFeedList = [];
  // Extract feed from the first 10 channels
  // by channel subscription date order
  Future<void> loadChannelsFeed() async {
    // Clear current channels feed
    channelsFeedList = [];
    notifyListeners();
    // Extract current subscriptions
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ChannelSubscription> channels = ChannelSubscription
      .fromJsonList(prefs.getString('subscriptions'));
    if (channels.isNotEmpty) {
      List<StreamInfoItem> videos = [];
      // Take all uploads from the first 10 channels
      int loopsDone = 0;
      for (var channel in channels) {
        if (loopsDone == 10) break;
        List<StreamInfoItem> uploads = await ChannelExtractor
          .getChannelUploads(channel.url!);
        videos.addAll(uploads);
        loopsDone++;
      }
      // Sort by date (Default)
      videos.sort((a, b) => DateTime.parse(a.date!).compareTo(DateTime.parse(b.date!)));
      videos = videos.reversed.toList();
      // Update our channels feed
      channelsFeedList = videos;
      notifyListeners();
    }
  }
  

}