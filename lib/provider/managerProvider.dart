// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';

// Internal
import 'package:songtube/internal/database/infoset_database.dart';
import 'package:songtube/internal/models/songFile.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/models/downloadinfoset.dart';
import 'package:songtube/internal/models/metadata.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/internal/youtube/youtubeInfo.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/ui/snackbar.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:provider/provider.dart';

enum LoadingStatus {Success, Loading, Failed}

class ManagerProvider extends ChangeNotifier {

  // ----------------
  // Initialize Class
  // ----------------
  //
  ManagerProvider() {
    // Variables
    showEmptyScreenWidget    = true;
    openWebviewPlayer        = false;
    loadingVideo             = false;
    mediaStreamReady         = false;
    showFloatingActionButtom = false;
    showDownloadTabsStatus   = false;
    // Library Scaffold Key
    _libraryScaffoldKey = new GlobalKey<ScaffoldState>();
    screenIndex         = new StreamController<int>.broadcast();
    screenIndex.add(0);
    // Controllers
    urlController    = new TextEditingController();
    titleController  = new TextEditingController();
    albumController  = new TextEditingController();
    artistController = new TextEditingController();
    genreController  = new TextEditingController();
    dateController   = new TextEditingController();
    discController   = new TextEditingController();
    trackController  = new TextEditingController();
    homeScrollController  = new ScrollController();
    // YouTube Explode
    yt = new YoutubeInfo();
    // Database
    getDatabase();
  }

  // -------------
  // App Variables
  // -------------
  //
  // Library
  GlobalKey<ScaffoldState> _libraryScaffoldKey;
  StreamController<int> screenIndex;
  // Home Screen
  bool showEmptyScreenWidget;
  bool _openWebviewPlayer;
  bool _loadingVideo;
  bool mediaStreamReady;
  bool showFloatingActionButtom;
  ScrollController homeScrollController;
  // Downloads Screen
  List<DownloadInfoSet> _downloadInfoSetList = [];
  List<SongFile> _songFileList = [];
  bool showDownloadTabsStatus;
  // Navitate Screen
  String navigateIntent;
  // AudioService

  // --------------------------------
  // Current Video and StreamManifest
  // --------------------------------
  StreamManifest streamManifest;
  Video videoDetails;
  // Current Channel
  Channel channelDetails;

  // --------
  // SnackBar
  // --------
  AppSnack snackBar;

  // --------
  // Database
  // --------
  final dbHelper = DatabaseService.instance;
  Future<void> getDatabase() async {
    _songFileList = await dbHelper.getDownloadList();
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
  String artworkController;
  //
  // Update TextControllers Information
  //  
  void updateTextControllers() {
    titleController.text  = videoDetails.title;
    albumController.text  = "YouTube";
    artistController.text = videoDetails.author;
    genreController.text  = "Any";
    dateController.text   = "${videoDetails.uploadDate.year}/"
                            + "${videoDetails.uploadDate.month}/"
                            + "${videoDetails.uploadDate.day}";
    discController.text   = "1";
    trackController.text  = "1";
    artworkController     = videoDetails.thumbnails.mediumResUrl;
    notifyListeners();
  }
  void updateArtworkController(String artwork) {
    artworkController = artwork;
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
  void loadHome(LoadingStatus status) {
    switch(status) {
      // Failed to get mediaStream
      case LoadingStatus.Failed:
        showEmptyScreenWidget    = true;
        openWebviewPlayer        = false;
        loadingVideo             = false;
        showFloatingActionButtom = false;
        mediaStreamReady         = false;
        channelDetails           = null;
        break;
      // Is loading mediaStream
      case LoadingStatus.Loading:
        showEmptyScreenWidget    = false;
        openWebviewPlayer        = false;
        loadingVideo             = true;
        showFloatingActionButtom = false;
        mediaStreamReady         = false;
        channelDetails           = null;
        break;
      // mediaStream is loaded
      case LoadingStatus.Success:
        openWebviewPlayer        = false;
        loadingVideo             = false;
        showFloatingActionButtom = true;
        mediaStreamReady         = true;
        break;
    }
    notifyListeners();
  }
  // Handle incoming intents (Links via share)
  Future<void> handleIntent() async {
    // Return if the a mediaStream is beign loaded
    if (loadingVideo == true) return;
    // Handle Intent
    String url; String id;
    url = await NativeMethod.handleIntent();
    if (url == null) return;
    id = VideoId.parseVideoId(url);
    if (id == null) return;
    urlController.text = url; notifyListeners();
    await getVideoDetails(url);
  }
  // Get Current MediaItem List from our SongFile List
  List<MediaItem> getCurrentMediaItemList() {
    List<MediaItem> list = [];
    _songFileList.forEach((SongFile element) {
      if (element.downloadType == "Audio") {
        int hours = 0;
        int minutes = 0;
        int micros;
        List<String> parts = element.duration.split(':');
        if (parts.length > 2) {
          hours = int.parse(parts[parts.length - 3]);
        }
        if (parts.length > 1) {
          minutes = int.parse(parts[parts.length - 2]);
        }
        micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
        Duration duration = Duration(
          milliseconds: Duration(
            hours: hours,
            minutes: minutes,
            microseconds: micros
          ).inMilliseconds
        );
        list.add(
          new MediaItem(
            id: element.path,
            title: element.title,
            album: element.album,
            artist: element.author,
            artUri: "file://${element.coverPath}",
            duration: duration
          )
        );
      }
    });
    return list;
  }
  // Handle Library WillPop
  DateTime _currentBackPressTime;
  Future<bool> handlePop(index) async {
    if (index != 0) {
      screenIndex.add(0);
      return false;
    } else {
      DateTime now = DateTime.now();
      if (_currentBackPressTime == null || 
          now.difference(_currentBackPressTime) > Duration(seconds: 2)) {
        _currentBackPressTime = now;
        snackBar.showSnackBar(
          icon: Icons.warning,
          title: "Press back again to exit",
          duration: Duration(seconds: 1)
        );
        return Future.value(false);
      }
      return Future.value(true);
    }
  }
  // Move to Navigate Screen with a Search Intent
  void pushYoutubePage(String searchQuery) {
    navigateIntent = searchQuery;
    Future.delayed((Duration(milliseconds: 200)), () => screenIndex.add(3));
    Future.delayed((Duration(milliseconds: 200)), () => navigateIntent = null);
    notifyListeners();
  }
  // Gets video thumbnail of any Video Format
  Future<File> getVideoThumbnail(File videoFile) async {
    String videoTitle = videoFile.path.substring(videoFile.path.lastIndexOf('/')).substring(1)
      .replaceAll(".webm", '')
      .replaceAll(".mp4", '')
      .replaceAll(".avi", '')
      .replaceAll(".3gpp", '')
      .replaceAll(".flv", '')
      .replaceAll(".mkv", '');
    Directory appDir = await getApplicationDocumentsDirectory();
    String dir = appDir.path + "/Thumbnails/";
    if (!await Directory(dir).exists()) await Directory(dir).create(recursive: true);
    String coverPath;
    coverPath = dir + videoTitle
      .replaceAll(" ", '_')
      .replaceAll("'", '_')
      .replaceAll("\"", '_')+ ".png";
    if (await File(coverPath).exists()) {
      return File(coverPath);
    }
    List<String> ffmpegArgs = [
      "-y", "-i", "${videoFile.path}", "-ss", "00:00:01.000", "-vframes", "1", "$coverPath"
    ];
    await FlutterFFmpeg().executeWithArguments(ffmpegArgs);
    return File(coverPath);
  }
  // Get Video Duration
  Future<int> getVideoDuration(File video) async {
    var json = await FlutterFFprobe().getMediaInformation(video.path);
    return json['duration'];
  }

  // -------------------------------------
  // Info & Downloads Management Functions
  // -------------------------------------
  //
  // YouTube Explode
  YoutubeInfo yt;
  // Get Channel Link
  Future<Channel> getChannel() async {
    return await yt.getChannel(urlController.text);
  }
  // Get Video MediaStreamInfo from Id
  Future<int> getVideoDetails(String url) async {
    if (loadingVideo == true) return null;
    if (VideoId.parseVideoId(url) == null) return null;
    screenIndex.add(0);
    loadHome(LoadingStatus.Loading);
    try {
      videoDetails = await yt.getVideoDetails(url).timeout(Duration(seconds: 20));
      streamManifest = await yt.getVideoManifest(url).timeout(Duration(seconds: 20));
    } catch (e) {
      loadHome(LoadingStatus.Failed);
      return null;
    }
    updateTextControllers();
    loadHome(LoadingStatus.Success);
    channelDetails = await yt.getChannel(url);
    notifyListeners();
    return 0;
  }
  // Handle Downloads
  void handleDownload(BuildContext context, List data) {
    AppDataProvider appData = Provider.of<AppDataProvider>(context, listen: false);
    DownloadType downloadType;
    AudioConvert convertFormat;
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
      artworkController,
      dateController.text,
      discController.text,
      trackController.text,
    );
    if (appData.audioConvertFormat == "AAC") convertFormat = AudioConvert.ToAAC;
    if (appData.audioConvertFormat == "OGG Vorbis") convertFormat = AudioConvert.ToOGGVorbis;
    if (appData.audioConvertFormat == "MP3") convertFormat = AudioConvert.ToMP3;
    if (appData.enableAudioConvertion == false) convertFormat = AudioConvert.NONE;
    String downloadPath;
    StreamInfo audioStreamInfo;
    StreamInfo videoStreamInfo;
    switch (data[0]) {
      case "Audio":
        downloadType = DownloadType.AUDIO;
        downloadPath = appData.audioDownloadPath;
        audioStreamInfo = streamManifest.audioOnly.withHighestBitrate();
        break;
      case "Video":
        downloadType = DownloadType.VIDEO;
        videoStreamInfo = data[1];
        audioStreamInfo = streamManifest.audioOnly.withHighestBitrate();
        downloadPath = appData.videoDownloadPath;
        convertFormat = AudioConvert.WriteAudio;
        break;
    }
    DownloadInfoSet infoset = new DownloadInfoSet(
      audioStreamInfo: audioStreamInfo,
      videoStreamInfo: videoStreamInfo,
      videoDetails: videoDetails,
      metadata: metadata,
      downloadType: downloadType,
      downloadPath: downloadPath,
      convertFormat: convertFormat,
      audioModifiers: [double.parse(data[2]), int.parse(data[3]), int.parse(data[4])],
    );
    addItemToDownloadList(infoset);
    screenIndex.add(1);
    infoset.downloadMedia();
  }

  // -------------------
  // Getters and Setters
  // -------------------
  //
  // Library
  GlobalKey<ScaffoldState> get libraryScaffoldKey => _libraryScaffoldKey;
  // Loading Video
  bool get loadingVideo => _loadingVideo;
  set loadingVideo(bool value) {
    _loadingVideo = value;
    notifyListeners();
  }
  // Open WebView Player
  bool get openWebviewPlayer => _openWebviewPlayer;
  set openWebviewPlayer(bool value) {
    _openWebviewPlayer = value;
    notifyListeners();
  }
  List<DownloadInfoSet> get downloadInfoSetList => _downloadInfoSetList;
  List<SongFile> get songFileList => _songFileList;
  set downloadInfoSetList(List<DownloadInfoSet> newList) {
    _downloadInfoSetList = newList;
    notifyListeners();
  }
  set songFileList(List<SongFile> newList) {
    _songFileList = newList;
    notifyListeners();
  }
}