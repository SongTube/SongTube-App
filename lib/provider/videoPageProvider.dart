import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/models/channel.dart';
import 'package:newpipeextractor_dart/models/infoItems/playlist.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:newpipeextractor_dart/models/playlist.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/players/components/youtubePlayer/videoPlayer.dart';

class VideoPageProvider extends ChangeNotifier {

  // Slidable panel controller
  PanelController panelController;

  // Video Player Key
  final playerKey = GlobalKey<StreamManifestPlayerState>();

  VideoPageProvider() {
    panelController = PanelController();
  }

  // Current infoItem & YoutubeVideo
  dynamic _infoItem;
  YoutubeVideo currentVideo;
  YoutubePlaylist currentPlaylist;
  TagsControllers currentTags;
  YoutubeChannel currentChannel;
  List<StreamInfoItem> currentRelatedVideos;
  dynamic get infoItem => _infoItem;
  set infoItem(dynamic infoItem) {
    if (_infoItem != null) {
      if (panelController.isAttached)
        panelController.open();
    }
    if (currentPlaylist == null) {
      if (infoItem is StreamInfoItem) {
        initializeStream(infoItem);
      } else if (infoItem is PlaylistInfoItem) {
        initializePlaylist(infoItem);
      }
    } else {
      _infoItem = infoItem;
      currentVideo = null;
      currentChannel = null;
      notifyListeners();
      _infoItem.getVideo.then((value) { 
        currentVideo = value;
        saveToHistory(currentVideo.toStreamInfoItem());
        notifyListeners();
      });
      _infoItem.getChannel.then((value) {
        currentChannel = value;
        notifyListeners();
      });
    }
  }


  void initializeStream(StreamInfoItem item) {
    _infoItem = item;
    currentVideo = null;
    currentChannel = null;
    currentPlaylist = null;
    currentTags = null;
    notifyListeners();
    _infoItem.getVideo.then((value) { 
      currentVideo = value;
      currentTags = TagsControllers();
      currentTags.updateTextControllers(value);
      saveToHistory(currentVideo.toStreamInfoItem());
      notifyListeners();
    });
    _infoItem.getChannel.then((value) {
      currentChannel = value;
      notifyListeners();
    });
    VideoExtractor.getRelatedStreams(_infoItem.url).then((value) async {
      if (value.isEmpty) {
        currentRelatedVideos = await ChannelExtractor
          .getChannelUploads(_infoItem.uploaderUrl);
      } else {
        currentRelatedVideos = value;
      }
      notifyListeners();
    });
  }

  void initializePlaylist(PlaylistInfoItem item) async {
    _infoItem = item;
    currentVideo = null;
    currentChannel = null;
    currentPlaylist = null;
    currentTags = null;
    notifyListeners();
    currentPlaylist = await item.getPlaylist;
    notifyListeners();
    await currentPlaylist.getStreams();
    currentRelatedVideos = currentPlaylist.streams;
    _infoItem = currentRelatedVideos[0];
    notifyListeners();
    _infoItem.getVideo.then((value) { 
      currentVideo = value;
      // TODO: Save Playlist to History
      notifyListeners();
    });
    _infoItem.getChannel.then((value) {
      currentChannel = value;
      notifyListeners();
    });
  }

  void closeVideoPanel() {
    currentChannel = null;
    currentVideo = null;
    currentRelatedVideos = null;
    currentPlaylist = null;
    currentTags = null;
    _infoItem = null;
    notifyListeners();
  }

  void setState() {
    notifyListeners();
  }

  Future<void> saveToHistory(StreamInfoItem video) async {
    var prefs = await SharedPreferences.getInstance();
    String json = prefs.getString('newWatchHistory');
    if (json == null) {
      List<StreamInfoItem> videos = [video];
      List<Map<dynamic, dynamic>> map =
      videos.map((e) => e.toMap()).toList();
      prefs.setString('newWatchHistory', jsonEncode(map));
    } else {
      List<StreamInfoItem> history = [];
      var map = jsonDecode(json);
      if (map.isNotEmpty) {
        map.forEach((element) {
          history.add(StreamInfoItem.fromMap(element));
        });
      }
      if (history.indexWhere((element) => element.url == video.url) != -1) {
        history.removeAt(history.indexWhere((element) => video.url == element.url));
        history.insert(0, video);
      } else {
        history.insert(0, video);
      }
      map = history.map((e) => e.toMap()).toList();
      prefs.setString('newWatchHistory', jsonEncode(map));
    }
  }

}