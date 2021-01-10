// Dart
import 'dart:async';

// Flutter
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:songtube/internal/models/infoSets/mediaInfoSet.dart';

// Internal
import 'package:songtube/internal/youtube/youtubeExtractor.dart';

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
    // Library Scaffold Key
    _libraryScaffoldKey = new GlobalKey<ScaffoldState>();
    _screenIndex        = 0;
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

  // YoutubeExtractor
  YoutubeExtractor youtubeExtractor;

  // ---------------------
  // Stream Youtube Player
  // ---------------------
  StreamManifest playerStream;

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
  // Get current Video or Playlist
  void updateMediaInfoSet(dynamic searchMedia, List<Video> relatedVideos) {
    mediaInfoSet = MediaInfoSet();
    playerStream = null;
    notifyListeners();
    if (searchMedia is Video) {
      Video video = searchMedia;
      mediaInfoSet.mediaType = MediaInfoSetType.Video;
      mediaInfoSet.videoFromSearch = SearchVideo(
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
      VideoId id = mediaInfoSet.videoFromSearch.videoId;
      mediaInfoSet.updateVideoDetails(video);
      notifyListeners();
      // Get the Channel Details
      youtubeExtractor.getChannelByVideoId(id).then((value) {
        mediaInfoSet.channelDetails = value;
        notifyListeners();
      });
      // Get Related videos
      if (relatedVideos == null) {
        youtubeExtractor.getChannelVideos(id)
          .then((value) {
            mediaInfoSet.relatedVideos = value;
            notifyListeners();
        });
      } else {
        mediaInfoSet.relatedVideos = relatedVideos;
        notifyListeners();
      }
      // Get the StreamManifest for Downloads
      youtubeExtractor.getStreamManifest(id).then((value) {
        mediaInfoSet.streamManifest = value;
        playerStream = value;
        notifyListeners();
      });
    } else if (searchMedia is SearchVideo) {
      // Get current Search Video and update the YoutubePlayerController
      mediaInfoSet.mediaType = MediaInfoSetType.Video;
      mediaInfoSet.videoFromSearch = searchMedia;
      VideoId id = mediaInfoSet.videoFromSearch.videoId;
      notifyListeners();
      // Get the Video Details from our Search
      youtubeExtractor.getVideoDetails(id).then((value) {
        mediaInfoSet.updateVideoDetails(value);
        notifyListeners();
      });
      // Get the Channel Details without waiting for it's result
      youtubeExtractor.getChannelByVideoId(id).then((value) {
        mediaInfoSet.channelDetails = value;
        notifyListeners();
      });
      // Get Related videos
      if (relatedVideos == null) {
        youtubeExtractor.getChannelVideos(mediaInfoSet.videoFromSearch.videoId)
          .then((value) {
            mediaInfoSet.relatedVideos = value;
            notifyListeners();
        });
      } else {
        mediaInfoSet.relatedVideos = relatedVideos;
        notifyListeners();
      }
      notifyListeners();
    } else if (searchMedia is Playlist) {
      Playlist playlist = searchMedia;
      mediaInfoSet.mediaType = MediaInfoSetType.Playlist;
      mediaInfoSet.playlistFromSearch = SearchPlaylist(
        playlist.id,
        playlist.title,
        null,
      );
      mediaInfoSet.updatePlaylistDetails(playlist);
      notifyListeners();
      // Get the Playlist Videos from our Details
      youtubeExtractor.getPlaylistVideos(playlist.id).then((value) {
        mediaInfoSet.playlistVideos = value;
        updateStreamManifestPlayer(value[0].id);
        notifyListeners();
      });
    } else {
      // Get current Search Playlist
      mediaInfoSet.mediaType = MediaInfoSetType.Playlist;
      mediaInfoSet.playlistFromSearch = searchMedia;
      PlaylistId id = mediaInfoSet.playlistFromSearch.playlistId;
      notifyListeners();
      // Get the Playlist Details from our Search and update Thumbnail
      youtubeExtractor.getPlaylistDetails(id).then((value) {
        mediaInfoSet.updatePlaylistDetails(value);
        notifyListeners();
      });
      notifyListeners();
      // Get the Playlist Videos from our Details
      youtubeExtractor.getPlaylistVideos(id).then((value) {
        mediaInfoSet.playlistVideos = value;
        updateStreamManifestPlayer(value[0].id);
        notifyListeners();
      });
    }
  }

  // Manually update Stream Youtube Player
  void updateStreamManifestPlayer(VideoId id) {
    playerStream = null;
    notifyListeners();
    youtubeExtractor.getStreamManifest(id).then((value) {
      playerStream = value;
      notifyListeners();
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
  // Update Stream Video Player
  void streamPlayerAutoPlay() {
    if (mediaInfoSet.mediaType == MediaInfoSetType.Video) {
      int currentIndex = mediaInfoSet.autoPlayIndex;
      if (currentIndex <= mediaInfoSet.relatedVideos.length-1) {
        updateMediaInfoSet(
          mediaInfoSet.relatedVideos[currentIndex+1],
          mediaInfoSet.relatedVideos
        );
        mediaInfoSet.autoPlayIndex += 1;
      }
    } else {
      int currentIndex = mediaInfoSet.autoPlayIndex;
      if (currentIndex <= mediaInfoSet.playlistVideos.length-1) {
        updateMediaInfoSet(
          mediaInfoSet.playlistVideos[currentIndex+1],
          mediaInfoSet.relatedVideos
        );
        mediaInfoSet.autoPlayIndex += 1;
      }
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