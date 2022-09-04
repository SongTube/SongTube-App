import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/extractors/comments.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/models/channel.dart';
import 'package:newpipeextractor_dart/models/comment.dart';
import 'package:newpipeextractor_dart/models/infoItems/playlist.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:newpipeextractor_dart/models/playlist.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:songtube/internal/avatarHandler.dart';
import 'package:songtube/internal/globals.dart';
import 'package:songtube/internal/models/playlist.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/players/components/youtubePlayer/videoPlayer.dart';
import 'package:songtube/ui/components/fancyScaffold.dart';

class VideoPageProvider extends ChangeNotifier {

  // Slidable panel controller
  FloatingWidgetController fwController;

  // Video Player Key
  GlobalKey<StreamManifestPlayerState> playerKey =
    GlobalKey<StreamManifestPlayerState>();

  VideoPageProvider() {
    fwController = FloatingWidgetController();
  }

  // Current infoItem & YoutubeVideo
  dynamic _infoItem;
  YoutubeVideo currentVideo;
  YoutubePlaylist currentPlaylist;
  TagsControllers currentTags;
  YoutubeChannel currentChannel;
  List<StreamInfoItem> currentRelatedVideos;
  List<YoutubeComment> currentComments;
  bool isPlaylist;
  dynamic get infoItem => _infoItem;
  set infoItem(dynamic infoItem) {
    if (_infoItem != null) {
      if (fwController.isAttached)
        fwController.open();
    }
    if (currentPlaylist == null) {
      if (infoItem is StreamInfoItem) {
        initializeStream(infoItem);
      } else if (infoItem is PlaylistInfoItem || infoItem is StreamPlaylist) {
        initializePlaylist(infoItem);
      }
    } else {
      _infoItem = infoItem;
      currentVideo = null;
      currentChannel = null;
      currentComments = null;
      isPlaylist = true;
      currentTags = null;
      notifyListeners();
      _infoItem.getVideo.then((value) { 
        currentVideo = value;
        currentTags = TagsControllers();
        currentTags.updateTextControllers(value);
        saveToHistory(currentVideo.toStreamInfoItem());
        notifyListeners();
        CommentsExtractor.getComments(currentVideo.videoInfo.url).then((comments) {
          currentComments = comments;
          notifyListeners();
        });
      });
      _infoItem.getChannel.then((value) {
        currentChannel = value;
        notifyListeners();
      });
    }
  }


  void initializeStream(StreamInfoItem item) async {
    _infoItem = item;
    currentVideo = null;
    currentChannel = null;
    currentPlaylist = null;
    currentComments = null;
    currentTags = null;
    isPlaylist = false;
    notifyListeners();
    await _infoItem.getVideo.then((value) { 
      currentVideo = value;
      currentTags = TagsControllers();
      currentTags.updateTextControllers(value);
      saveToHistory(currentVideo.toStreamInfoItem());
      notifyListeners();
    });
    CommentsExtractor.getComments(currentVideo.videoInfo.url).then((comments) {
      currentComments = comments;
      notifyListeners();
    });
    _infoItem.getChannel.then((value) async {
      currentChannel = value;
      notifyListeners();
      currentChannel.avatarUrl = await
        AvatarHandler.getAvatarUrl(currentChannel.name, currentChannel.url);
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

  void initializePlaylist(dynamic playlist) async {
    PlaylistInfoItem item = playlist is PlaylistInfoItem
      ? playlist : PlaylistInfoItem(
        null,
        playlist.name,
        playlist.author,
        null, null
      );
    _infoItem = item;
    currentVideo = null;
    currentChannel = null;
    currentPlaylist = null;
    currentComments = null;
    currentTags = null;
    isPlaylist = true;
    notifyListeners();
    if (playlist is PlaylistInfoItem) {
      currentPlaylist = await item.getPlaylist;
    } else {
      currentPlaylist = YoutubePlaylist(
        null, null, null, null, null,
        null, null, null, null
      );
    }
    notifyListeners();
    if (playlist is PlaylistInfoItem) {
      await currentPlaylist.getStreams();
      currentRelatedVideos = currentPlaylist.streams;
    } else {
      currentRelatedVideos = (playlist as StreamPlaylist).streams;
    }
    _infoItem = currentRelatedVideos[0];
    notifyListeners();
    await _infoItem.getVideo.then((value) { 
      currentVideo = value;
      currentTags = TagsControllers();
      currentTags.updateTextControllers(value);
      // TODO: Save Playlist to History
      notifyListeners();
      
    });
    CommentsExtractor.getComments(currentVideo.videoInfo.url).then((comments) {
      currentComments = comments;
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
    currentComments = null;
    _infoItem = null;
    isPlaylist = false;
    notifyListeners();
  }

  void setState() {
    notifyListeners();
  }

  Future<void> saveToHistory(StreamInfoItem video) async {
    if (globalPrefs.getBool('enableWatchHistory') ?? true) {
      String json = globalPrefs.getString('newWatchHistory');
      if (json == null) {
        List<StreamInfoItem> videos = [video];
        List<Map<dynamic, dynamic>> map =
        videos.map((e) => e.toMap()).toList();
        globalPrefs.setString('newWatchHistory', jsonEncode(map));
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
        globalPrefs.setString('newWatchHistory', jsonEncode(map));
      }
    }
  }
}