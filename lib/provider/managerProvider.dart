// Dart
import 'dart:async';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:songtube/internal/models/infoSets/mediaInfoSet.dart';
import 'package:songtube/internal/youtube/youtubeExtractor.dart';

// Internal
import 'package:songtube/internal/youtube/youtubeInfo.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// UI
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

enum LoadingStatus { Success, Loading, Unload }
enum LibraryScreen { Home, Downloads, Media, More }
enum LinkType { Video, Playlist }

class ManagerProvider extends ChangeNotifier {

  // ----------------
  // Initialize Class
  // ----------------
  //
  ManagerProvider(lastSearchQuery) {
    // Variables
    showSearchBar            = false;
    searchBarFocusNode = FocusNode();
    urlController = new TextEditingController();
    // HomeScreen
    homeScrollController = ScrollController();
    expandablePlayerPanelController = PanelController();
    // Library Scaffold Key
    _libraryScaffoldKey = new GlobalKey<ScaffoldState>();
    _screenIndex        = 0;
    // YouTube Info
    youtubeInfo = new YoutubeInfo();
    // Navigate
    youtubeSearchQuery = lastSearchQuery;
    searchStreamRunning = false;
    searchResultsLength = 10;
    updateYoutubeSearchResults();
  }

  // -------------
  // App Variables
  // -------------
  //
  // Library
  GlobalKey<ScaffoldState> _libraryScaffoldKey;
  int _screenIndex;
  // Home Screen
  ScrollController homeScrollController;
  PanelController expandablePlayerPanelController;
  // Navitate Screen
  String youtubeSearchQuery;
  // SearchBar
  bool _showSearchBar;
  FocusNode searchBarFocusNode;

  // Current MediaInfoSet (Used to store all the current Media Information
  // for Playback, Tags and Downloads)
  MediaInfoSet mediaInfoSet;

  // -------------------------
  // Youtube Player Controller
  // -------------------------
  YoutubePlayerController youtubePlayerController;
  PlayerState youtubePlayerState;
  YoutubeMetaData youtubePlayerMetadata;

  // ---------------
  // Navigate Screen
  // ---------------
  bool searchStreamRunning;
  StreamSubscription youtubeSearchStream;
  int searchResultsLength;
  List<dynamic> youtubeSearchResults = [];
  void updateSearchResults(newItem) {
    if (youtubeSearchResults.length < searchResultsLength) {
      youtubeSearchResults.add(newItem);
    } else if (youtubeSearchResults.length == searchResultsLength) {
      youtubeSearchResults.add(newItem);
      youtubeSearchStream.pause();
      searchStreamRunning = false;
      searchResultsLength += 10;
      notifyListeners();
    }
  }

  // ---------------
  // URL Controller
  //
  TextEditingController urlController;
  // ----------------------------------

  // -------------------
  // Functions & Helpers
  // -------------------
  //
  // Get current Video or Playlist
  void updateMediaInfoSet(dynamic searchMedia) async {
    mediaInfoSet = MediaInfoSet();
    if (searchMedia is SearchVideo) {
      // Get current Search Video and update the YoutubePlayerController
      mediaInfoSet.mediaType = MediaInfoSetType.Video;
      mediaInfoSet.videoFromSearch = searchMedia;
      String id = mediaInfoSet.videoFromSearch.videoId.value;
      updateYoutubePlayerController(id, true);
      notifyListeners();
      // Get the Video Details from our Search
      mediaInfoSet.updateVideoDetails(
        await youtubeInfo.getVideoDetails(id)
      );
      notifyListeners();
      // Get the Channel Details without waiting for it's result
      YoutubeExtractor().getChannel(id).then((value) {
        mediaInfoSet.channelDetails = value;
        notifyListeners();
      });
      // Get the StreamManifest for Downloads
      mediaInfoSet.streamManifest = await YoutubeExtractor()
        .getStreamManifest(id);
      notifyListeners();
    } else {
      // Get current Search Playlist
      mediaInfoSet.mediaType = MediaInfoSetType.Playlist;
      mediaInfoSet.playlistFromSearch = searchMedia;
      String id = mediaInfoSet.playlistFromSearch.playlistId.value;
      notifyListeners();
      // Get the Playlist Details from our Search and update Thumbnail
      mediaInfoSet.updatePlaylistDetails(
        await youtubeInfo.getPlaylistDetails(id)
      );
      notifyListeners();
      // Get the Playlist Videos from our Details
      // and update the YoutubePlayerController
      mediaInfoSet.playlistVideos = await youtubeInfo.getPlaylistVideos(id);
      updateYoutubePlayerController(
        mediaInfoSet.playlistVideos[0].id.value, true
      );
      notifyListeners();
    }
  }
  // Search for Videos on Youtube
  void updateYoutubeSearchResults({bool updateResults = false}) async {
    int resultsCounter = 0;
    if (updateResults || youtubeSearchStream == null) {
      searchResultsLength = 10;
      searchStreamRunning = true;
      youtubeSearchResults.clear();
      if (youtubeSearchStream != null) {
        await youtubeSearchStream.cancel();
        youtubeSearchStream = null;
      }
      youtubeSearchStream = YoutubeExplode().search
        .getVideosFromPage(youtubeSearchQuery)
        .listen((event) {
          print(resultsCounter);
          resultsCounter++;
          updateSearchResults(event);
        }, cancelOnError: true);
    } else {
      resultsCounter = 0;
      youtubeSearchStream.resume();
    }
  }
  // Update Video Player Controller
  void updateYoutubePlayerController(String id, bool useLoad) {
    if (useLoad && youtubePlayerController != null) {
      youtubePlayerController.load(id);
    } else {
      youtubePlayerController = new YoutubePlayerController(
        initialVideoId: id,
        params: YoutubePlayerParams(
          autoPlay: true,
          showFullscreenButton: true,
          enableJavaScript: true,
        )
      );
      StreamSubscription streamSubscription;
      streamSubscription = youtubePlayerController.listen((event) {
        if (event.isReady) {
          youtubePlayerController.play();
          streamSubscription.cancel();
          notifyListeners();
        }
      });
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
      youtubePlayerController.listen((event) {
        if (youtubePlayerState != event.playerState) {
          youtubePlayerState = event.playerState;
          notifyListeners();
        }
        if (youtubePlayerMetadata != event.metaData) {
          youtubePlayerMetadata = event.metaData;
          notifyListeners();
        }
      });
    }
    notifyListeners();
  }

  // -------------------------------------
  // Info & Downloads Management Functions
  // -------------------------------------
  //
  // YouTube Info
  YoutubeInfo youtubeInfo;
  // Get Channel Link
  

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
  bool get showSearchBar => _showSearchBar;
  set showSearchBar(bool value) {
    _showSearchBar = value;
    notifyListeners();
  }
}