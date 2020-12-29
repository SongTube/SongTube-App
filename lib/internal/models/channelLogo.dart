// Flutter
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ChannelLogo {

  String name;
  String logoUrl;

  // This model will be pulled from the database
  ChannelLogo({
    @required this.name,
    @required this.logoUrl
  });

  // Use this to transform a Map obtained from
  // the Database to this actual Object
  ChannelLogo.fromMap(Map<String, dynamic> map) {
    name       = map["name"];
    logoUrl    = map["LogoUrl"];
  }

  // Use this to transform this object to the Map
  // that is going to be inserted in the Database
  Map<String, dynamic> toMap() {
    return {
      "name":    this.name,
      "logoUrl": this.logoUrl
    };
  }

  ChannelLogo.fromJson(Map<String, dynamic> json) {
    name    = json["name"];
    logoUrl = json["logoUrl"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name":    this.name,
      "LogoUrl": this.logoUrl
    };
  }

  static ChannelLogo fromJsonMap(Map<String, dynamic> json) {
    String name    = json['name'];
    String logoUrl = json['logoUrl'];
    ChannelLogo obj = new ChannelLogo(
      name:    name,
      logoUrl: logoUrl
    );
    return obj;
  }

  static List<ChannelLogo> fromJsonArray(String jsonString) {
    Map<String, dynamic> decodedMap = jsonDecode(jsonString);
    List<dynamic> dynamicList = decodedMap['listChannels'];
    List<ChannelLogo> wishVideos = new List<ChannelLogo>();
    if (dynamicList == null) return [];
    dynamicList.forEach((f) {
      ChannelLogo s = ChannelLogo.fromJsonMap(f);
      wishVideos.add(s);
    });
    return wishVideos;
  }

  static String listToJson(List<ChannelLogo> newList) {
    List<Map<String, String>> x = newList
        .map((f) =>
          {
            'name':    f.name,
            'logoUrl': f.logoUrl
          }
        )
        .toList();
    Map<String, dynamic> map() => {'listChannels': x};
    String result = jsonEncode(map());
    return result;
  }

  static void getChannelLogoUrlIsolate(SendPort mainSendPort) async {
    ReceivePort childReceivePort = ReceivePort();
    mainSendPort.send(childReceivePort.sendPort);
    await for (var message in childReceivePort) {
      YoutubeExplode yt = YoutubeExplode();
      String videoId = message[0];
      SendPort replyPort = message[1];
      Channel channel;
      try {
        channel = await yt.channels.getByVideo(videoId);
      } catch (_) {
        replyPort.send("");
        yt.close();
        break;
      }
      replyPort.send(channel.logoUrl);
      yt.close();
      break;
    }
  }

  static Future<String> getChannelLogoUrl(BuildContext context, SearchVideo video) async {
    if (context == null) return null;
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context, listen: false);
    if ((config.channelLogos.singleWhere((it) => it.name == video.videoAuthor,
          orElse: () => null)) != null) {
      return config.channelLogos[config.channelLogos
        .indexWhere((element) => element.name == video.videoAuthor)].logoUrl;
    } else {
      ReceivePort receivePort = ReceivePort();
      await Isolate.spawn(ChannelLogo.getChannelLogoUrlIsolate, receivePort.sendPort);
      SendPort childSendPort = await receivePort.first;
      ReceivePort responsePort = ReceivePort();
      childSendPort.send(["${video.videoId}", responsePort.sendPort]);
      String url = await responsePort.first;
      if (url == "") return null;
      if ((config.channelLogos.singleWhere((it) => it.name == video.videoAuthor,
          orElse: () => null)) != null) {
        print("logo Exist");
      } else {
        config.addItemtoChannelLogoList(ChannelLogo(
          name: video.videoAuthor,
          logoUrl: url
        ));
      }
      return url;
    }
  }

}
