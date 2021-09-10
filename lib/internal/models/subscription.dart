import 'dart:convert';

import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';

class ChannelSubscription {

  String url;
  String id;
  String name;
  String avatarUrl;
  DateTime date;
  bool enableNotifications;

  ChannelSubscription(
    this.url,
    this.id,
    this.name,
    this.avatarUrl,
    this.date,
    this.enableNotifications
  );

  static ChannelSubscription generateFromChannel(YoutubeChannel channel) {
    return ChannelSubscription(
      channel.url,
      channel.id,
      channel.name,
      channel.avatarUrl,
      DateTime.now(),
      false
    );
  }

  Map<String, String> toMap() {
    return {
      'url': url,
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'date': date.toString(),
      'enableNotifications': enableNotifications.toString()
    };
  }

  static ChannelSubscription fromMap(map) {
    return ChannelSubscription(
      map['url'],
      map['id'],
      map['name'],
      map['avatarUrl'],
      DateTime.parse(map['date']),
      map['enableNotifications'] == "true" ? true : false
    );
  }

  static String toJsonList(List<ChannelSubscription> channels) {
    if (channels == null || channels.isEmpty) return "";
    return jsonEncode(List.generate(channels.length, (index) {
      return channels[index].toMap();
    }).toList());
  }

  static List<ChannelSubscription> fromJsonList(String json) {
    if (json == null || json == "") return <ChannelSubscription>[];
    var channelsMap = jsonDecode(json);
    return channelsMap.isNotEmpty
      ? List.generate(channelsMap.length, (index) {
          return ChannelSubscription.fromMap(channelsMap[index]);
        }).toList()
      : [];
  }

}