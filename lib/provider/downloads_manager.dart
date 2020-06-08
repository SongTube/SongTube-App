// Dart
import 'dart:async';

// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/internal/database/infoset_database.dart';
import 'package:songtube/internal/database/models/downloaded_file.dart';
import 'package:songtube/internal/download_manager.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/models/downloadinfoset.dart';
import 'package:songtube/internal/models/enums.dart';
import 'package:songtube/internal/models/metadata.dart';
import 'package:songtube/internal/native.dart';
import 'package:songtube/internal/youtube/infoparser.dart';
import 'package:songtube/provider/app_provider.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:provider/provider.dart';

class ManagerProvider extends ChangeNotifier {

  // ----------------
  // Initialize Class
  // ----------------
  //
  ManagerProvider() {
    showEmptyScreenWidget    = false;
    openWebviewPlayer        = false;
    showLoadingBar           = false;
    mediaStreamReady         = false;
    showFloatingActionButtom = false;
    urlController    = new TextEditingController();
    titleController  = new TextEditingController();
    albumController  = new TextEditingController();
    artistController = new TextEditingController();
    genreController  = new TextEditingController();
    dateController   = new TextEditingController();
    discController   = new TextEditingController();
    trackController  = new TextEditingController();
    getDatabase();
  }

  // -------------
  // App Variables
  // -------------
  //
  // Home Screen
  bool showEmptyScreenWidget;
  bool openWebviewPlayer;
  bool showLoadingBar;
  bool mediaStreamReady;
  bool showFloatingActionButtom;
  // Downloads Screen
  List<DownloadInfoSet> _downloadInfoSetList = [];
  List<DownloadedFile> _downloadedFileList = [];
  int _downloadsTabIndex = 0;

  // -----------------------------
  // App Global MediaStreamInfoSet
  // -----------------------------
  MediaStreamInfoSet _mediaStream;

  // --------
  // Database
  // --------
  final dbHelper = DatabaseService.instance;
  void getDatabase() async {
    _downloadedFileList = await dbHelper.getDownloadList();
    notifyListeners();
  }

  // ---------------
  // TextControllers
  //
  TextEditingController urlController;
  TextEditingController titleController;
  TextEditingController albumController;
  TextEditingController artistController;
  TextEditingController genreController;
  TextEditingController dateController;
  TextEditingController discController;
  TextEditingController trackController;
  //
  // Update TextControllers Information
  //  
  void updateTextControllers() {
    titleController.text  = mediaStream.videoDetails.title;
    albumController.text  = "YouTube";
    artistController.text = mediaStream.videoDetails.author;
    genreController.text  = "Any";
    dateController.text   = "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}";
    discController.text   = "1";
    trackController.text  = "1";
    notifyListeners();
  }
  // ----------------------------------

  // -------------------------
  // Other Functions & Helpers
  // -------------------------
  //
  // Add Item to Download List
  void addItemToDownloadList(DownloadInfoSet newItem) {
    _downloadInfoSetList.add(newItem);
    notifyListeners();
  }
  // Unload HomeScreen Data
  void loadHome(int option) {
    switch(option) {
      case 1:
        showEmptyScreenWidget    = false;
        openWebviewPlayer        = false;
        showLoadingBar           = true;
        showFloatingActionButtom = false;
        mediaStreamReady         = false;
        break;
      case 0:
        openWebviewPlayer        = false;
        showLoadingBar           = false;
        showFloatingActionButtom = true;
        mediaStreamReady         = true;
        break;
      default:
        print("ManagerProvider: invalid option");
        break;
    }
    notifyListeners();
  }
  // Handle incoming intents (Links via share)
  Future<int> handleIntent() async {
    String url; String id;
    await NativeMethod.handleIntent().then((resultText) => url = resultText);
    if (url == null) return 1;
    id = YoutubeInfo.getLinkID(url);
    if (id == null) return 1;
    loadHome(1);
    urlController.text = url; notifyListeners();
    await getMediaStreamInfo(id);
    loadHome(0);
    return 0;
  }

  // -------------------------------------
  // Info & Downloads Management Functions
  // -------------------------------------
  //
  // Get Link Information
  String getIdFromLink() {
    return YoutubeInfo.getLinkID(urlController.text);
  }
  // Get Video MediaStreamInfo from Id
  Future<int> getMediaStreamInfo(String id) async {
    loadHome(1);
    MediaStreamInfoSet tmp;
    try {
      tmp = await YoutubeInfo.getVideoInfo(id).timeout(Duration(seconds: 15),
        onTimeout: () {
          print("Timeout");
          loadHome(1);
          return null;
        }
      );
    } on Exception catch (e) {
      print(e);
      return null;
    }
    if (tmp != null) {
      mediaStream = tmp;
      updateTextControllers();
      loadHome(0);
      return 0;
    }
    return null;
  }
  // Handle Downloads
  void handleDownload(BuildContext context, List<String> data) {
    AppDataProvider appData = Provider.of<AppDataProvider>(context, listen: false);
    DownloadType downloadType;
    FFmpegArgs convertFormat;
    MediaMetaData metadata = new MediaMetaData(
      titleController.text
        .replaceAll('Container.', '')
        .replaceAll(r'\', '')
        .replaceAll('/', '')
        .replaceAll('*', '')
        .replaceAll('?', '')
        .replaceAll('"', '')
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('|', ''),
      albumController.text,
      artistController.text,
      genreController.text,
      mediaStream.videoDetails.thumbnailSet.highResUrl,
      dateController.text,
      discController.text,
      trackController.text,
    );
    if (appData.audioConvertFormat == "AAC") convertFormat = FFmpegArgs.argsToACC;
    if (appData.audioConvertFormat == "OGG Vorbis") convertFormat = FFmpegArgs.argsToOGGVorbis;
    if (appData.audioConvertFormat == "MP3") convertFormat = FFmpegArgs.argsToMP3;
    int videoIndex;
    bool enableConvertion;
    String downloadPath;
    switch (data[0]) {
      case "Audio":
        downloadType = DownloadType.audio;
        enableConvertion = appData.enableAudioConvertion;
        downloadPath = appData.audioDownloadPath;
        break;
      case "Video":
        downloadType = DownloadType.video;
        videoIndex = int.parse(data[1]);
        enableConvertion = false;
        downloadPath = appData.videoDownloadPath;
        break;
    }
    StreamController<String> currentAction = new StreamController.broadcast();
    DownloadInfoSet infoset = new DownloadInfoSet(
      currentAction: currentAction,
      mediaStream: mediaStream,
      metadata: metadata,
      downloadType: downloadType,
      downloadPath: downloadPath,
      convertFormat: convertFormat,
      videoIndex: videoIndex,
      audioModifiers: [double.parse(data[2]), int.parse(data[3]), int.parse(data[4])]
    );
    DownloadManager _manager = new DownloadManager(
      enableConvertion: enableConvertion,
      infoset: infoset
    );
    addItemToDownloadList(infoset);
    appData.screenIndex = 1;
    downloadsTabIndex = 0;
    _manager.handleDownload();
  }

  // -------------------
  // Getters and Setters
  // -------------------
  //
  // MediaStreamInfoSet Getter and Setter
  MediaStreamInfoSet get mediaStream => _mediaStream;
  set mediaStream(MediaStreamInfoSet newMediaStream) {
    _mediaStream = newMediaStream;
    notifyListeners();
  }
  List<DownloadInfoSet> get downloadInfoSetList => _downloadInfoSetList;
  List<DownloadedFile> get downloadedFileList => _downloadedFileList;
  int get downloadsTabIndex => _downloadsTabIndex;
  set downloadInfoSetList(List<DownloadInfoSet> newList) {
    _downloadInfoSetList = newList;
    notifyListeners();
  }
  set downloadedFileList(List<DownloadedFile> newList) {
    _downloadedFileList = newList;
    notifyListeners();
  }
  set downloadsTabIndex(int value) {
    _downloadsTabIndex = value;
    notifyListeners();
  }
}