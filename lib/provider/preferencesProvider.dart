import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:songtube/internal/models/playlist.dart';
import 'package:songtube/internal/models/subscription.dart';

class PreferencesProvider extends ChangeNotifier {

  PreferencesProvider(prefsInstance) {
    prefs = prefsInstance;
  }

  // Preferences Instance
  SharedPreferences prefs;

  // Favorites Videos
  List<StreamInfoItem> get favoriteVideos {
    var map = jsonDecode(prefs.getString('newFavoriteVideos') ?? "{}");
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
    prefs.setString('newFavoriteVideos', json).then((_) {
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
    var map = jsonDecode(prefs.getString('newWatchLaterList') ?? "{}");
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
    prefs.setString('newWatchLaterList', json).then((_) {
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
    var map = jsonDecode(prefs.getString('newViewHistory') ?? "{}");
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
    prefs.setString('newViewHistory', json).then((_) {
      notifyListeners();
    });
  }

  // Join Telegram Dialog
  bool get showJoinTelegramDialog {
    return prefs.getBool('joinTelegramDialog') ?? true;
  }
  set showJoinTelegramDialog(bool value) {
    prefs.setBool('joinTelegramDialog', value);
  }
  // Remind Later
  bool remindTelegramLater = false;

  // Enable/Disable App's BlurUI
  bool get enableBlurUI {
    return prefs.getBool('enable_BlurUI') ?? false;
  }
  set enableBlurUI(bool value) {
    prefs.setBool('enable_BlurUI', value);
    notifyListeners();
  }

  bool get enablePlayerBlurBackground {
    return prefs?.getBool('enablePlayerBlurBackground') ?? true;
  }
  set enablePlayerBlurBackground(bool value) {
    prefs.setBool('enablePlayerBlurBackground', value);
    notifyListeners();
  }

  // MusicPlayer Artwork Rounded Corners
  double get musicPlayerArtworkRoundCorners {
    return prefs.getDouble('musicPlayerArtworkRoundCorners') ?? 20;
  }
  set musicPlayerArtworkRoundCorners(double value) {
    prefs.setDouble('musicPlayerArtworkRoundCorners', value);
    notifyListeners();
  }

  // Youtube Auto-Play
  bool get youtubeAutoPlay {
    return prefs.getBool('youtubeAutoPlay') ?? true;
  }
  set youtubeAutoPlay(bool value) {
    prefs.setBool('youtubeAutoPlay', value);
    notifyListeners();
  }

  // Watch History
  List<StreamInfoItem> get watchHistory {
    String json = prefs.getString('newWatchHistory');
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
    List<Map<String, dynamic>> map =
      history.map((e) => e.toMap()).toList();
    prefs.setString('newWatchHistory', jsonEncode(map));
    notifyListeners();
  }
  void watchHistoryInsert(dynamic video) {
    List<StreamInfoItem> history = watchHistory;
    history.add(video);
    watchHistory = history;
  }

  // ------------------------------------
  // Stream Playlists Creation/Management
  // ------------------------------------
  set streamPlaylists(List<StreamPlaylist> playlists) {
    String json = StreamPlaylist.listToJson(playlists);
    prefs.setString('playlists', json);
    notifyListeners();
  }
  List<StreamPlaylist> get streamPlaylists {
    String json = prefs.getString('playlists') ?? "";
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
    return prefs.getString('youtubePlayerQuality') ?? "720";
  }
  set youtubePlayerQuality(String quality) {
    prefs.setString('youtubePlayerQuality', quality);
    notifyListeners();
  }

  // Channel Subscriptions
  List<ChannelSubscription> get channelSubscriptions {
    String json = prefs.getString('subscriptions') ?? "";
    return ChannelSubscription.fromJsonList(json);
  }
  set channelSubscriptions(List<ChannelSubscription> subscriptions) {
    prefs.setString('subscriptions', ChannelSubscription.toJsonList(subscriptions));
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
    return prefs.getInt('maxSimultaneousDownloads') ?? 2;
  }
  set maxSimultaneousDownloads(int value) {
    prefs.setInt('maxSimultaneousDownloads', value);
    notifyListeners();
  }

  // Enable/Disable Video Autoplay (Video page)
  bool get videoPageAutoPlay {
    return prefs.getBool('videoPageAutoPlay') ?? true;
  }
  set videoPageAutoPlay(bool value) {
    prefs.setBool('videoPageAutoPlay', value);
    notifyListeners();
  }

}