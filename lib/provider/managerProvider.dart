// Dart
import 'dart:async';
import 'dart:convert';

// Flutter
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:songtube/internal/models/infoSets/mediaInfoSet.dart';

// Internal
import 'package:songtube/internal/youtube/youtubeExtractor.dart';
import 'package:video_player/video_player.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

enum HomeScreenTab { Home, Trending, Music, Favorites, WatchLater }

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
    // Home Screen
    currentHomeTab = HomeScreenTab.Home;
    homeTrendingVideoList = [];
    homeMusicVideoList = [];
    youtubeSearchQuery = lastSearchQuery;
    searchStreamRunning = false;
    searchResultsLength = 10;
    updateYoutubeSearchResults();
    // YoutubeExtractor
    youtubeExtractor = YoutubeExtractor();
  }

  // -------------
  // App Variables
  // -------------
  //
  // Library
  GlobalKey _internalScaffoldKey;
  GlobalKey _scaffoldStateKey;
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

  // YoutubeExtractor
  YoutubeExtractor youtubeExtractor;

  // -----------------------------
  // Controller for Youtube Player
  // -----------------------------
  VideoPlayerController playerController;

  // -----------
  // Home Screen
  // -----------
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
  HomeScreenTab _currentHomeTab;
  HomeScreenTab get currentHomeTab => _currentHomeTab;
  set currentHomeTab(HomeScreenTab tab) {
    _currentHomeTab = tab;
    notifyListeners();
    if (tab == HomeScreenTab.Trending && homeTrendingVideoList.isEmpty) {
      youtubeExtractor.getPlaylistVideos(
        PlaylistId('PLrEnWoR732-BHrPp_Pm8_VleD68f9s14-')
      ).then((value) {
        homeTrendingVideoList = value;
        notifyListeners();
      });
    }
    if (tab == HomeScreenTab.Music && homeMusicVideoList.isEmpty) {
      youtubeExtractor.getPlaylistVideos(
        PlaylistId('PLFgquLnL59akA2PflFpeQG9L01VFg90wS')
      ).then((value) {
        homeMusicVideoList = value;
        notifyListeners();
      });
    }
  }
  // Trending Video List
  List<Video> homeTrendingVideoList;
  // Music Video List
  List<Video> homeMusicVideoList;

  // ---------------
  // URL Controller
  //
  TextEditingController urlController;
  // ----------------------------------

  // -------------------
  // Functions & Helpers
  // -------------------
  //
  // Get current Video or Playlist ID
  dynamic getIdFromSearchResult(dynamic searchResult) {
    if (searchResult is Video) {
      return searchResult.id;
    } else if (searchResult is SearchVideo) {
      return searchResult.videoId;
    } else if (searchResult is Playlist) {
      return searchResult.id;
    } else {
      return searchResult.playlistId;
    }
  }

  // Transform a Video object to SearchVideo
  SearchVideo videoToSearchVideo(Video video) {
    return SearchVideo(
      VideoId(video.id.value),
        video.title, video.author,
        null, null, null,
        [
          Thumbnail(Uri(
            path: video.thumbnails.highResUrl
              .replaceAll("https://i.ytimg.com", "")
              .replaceAll("https://img.youtube.com", "")
          ), null, null)
        ]
    );
  }


  // Update the current SearchVideo/Video or SearchPlaylist/Playlist
  // for details, engage and tags
  Future<void> updateBySearchResult(dynamic searchResult) async {
    if (searchResult is Video) {
      Video video = searchResult;
      mediaInfoSet.mediaType = MediaInfoSetType.Video;
      notifyListeners();
      mediaInfoSet.videoFromSearch = videoToSearchVideo(video);
      mediaInfoSet.updateVideoDetails(video);
      saveToHistory(video);
      notifyListeners();
    } else if (searchResult is SearchVideo) {
      mediaInfoSet.mediaType = MediaInfoSetType.Video;
      notifyListeners();
      mediaInfoSet.videoFromSearch = searchResult;
      VideoId id = mediaInfoSet.videoFromSearch.videoId;
      notifyListeners();
      // Get the Video Details from our Search
      Video video = await youtubeExtractor.getVideoDetails(id);
      mediaInfoSet.updateVideoDetails(video);
      saveToHistory(video);
      notifyListeners();
    } else if (searchResult is SearchPlaylist) {
      mediaInfoSet.mediaType = MediaInfoSetType.Playlist;
      notifyListeners();
      mediaInfoSet.playlistFromSearch = searchResult;
      PlaylistId id = mediaInfoSet.playlistFromSearch.playlistId;
      notifyListeners();
      youtubeExtractor.getPlaylistDetails(id).then((value) {
        mediaInfoSet.updatePlaylistDetails(value);
        notifyListeners();
      });
      notifyListeners();
    } else {
      Playlist playlist = searchResult;
      mediaInfoSet.mediaType = MediaInfoSetType.Playlist;
      notifyListeners();
      mediaInfoSet.playlistFromSearch = SearchPlaylist(
        playlist.id,
        playlist.title,
        null,
      );
      mediaInfoSet.updatePlaylistDetails(playlist);
      notifyListeners();
    }
  }

  // Update current Channel from VideoId
  Future<void> updateCurrentChannel(VideoId id) async {
    mediaInfoSet.channelDetails = await youtubeExtractor
      .getChannelByVideoId(id);
    notifyListeners();
  }

  // Get current Related Videos, the ID can be VideoId or PlaylistId
  // if relatedVideos is provided this function will just use that instead
  Future<void> updateCurrentRelatedVideos({dynamic id, List<Video> relatedVideos}) async {
    if (relatedVideos == null) {
      if (id is VideoId) {
        mediaInfoSet.relatedVideos = await youtubeExtractor
          .getChannelVideos(id);
      } else {
        mediaInfoSet.relatedVideos = await youtubeExtractor
          .getPlaylistVideos(id);
      }
      notifyListeners();
    } else {
      mediaInfoSet.relatedVideos = relatedVideos;
    }
    mediaInfoSet.autoPlayIndex = 0;
    notifyListeners();
  }

  // Update current Video StreamManifest
  Future<void> updateCurrentManifest(VideoId id) async {
    if (playerController != null) {
      playerController.pause();
      playerController = null;
    }
    notifyListeners();
    mediaInfoSet.streamManifest = await youtubeExtractor
      .getStreamManifest(id);
    playerController = VideoPlayerController.network(
      mediaInfoSet.streamManifest.muxed.withHighestBitrate().url.toString()
      )..initialize().then((value) {
        playerController.play().then((_) {
          notifyListeners();
        });
    });
  }

  // Search for Videos on Youtube
  void updateYoutubeSearchResults({bool updateResults = false}) async {
    int resultsCounter = 0;
    if (updateResults || youtubeSearchStream == null) {
      searchResultsLength = 10;
      searchStreamRunning = true;
      youtubeSearchResults.clear();
      currentHomeTab = HomeScreenTab.Home;
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

  Future<void> updateMediaInfoSet(dynamic searchResult, List<Video> related) async {
    mediaInfoSet = MediaInfoSet();
    notifyListeners();
    if (expandablePlayerPanelController.isAttached) {
      expandablePlayerPanelController.open();
    }
    var id = getIdFromSearchResult(searchResult);
    if (related != null) {
      updateCurrentRelatedVideos(id: id, relatedVideos: related);
    }
    if (searchResult is SearchVideo || searchResult is Video) {
      if (related != null) {
        updateCurrentRelatedVideos(id: id, relatedVideos: related);
      }
      await updateBySearchResult(searchResult);
      await updateCurrentManifest(id);
      await updateCurrentChannel(id);
      if (related == null)
        await updateCurrentRelatedVideos(id: id);
    } else if (searchResult is Playlist || searchResult is SearchPlaylist) {
      await updateBySearchResult(searchResult);
      if (related == null)
        await updateCurrentRelatedVideos(id: id);
      mediaInfoSet.videoDetails = mediaInfoSet.relatedVideos[0];
      notifyListeners();
      await updateCurrentManifest(
        mediaInfoSet.relatedVideos[0].id
      );
      await updateCurrentChannel(
        mediaInfoSet.relatedVideos[0].id
      );
    }
  }
  
  Future<void> saveToHistory(Video video) async {
    var prefs = await SharedPreferences.getInstance();
    String json = prefs.getString('watchHistory');
    if (json == null) {
      List<Video> videos = [video];
      List<Map<String, dynamic>> map =
      videos.map((e) => e.toMap()).toList();
      prefs.setString('watchHistory', jsonEncode(map));
    } else {
      List<Video> history = [];
      var map = jsonDecode(json);
      if (map.isNotEmpty) {
        map.forEach((element) {
          history.add(Video.fromMap(element));
        });
      }
      if (history.contains(video)) {
        history.removeAt(history.indexWhere((element) => video == element));
        history.insert(0, video);
      } else {
        history.insert(0, video);
      }
      map = history.map((e) => e.toMap()).toList();
      prefs.setString('watchHistory', jsonEncode(map));
    }
  }

  void setState() {
    notifyListeners();
  }

  // -------------------
  // Getters and Setters
  // -------------------
  //
  // Library
  GlobalKey get internalScaffoldKey => _internalScaffoldKey;
  set internalScaffoldKey(GlobalKey key) {
    _internalScaffoldKey = key;
    notifyListeners();
  }
  // Library
  GlobalKey get scaffoldStateKey => _scaffoldStateKey;
  set scaffoldStateKey(GlobalKey key) {
    _scaffoldStateKey = key;
    notifyListeners();
  }
  bool get showSearchBar => _showSearchBar;
  set showSearchBar(bool value) {
    _showSearchBar = value;
    notifyListeners();
  }
}