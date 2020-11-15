// Dart
import 'dart:async';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:songtube/internal/models/tagsControllers.dart';

// Internal
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/internal/randomString.dart';
import 'package:songtube/internal/youtube/youtubeInfo.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// UI
import 'package:songtube/ui/internal/snackbar.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

enum LoadingStatus { Success, Loading, Unload }
enum CurrentLoad { None, SingleVideo, Playlist }
enum LibraryScreen { Home, Downloads, Media, Youtube, More }
enum LinkType { Video, Playlist }

class ManagerProvider extends ChangeNotifier {

  // ----------------
  // Initialize Class
  // ----------------
  //
  ManagerProvider() {
    // Variables
    showEmptyScreenWidget    = true;
    currentLoad              = CurrentLoad.None;
    mediaStreamReady         = false;
    showFloatingActionButtom = false;
    showSearchBar            = false;
    urlController = new TextEditingController();
    tagsControllers = new TagsControllers();
    // Library Scaffold Key
    _libraryScaffoldKey = new GlobalKey<ScaffoldState>();
    _screenIndex        = 0;
    // YouTube Info
    youtubeInfo = new YoutubeInfo();
    // Navigate
    searchStreamRunning = false;
  }

  // -------------
  // App Variables
  // -------------
  //
  // Library
  GlobalKey<ScaffoldState> _libraryScaffoldKey;
  int _screenIndex;
  // Home Screen
  bool showEmptyScreenWidget;
  CurrentLoad _currentLoad;
  LoadingStatus loadingStatus;
  bool mediaStreamReady;
  bool showFloatingActionButtom;
  // Navitate Screen
  String _navigateQuery;
  String get navigateQuery => _navigateQuery == null
    ? RandomString.getRandomLetter()
    : _navigateQuery;
  set navigateQuery(String searchQuery) {
    _navigateQuery = searchQuery;
  }
  // SearchBar
  bool _showSearchBar;

  // Change current Screen
  void navigateToScreen(LibraryScreen screen) {
    switch (screen) {
      case LibraryScreen.Home:
        _screenIndex = 0;
        break;
      case LibraryScreen.Downloads:
        _screenIndex = 1;
        break;
      case LibraryScreen.Media:
        _screenIndex = 2;
        break;
      case LibraryScreen.Youtube:
        _screenIndex = 3;
        break;
      case LibraryScreen.More:
        _screenIndex = 4;
        break;
    }
    _showSearchBar = false;
    notifyListeners();
  }  

  // --------------------------------
  // Current Video and StreamManifest
  // --------------------------------
  StreamManifest streamManifest;
  Video videoDetails;
  TagsControllers tagsControllers;
  // Current Channel
  Channel channelDetails;

  // ----------------
  // Current Playlist
  // ----------------
  Playlist playlistDetails;
  List<Video> playlistVideos = [];

  // -------------------------
  // Youtube Player Controller
  // -------------------------
  YoutubePlayerController youtubePlayerController;

  // ---------------
  // Navigate Screen
  // ---------------
  bool searchStreamRunning;
  StreamSubscription youtubeSearchStream;
  List<dynamic> youtubeSearchResults = [];

  // --------
  // SnackBar
  // --------
  AppSnack snackBar;

  // ---------------
  // URL Controller
  //
  TextEditingController urlController;
  // ----------------------------------

  // -------------------------
  // Other Functions & Helpers
  // -------------------------
  //
  // Search for Videos on Youtube
  void updateYoutubeSearchResults({bool updateResults = false}) async {
    int resultsCounter = 0;
    if (updateResults || youtubeSearchStream == null) {
      searchStreamRunning = true;
      youtubeSearchResults.clear();
      if (youtubeSearchStream != null) {
        await youtubeSearchStream.cancel();
        youtubeSearchStream = null;
      }
      notifyListeners();
      youtubeSearchStream = YoutubeExplode().search
        .getVideosFromPage(navigateQuery)
        .listen((event) {
          youtubeSearchResults.add(event);
          resultsCounter++;
          if (resultsCounter >= 10) {
            youtubeSearchStream.pause();
            searchStreamRunning = false;
            notifyListeners();
          }
        }, cancelOnError: true);
    } else {
      resultsCounter = 0;
      youtubeSearchStream.resume();
    }
  }
  // Update Video Player Controller
  void updateYoutubePlayerController(String id, bool useLoad) {
    if (useLoad) {
      youtubePlayerController.load(id);
    } else {
      youtubePlayerController = new YoutubePlayerController(
        initialVideoId: id,
        params: YoutubePlayerParams(
          autoPlay: true,
          showFullscreenButton: true,
        )
      );
      youtubePlayerController.onEnterFullscreen = () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      };
      youtubePlayerController.onExitFullscreen = () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitDown,
          DeviceOrientation.portraitUp,
        ]);
      };
    }
    notifyListeners();
  }
  // Unload HomeScreen Data
  void updateHomeScreen(LoadingStatus status, [CurrentLoad type]) {
    CurrentLoad loadingType = type == null ? CurrentLoad.None : type;
    switch(status) {
      // Failed to get mediaStream
      case LoadingStatus.Unload:
        showEmptyScreenWidget    = true;
        currentLoad              = loadingType;
        loadingStatus            = LoadingStatus.Unload;
        showFloatingActionButtom = false;
        mediaStreamReady         = false;
        channelDetails           = null;
        youtubePlayerController  = null;
        break;
      // Is loading
      case LoadingStatus.Loading:
        showEmptyScreenWidget    = false;
        currentLoad              = loadingType;
        loadingStatus            = LoadingStatus.Loading;
        showFloatingActionButtom = false;
        mediaStreamReady         = false;
        channelDetails           = null;
        break;
      // Is loaded
      case LoadingStatus.Success:
        currentLoad              = loadingType;
        loadingStatus            = LoadingStatus.Success;
        showFloatingActionButtom = true;
        mediaStreamReady         = true;
        break;
    }
    notifyListeners();
  }
  // Handle incoming intents (Links via share)
  Future<void> handleIntent() async {
    // Return if the a mediaStream is beign loaded
    if (loadingStatus == LoadingStatus.Loading) return;
    // Handle Intent
    String url = await NativeMethod.handleIntent();
    if (url == null) return;
    if (PlaylistId.parsePlaylistId(url) != null) {
      urlController.text = url;
      notifyListeners();
      await getPlaylistDetails(url);
    }
    if (VideoId.parseVideoId(url) != null) {
      urlController.text = url;
      notifyListeners();
      await getVideoDetails(url);
    }
  }
  // Handle Library WillPop
  DateTime _currentBackPressTime;
  Future<bool> handlePop(index) async {
    if (index != 0) {
      _screenIndex = 0;
      notifyListeners();
      return false;
    } else {
      DateTime now = DateTime.now();
      if (_currentBackPressTime == null || 
          now.difference(_currentBackPressTime) > Duration(seconds: 2)) {
        _currentBackPressTime = now;
        snackBar.showSnackBar(
          icon: Icons.warning,
          title: "Press back again to exit",
          duration: Duration(seconds: 1)
        );
        return Future.value(false);
      }
      return Future.value(true);
    }
  }
  // Move to Navigate Screen with a Search Intent
  void pushYoutubePage(String searchQuery) async {
    navigateQuery = searchQuery;
    updateYoutubeSearchResults(updateResults: true);
    navigateToScreen(LibraryScreen.Youtube);
    notifyListeners();
  }

  // -------------------------------------
  // Info & Downloads Management Functions
  // -------------------------------------
  //
  // YouTube Info
  YoutubeInfo youtubeInfo;
  // Get Channel Link
  Future<Channel> getChannel() async {
    return await youtubeInfo.getChannel(urlController.text);
  }
  // Get Playlist Details
  Future<void> getPlaylistDetails(String url) async {
    if (loadingStatus == LoadingStatus.Loading) return null;
    if (PlaylistId.parsePlaylistId(url) == null) return null;
    playlistVideos = [];
    navigateToScreen(LibraryScreen.Home);
    updateHomeScreen(LoadingStatus.Loading, CurrentLoad.Playlist);
    try {
      playlistDetails = await youtubeInfo.getPlaylistDetails(url)
        .timeout(Duration(seconds: 20));
    } catch (_) {
      updateHomeScreen(LoadingStatus.Unload);
      return;
    }
    updateHomeScreen(LoadingStatus.Success, CurrentLoad.Playlist);
    notifyListeners();
    getPlaylistVideos(url);
  }
  // Get Video MediaStreamInfo from Id
  Future<void> getVideoDetails(String url) async {
    if (loadingStatus == LoadingStatus.Loading) return null;
    if (VideoId.parseVideoId(url) == null) return null;
    navigateToScreen(LibraryScreen.Home);
    updateHomeScreen(LoadingStatus.Loading, CurrentLoad.SingleVideo);
    try {
      videoDetails = await youtubeInfo.getVideoDetails(url)
        .timeout(Duration(seconds: 20));
      streamManifest = null;
    } catch (e) {
      updateHomeScreen(LoadingStatus.Unload);
    }
    tagsControllers.updateTextControllers(videoDetails);
    updateHomeScreen(LoadingStatus.Success, CurrentLoad.SingleVideo);
    updateYoutubePlayerController(videoDetails.id.value, false);
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 400));
    getChannelDetails(url);
    getStreamManifest(url);
  }
  // Get StreamManifest
  void getStreamManifest(String url) async {
    while (streamManifest == null) {
      try {
        streamManifest =
          await youtubeInfo.getVideoManifest(url)
            .timeout(Duration(seconds: 30));
        notifyListeners();
      } catch (_) {}
    }
  }
  // Get Channel Details
  void getChannelDetails(String url) async {
    channelDetails = await youtubeInfo.getChannel(url);
    notifyListeners();
  }
  // Playlist Details
  void getPlaylistVideos(String url) async {
    playlistVideos = await youtubeInfo.getPlaylistVideos(url);
    updateYoutubePlayerController(playlistVideos[0].id.value, false);
    notifyListeners();
  }

  // -------------------
  // Getters and Setters
  // -------------------
  //
  // Library
  GlobalKey<ScaffoldState> get libraryScaffoldKey => _libraryScaffoldKey;
  int get screenIndex => _screenIndex;
  set screenIndex(int value) {
    _screenIndex = value;
    _showSearchBar = false;
    notifyListeners();
  }
  // Loading Video
  CurrentLoad get currentLoad => _currentLoad;
  set currentLoad(CurrentLoad value) {
    _currentLoad = value;
    notifyListeners();
  }
  bool get showSearchBar => _showSearchBar;
  set showSearchBar(bool value) {
    _showSearchBar = value;
    notifyListeners();
  }
}