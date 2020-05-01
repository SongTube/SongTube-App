import 'dart:async';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

AppData appdata;
MediaMetaData defaultMetaData;
StreamController<List<DownloadInfoSet>> downloadListController = new StreamController.broadcast();
List<DownloadInfoSet> downloadList = [];

enum CurrentAction { downloading, loading, converting, none }
enum DownloadType { audio, video }

class DownloadInfoSet {

  StreamController<double> downloadProgress;
  StreamController<double> dataProgress;
  StreamController<String> currentAction;
  DownloadType downloadChoice;
  AudioStreamInfo audio;
  List<VideoStreamInfo> videoList;
  MediaStreamInfoSet mediaStream;
  String videoId;
  MediaMetaData metadata;

  DownloadInfoSet(this.downloadProgress, this.dataProgress, this.currentAction,
                  this.downloadChoice, this.audio, this.videoList, this.mediaStream,
                  this.videoId, this.metadata);

}

class MediaMetaData {

  String title;
  String album;
  String artist;
  String genre;
  String coverurl;
  String date;
  String disk;
  String track;

  MediaMetaData(this.title, this.album, this.artist, this.genre,
    this.coverurl, this.date, this.disk, this.track);

}

class ExternalPath {
  // Path for external storage
  Future<String> get externalStorage async =>
      await ExtStorage.getExternalStorageDirectory();

  // Path for external storage "Downloads" folder
  Future<String> get externalDownloads async =>
      await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);

  // Path for external storage "Music" folder
  Future<String> get externalMusic async =>
      await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_MUSIC);
}

class AppData {

  AppData() {
    linkReady = false;
    showFAB.add(false);
  }

  StreamController progressController = new StreamController();
  StreamController<CurrentAction> currentAction = new StreamController.broadcast();
  StreamController<bool> showFAB = new StreamController.broadcast();

  bool linkReady;
  String videoId;
  double audioSize;
  Duration audioDuration;
  String audioTitle;
  String audioArtist;
  String coverUrl;

  TextEditingController titleController = new TextEditingController();
  TextEditingController albumController = new TextEditingController();
  TextEditingController artistController = new TextEditingController();
  TextEditingController genreController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController diskController = new TextEditingController();
  TextEditingController trackController = new TextEditingController();

  FocusNode urlFocusNode = FocusNode();
  FocusNode titleFocusNode = FocusNode();
  FocusNode albumFocusNode = FocusNode();
  FocusNode artistFocusNode = FocusNode();
  FocusNode genreFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  FocusNode diskFocusNode = FocusNode();
  FocusNode trackFocusNode = FocusNode();

  Future<String> get getDefaultDownloadFolder async {
    String path = await ExternalPath().externalStorage;
    path = path + "/" + "SongTube";
    return path;
  }

  // Downloader variables
  String id;
  MediaStreamInfoSet mediaStream;
  List<VideoStreamInfo> videoStreams;
  AudioStreamInfo audio;

  void cleanTextEditing() {
    titleController.clear();
    albumController.clear();
    artistController.clear();
    genreController.clear();
    dateController.clear();
    diskController.clear();
    trackController.clear();
  }

  void unloadFocus() {
    urlFocusNode.unfocus();
    titleFocusNode.unfocus();
    albumFocusNode.unfocus();
    artistFocusNode.unfocus();
    genreFocusNode.unfocus();
    dateFocusNode.unfocus();
    diskFocusNode.unfocus();
    trackFocusNode.unfocus();
  }

  void unloadStreams() {
    progressController.add(0.0);
    currentAction.add(CurrentAction.none);
  }

  void dispose() {
    progressController.close();
    currentAction.close();
  }
}
