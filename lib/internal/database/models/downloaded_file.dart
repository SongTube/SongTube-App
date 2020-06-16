import 'dart:core';

import 'package:flutter/material.dart';

class DownloadedFile {

  String id;
  String title;
  String album;
  String author;
  String duration;
  String downloadType;
  String path;
  String fileSize;
  String coverUrl;

  DownloadedFile({
    @required this.id,
    @required this.title,
    @required this.album,
    @required this.author,
    @required this.duration,
    @required this.downloadType,
    @required this.path,
    @required this.fileSize,
    @required this.coverUrl
  });

  DownloadedFile.toDatabase({
    @required this.title,
    @required this.album,
    @required this.author,
    @required this.duration,
    @required this.downloadType,
    @required this.path,
    @required this.fileSize,
    @required this.coverUrl
  });

  DownloadedFile.fromMap(Map<String, dynamic> map) {
    id = map["id"].toString();
    title = map["title"];
    album = map["album"];
    author = map["author"];
    duration = map["duration"];
    downloadType = map["downloadType"];
    path = map["path"];
    fileSize = map["fileSize"].toString();
    coverUrl = map["coverUrl"];
  }

  Map<String, dynamic> toMap() {
    return {
      "title": this.title,
      "album": this.album,
      "author": this.author,
      "duration": this.duration,
      "downloadType": this.downloadType,
      "path": this.path,
      "fileSize": this.fileSize,
      "coverUrl": this.coverUrl
    };
  }
}