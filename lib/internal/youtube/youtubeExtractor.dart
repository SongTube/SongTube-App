import 'dart:convert';
import 'dart:isolate';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// This Class holds functions to retrieve data from Youtube using the
/// youtube_explode_dart library, but, because those library functions are
/// CPU expensive, these are implemented with Isolates to avoid lagging
/// or blocking the App main Isolate
/// 
/// These will only work using a Fork of the original youtube_explode_dart
/// library which has the methods to convert its objects into maps for json
/// encode/decode. The fork can be found on [https://github.com/songtube]
class YoutubeExtractor {

  /// All Data returned by this isolate has to be on a String or Json Format
  static void _youtubeExtractorIsolate(SendPort mainSendPort) async {
    ReceivePort childReceivePort = ReceivePort();
    mainSendPort.send(childReceivePort.sendPort);
    await for (var message in childReceivePort) {
      YoutubeExplode yt = YoutubeExplode();
      String request = message[0]["request"];
      SendPort replyPort = message[1];
      // Get Channel Information
      if (request == "getChannel") {
        String videoId = message[0]["id"];
        Channel channel;
        try {
          channel = await yt.channels.getByVideo(videoId);
        } catch (_) {
          replyPort.send("Failed");
          yt.close();
          break;
        }
        replyPort.send(jsonEncode(channel.toMap()));
        yt.close();
        break;
      }
      // Get Video Details
      if (request == "getVideo") {
        String videoId = message[0]["id"];
        Video video;
        try {
          video = await yt.videos.get(videoId);
        } catch (_) {
          replyPort.send("Failed");
          yt.close();
          break;
        }
        replyPort.send(jsonEncode(video.toMap()));
        yt.close();
        break;
      }
      // Get StreamManifest
      if (request == "getManifest") {
        String videoId = message[0]["id"];
        StreamManifest manifest;
        try {
          manifest = await yt.videos.streamsClient.getManifest(videoId);
        } catch (_) {
          replyPort.send("Failed");
          yt.close();
          break;
        }
        replyPort.send(jsonEncode(manifest.toMap()));
        yt.close();
        break;
      }
      // Get Channel Uploads
      if (request == "getChannelUploads") {
        String id = message[0]["id"];
        String takeFrom = message[0]["takeFrom"];
        List<Video> videos = List<Video>();
        String channelId;
        if (takeFrom == "videoId") {
          channelId = (await yt.channels.getByVideo(id)).id.value;
        } else if (takeFrom == "channelId"){
          channelId = id;
        }
        try {
          videos = await yt.channels
          .getUploads(channelId).take(20).toList();
        } catch (_) {
          videos = await yt.channels
          .getUploads(channelId).toList();
        }
        List<Map<String, dynamic>> videosMap = videos.map((e) {
          return e.toMap();
        }).toList();
        replyPort.send(jsonEncode({
          'channelUploads': videosMap
        }));
        yt.close();
        break;
      }
    }
  }

  // Data Isolates
  Isolate channelIsolate;
  Isolate videoIsolate;
  Isolate manifestIsolate;
  Isolate channelUploadsIsolate;
  void killIsolates() {
    if (channelIsolate != null) {
      channelIsolate.kill();
      channelIsolate = null;
    }
    if (videoIsolate != null) {
      videoIsolate.kill();
      videoIsolate = null;
    }
    if (manifestIsolate != null) {
      manifestIsolate.kill();
      manifestIsolate = null;
    }
    if (channelUploadsIsolate != null) {
      channelUploadsIsolate.kill();
      channelUploadsIsolate = null;
    }
  }
  
  Future<Channel> getChannelByVideoId(VideoId id) async {
    ReceivePort receivePort = ReceivePort();
    channelIsolate = await Isolate.spawn(
      _youtubeExtractorIsolate, receivePort.sendPort);
    SendPort childSendPort = await receivePort.first;
    ReceivePort responsePort = ReceivePort();
    childSendPort.send([
      {
        "request": "getChannel",
        "id": id.value,
      },
      responsePort.sendPort
    ]);
    String encodedChannel = await responsePort.first;
    Map<String, dynamic> map = jsonDecode(encodedChannel);
    Channel channel = Channel.fromMap(map);
    return channel;
  }

  Future<StreamManifest> getStreamManifest(VideoId id) async {
    ReceivePort receivePort = ReceivePort();
    manifestIsolate = await Isolate.spawn(
      _youtubeExtractorIsolate, receivePort.sendPort);
    SendPort childSendPort = await receivePort.first;
    ReceivePort responsePort = ReceivePort();
    childSendPort.send([
      {
        "request": "getManifest",
        "id": id.value,
      },
      responsePort.sendPort
    ]);
    String jsonManifest = await responsePort.first;
    Map<String, dynamic> map = jsonDecode(jsonManifest);
    return StreamManifest.fromMap(map);
  }

  // Get video information by URL
  Future<Video> getVideoDetails(VideoId id) async {
    ReceivePort receivePort = ReceivePort();
    videoIsolate = await Isolate.spawn(
      _youtubeExtractorIsolate, receivePort.sendPort);
    SendPort childSendPort = await receivePort.first;
    ReceivePort responsePort = ReceivePort();
    childSendPort.send([
      {
        "request": "getVideo",
        "id": id.value,
      },
      responsePort.sendPort
    ]);
    String videoJson = await responsePort.first;
    return Video.fromMap(jsonDecode(videoJson));
  }

  // Get Playlist Details
  Future<Playlist> getPlaylistDetails(PlaylistId id) async {
    Playlist playlist;
    while (playlist == null) {
      YoutubeExplode yt = YoutubeExplode();
      try {
        playlist = await yt.playlists.get(id);
      } catch (_) {}
      yt.close();
      return playlist;
    }
    return playlist;
  }
  
  // Playlist Details
  Future<List<Video>> getPlaylistVideos(PlaylistId id) async {
    List<Video> videos;
    while (videos == null) {
      try {
        YoutubeExplode yt = YoutubeExplode();
        videos = await yt.playlists
          .getVideos(id)
          .take(50).toList();
        yt.close();
        return videos;
      } catch (_) {
        YoutubeExplode yt = YoutubeExplode();
        videos = await yt.playlists
          .getVideos(id)
          .toList();
        yt.close();
        return videos;
      }
    }
    return videos;
  }

  // Video Comments
  Future<List<Comment>> getVideoComments(Video video) async {
    YoutubeExplode yt = YoutubeExplode();
    List<Comment> comments;
    Video watchPageVideo = await yt.videos
      .get(video.id, forceWatchPage: true);
    try {
      comments = await yt.videos.commentsClient
        .getComments(watchPageVideo)
        .take(30).toList();
    } catch (_) {
      comments = await yt.videos.commentsClient
        .getComments(watchPageVideo)
        .toList();
    }
    yt.close();
    if (comments == null || comments.isEmpty) {
      comments = null;
    }
    return comments;
  }

  Future<List<Video>> getChannelVideos(dynamic id) async {
    ReceivePort receivePort = ReceivePort();
    channelUploadsIsolate = await Isolate.spawn(
      _youtubeExtractorIsolate, receivePort.sendPort);
    SendPort childSendPort = await receivePort.first;
    ReceivePort responsePort = ReceivePort();
    String takeFrom;
    if (id is VideoId) {
      takeFrom = "videoId";
    }
    if (id is ChannelId) {
      takeFrom = "channelId";
    }
    childSendPort.send([
      {
        "request": "getChannelUploads",
        "id": id.value,
        "takeFrom": takeFrom
      },
      responsePort.sendPort
    ]);
    String uploadsJson = await responsePort.first;
    var uploadsMap = jsonDecode(uploadsJson);
    print(uploadsMap);
    List<Video> channelUploads = [];
    uploadsMap['channelUploads'].forEach((element) {
      channelUploads.add(Video.fromMap(element));
    });
    return channelUploads;
  }

  static AudioOnlyStreamInfo getBestAudioStreamForVideo(StreamManifest manifest, String videoFormat) {
    AudioOnlyStreamInfo audio;
    if (videoFormat == "mp4") {
      audio = manifest.audioOnly
        .firstWhere((element) => element.audioCodec == "mp4a.40.2",
        orElse: () {
          return manifest.audioOnly
            .firstWhere((element) => element.audioCodec == "opus");
        });
    } else if (videoFormat == "webm") {
      audio = manifest.audioOnly
        .firstWhere((element) => element.audioCodec == "opus",
        orElse: () {
          return manifest.audioOnly
            .firstWhere((element) => element.audioCodec == "mp4a.40.2");
        });
    } else {
      audio = manifest.audioOnly.withHighestBitrate();
    }
    return audio;
  }
}