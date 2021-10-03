import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:songtube/internal/globals.dart';
import 'package:songtube/internal/models/playlist.dart';
import 'package:songtube/internal/models/subscription.dart';

class PreferencesProvider extends ChangeNotifier {

  // Favorites Videos
  List<StreamInfoItem> get favoriteVideos {
    var map = jsonDecode(globalPrefs.getString('newFavoriteVideos') ?? "{}");
    List<StreamInfoItem> videos = [];
    if (map.isNotEmpty) {
      if (map['favoriteVideos'].isNotEmpty) {
        map['favoriteVideos'].forEach((v) {
          videos.add(StreamInfoItem.fromMap(v));
        });
      }
    }
    return videos;
  }
  set favoriteVideos(List<StreamInfoItem> videos) {
    var map = videos.map((e) {
      return e.toMap();
    }).toList();
    String json = jsonEncode({ 'favoriteVideos': map });
    globalPrefs.setString('newFavoriteVideos', json).then((_) {
      notifyListeners();
    });
  }
  bool favoriteHasVideo(StreamInfoItem stream) {
    List<StreamInfoItem> videos = favoriteVideos;
    int index = videos.indexWhere((element) => element.id == stream.id);
    if (index == -1) {
      return false;
    } else {
      return true;
    }
  }

  // Watch Later Videos
  List<StreamInfoItem> get watchLaterVideos {
    var map = jsonDecode(globalPrefs.getString('newWatchLaterList') ?? "{}");
    List<StreamInfoItem> videos = [];
    if (map.isNotEmpty) {
      if (map['watchLaterList'].isNotEmpty) {
        map['watchLaterList'].forEach((v) {
          videos.add(StreamInfoItem.fromMap(v));
        });
      }
    }
    return videos;
  }
  set watchLaterVideos(List<StreamInfoItem> videos) {
    var map = videos.map((e) {
      return e.toMap();
    }).toList();
    String json = jsonEncode({ 'watchLaterList': map });
    globalPrefs.setString('newWatchLaterList', json).then((_) {
      notifyListeners();
    });
  }
  bool watchLaterHasVideo(StreamInfoItem stream) {
    List<StreamInfoItem> videos = watchLaterVideos;
    int index = videos.indexWhere((element) => element.id == stream.id);
    if (index == -1) {
      return false;
    } else {
      return true;
    }
  }

  // View History Videos
  List<StreamInfoItem> get viewHistory {
    var map = jsonDecode(globalPrefs.getString('newViewHistory') ?? "{}");
    List<StreamInfoItem> videos = [];
    if (map.isNotEmpty) {
      if (map['viewHistory'].isNotEmpty) {
        map['viewHistory'].forEach((v) {
          videos.add(StreamInfoItem.fromMap(v));
        });
      }
    }
    return videos;
  }
  set addVideoToViewHistory(StreamInfoItem video) {
    List<StreamInfoItem> videos = viewHistory;
    videos.add(video);
    var map = videos.map((e) {
      return e.toMap();
    }).toList();
    String json = jsonEncode({ 'viewHistory': map });
    globalPrefs.setString('newViewHistory', json).then((_) {
      notifyListeners();
    });
  }

  // Join Telegram Dialog
  bool get showJoinTelegramDialog {
    return globalPrefs.getBool('joinTelegramDialog') ?? true;
  }
  set showJoinTelegramDialog(bool value) {
    globalPrefs.setBool('joinTelegramDialog', value);
  }
  // Remind Later
  bool remindTelegramLater = false;

  // Enable/Disable App's BlurUI
  bool get enableBlurUI {
    return globalPrefs.getBool('enable_BlurUI') ?? false;
  }
  set enableBlurUI(bool value) {
    globalPrefs.setBool('enable_BlurUI', value);
    notifyListeners();
  }

  bool get enablePlayerBlurBackground {
    return globalPrefs?.getBool('enablePlayerBlurBackground') ?? true;
  }
  set enablePlayerBlurBackground(bool value) {
    globalPrefs.setBool('enablePlayerBlurBackground', value);
    notifyListeners();
  }

  // MusicPlayer Artwork Rounded Corners
  double get musicPlayerArtworkRoundCorners {
    return globalPrefs.getDouble('musicPlayerArtworkRoundCorners') ?? 20;
  }
  set musicPlayerArtworkRoundCorners(double value) {
    globalPrefs.setDouble('musicPlayerArtworkRoundCorners', value);
    notifyListeners();
  }

  // Youtube Auto-Play
  bool get youtubeAutoPlay {
    return globalPrefs.getBool('youtubeAutoPlay') ?? true;
  }
  set youtubeAutoPlay(bool value) {
    globalPrefs.setBool('youtubeAutoPlay', value);
    notifyListeners();
  }

  // --------------
  // Watch History
  // --------------
  List<StreamInfoItem> get watchHistory {
    String json = globalPrefs.getString('newWatchHistory');
    if (json == null) return [];
    var map = jsonDecode(json);
    List<StreamInfoItem> history = [];
    if (map.isNotEmpty) {
      map.forEach((element) {
        history.add(StreamInfoItem.fromMap(element));
      });
    }
    return history;
  }
  set watchHistory(List<StreamInfoItem> history) {
    List<Map<dynamic, dynamic>> map =
      history.map((e) => e.toMap()).toList();
    globalPrefs.setString('newWatchHistory', jsonEncode(map));
    notifyListeners();
  }
  void watchHistoryInsert(dynamic video) {
    if (enableWatchHistory) {
      List<StreamInfoItem> history = watchHistory;
      history.add(video);
      watchHistory = history;
    }
  }
  // Delete an video from Watch History
  void deleteFromWatchHistory(StreamInfoItem item) {
    final history = List<StreamInfoItem>.from(watchHistory);
    if (history.any((element) => element.id == item.id)) {
      history.removeWhere((element) => element.id == item.id);
    }
    watchHistory = history;
  }
  // Enable/Disable Watch History
  bool get enableWatchHistory {
    return globalPrefs.getBool('enableWatchHistory') ?? true;
  }
  set enableWatchHistory(bool value) {
    globalPrefs.setBool('enableWatchHistory', value).then((_) {
      notifyListeners();
    });
  }

  // ------------------------------------
  // Stream Playlists Creation/Management
  // ------------------------------------
  set streamPlaylists(List<StreamPlaylist> playlists) {
    String json = StreamPlaylist.listToJson(playlists);
    globalPrefs.setString('playlists', json);
    notifyListeners();
  }
  List<StreamPlaylist> get streamPlaylists {
    String json = globalPrefs.getString('playlists') ?? "";
    return StreamPlaylist.fromJsonList(json);
  }
  void streamPlaylistCreate(String playlistName, String author, List<StreamInfoItem> streams) {
    StreamPlaylist playlist = StreamPlaylist(
      name: playlistName,
      author: author,
      streams: streams,
      favorited: false
    );
    List<StreamPlaylist> playlists = streamPlaylists;
    playlists.add(playlist);
    streamPlaylists = playlists;
  }
  void streamPlaylistRemove(String playlistName) {
    List<StreamPlaylist> playlists = streamPlaylists;
    int index = playlists.indexWhere((element) => element.name == playlistName);
    if (index == -1) return;
    playlists.removeAt(index);
    streamPlaylists = playlists;
  }
  void streamPlaylistsInsertStream(String playlistName, StreamInfoItem stream) {
    List<StreamPlaylist> playlists = streamPlaylists;
    int index = playlists.indexWhere((element) => element.name == playlistName);
    if (index == -1) return;
    playlists[index].streams.add(stream);
    streamPlaylists = playlists;
  }
  void streamPlaylistRemoveStream(String playlistName, StreamInfoItem stream) {
    List<StreamPlaylist> playlists = streamPlaylists;
    int index = playlists.indexWhere((element) => element.name == playlistName);
    if (index == -1) return;
    playlists[index].streams.removeWhere((element) => element.id == stream.id);
    if (playlists[index].streams.isEmpty) {
      playlists.removeAt(index);
    }
    streamPlaylists = playlists;
  }
  bool streamPlaylistHasStream(String playlistName, StreamInfoItem stream) {
    List<StreamPlaylist> playlists = streamPlaylists;
    int playlistIndex = playlists.indexWhere((element) => element.name == playlistName);
    if (playlistIndex == -1) return false;
    StreamPlaylist playlist = playlists[playlistIndex];
    int streamIndex = playlist.streams.indexWhere((element) => element.id == stream.id);
    if (streamIndex == -1) {
      return false;
    } else {
      return true;
    }
  }

  // Youtube Player last set quality
  String get youtubePlayerQuality {
    return globalPrefs.getString('youtubePlayerQuality') ?? "720";
  }
  set youtubePlayerQuality(String quality) {
    globalPrefs.setString('youtubePlayerQuality', quality);
    notifyListeners();
  }

  // Channel Subscriptions
  List<ChannelSubscription> get channelSubscriptions {
    String json = globalPrefs.getString('subscriptions') ?? "";
    return ChannelSubscription.fromJsonList(json);
  }
  set channelSubscriptions(List<ChannelSubscription> subscriptions) {
    globalPrefs.setString('subscriptions', ChannelSubscription.toJsonList(subscriptions));
    notifyListeners();
  }
  void removeChannelSubscription(String channelUrl) {
    var subscriptions = channelSubscriptions;
    subscriptions.removeWhere((element) => element.url == channelUrl);
    channelSubscriptions = subscriptions;
  }
  void addChannelSubscription(ChannelSubscription subscription) {
    var subscriptions = channelSubscriptions;
    subscriptions.add(subscription);
    channelSubscriptions = subscriptions;
  }
  void enableChannelNotifications(String channelUrl) {
    var subscriptions = channelSubscriptions;
    int index = subscriptions.indexWhere((element) => element.url == channelUrl);
    subscriptions[index].enableNotifications = !subscriptions[index].enableNotifications;
    channelSubscriptions = subscriptions;
  }

  // Maximum simultaneous downloads
  int get maxSimultaneousDownloads {
    return globalPrefs.getInt('maxSimultaneousDownloads') ?? 2;
  }
  set maxSimultaneousDownloads(int value) {
    globalPrefs.setInt('maxSimultaneousDownloads', value);
    notifyListeners();
  }

  // Enable/Disable Video Autoplay (Video page)
  bool get videoPageAutoPlay {
    return globalPrefs.getBool('videoPageAutoPlay') ?? true;
  }
  set videoPageAutoPlay(bool value) {
    globalPrefs.setBool('videoPageAutoPlay', value);
    notifyListeners();
  }

  // Enable/Disable Automatic PiP Mode
  bool get autoPipMode {
    return globalPrefs.getBool('autoPipMode') ?? true;
  }
  set autoPipMode(bool value) {
    globalPrefs.setBool('autoPipMode', value);
    notifyListeners();
  }
  
  // Enable/Disable Autocorrect in Home search bar
  bool get autocorrectSearchBar {
    return globalPrefs.getBool('autocorrectSearchBar') ?? true;
  }
  set autocorrectSearchBar(bool value) {
    globalPrefs.setBool('autocorrectSearchBar', value);
    notifyListeners();
  }

  // Retrieve/Set Song Playlists
  List<LocalPlaylist> get localPlaylists {
    String json = globalPrefs.getString('localPlaylists');
    return LocalPlaylist.fromJsonList(json);
  }
  set localPlaylists(List<LocalPlaylist> playlists) {
    globalPrefs.setString('localPlaylists', LocalPlaylist.listToJson(playlists));
    notifyListeners();
  }
  // -----------------------
  // Manage Local Playlists
  // -----------------------
  //
  // Create Playlist
  void createLocalPlaylist(String name, List<MediaItem> songs) {
    final list = List<LocalPlaylist>.from(localPlaylists);
    list.add(LocalPlaylist(
      id: Random().nextInt(999999).toString(),
      name: name,
      songs: songs
    ));
    localPlaylists = list;
  }
  // Delete Playlist
  void deleteLocalPlaylist(String id) {
    if (localPlaylists.isNotEmpty) {
      final list = List<LocalPlaylist>.from(localPlaylists);
      list.removeWhere((element) => element.id == id);
      localPlaylists = list;
    }
  }
  // Delete Song from Playlist
  void localPlaylistDeleteSong(String id, MediaItem song) {
    if (localPlaylists.isNotEmpty) {
      final list = List<LocalPlaylist>.from(localPlaylists);
      final index = list.indexWhere((element) => element.id == id);
      if (list[index].songs.any((element) => element.id == song.id)) {
        list[index].songs.removeWhere((element) => element.id == song.id);
      }
      localPlaylists = list;
    }
  }
  // Add song to Playlist
  void localPlaylistAddSong(String id, MediaItem song) {
    if (localPlaylists.isNotEmpty) {
      final list = List<LocalPlaylist>.from(localPlaylists);
      final index = list.indexWhere((element) => element.id == id);
      list[index].songs.add(song);
      localPlaylists = list;
    }
  }

}