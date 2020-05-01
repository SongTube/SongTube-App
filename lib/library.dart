import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/converter.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;
import 'internal/downloader.dart';
import 'tabs/downloadtab.dart';
import 'tabs/hometab.dart';
import 'tabs/settingstab.dart';
import 'internal/songtube_classes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'internal/action_handlers.dart';
import 'ui/ui_elements.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> with TickerProviderStateMixin {

  TabController _tabController;
  String _appBarTitle = appBarTitleArr[0];
  StreamController<int> _tabstream;

  @override
  void initState() {
    checkPermissions();
    appdata = AppData();
    _tabstream = new StreamController();
    _tabstream.add(0);
    _tabController = new TabController(initialIndex: 0, vsync: this, length: 3);
    _tabController.animation.addListener((){
      int value = _tabController.animation.value.round();
      if (value != _tabController.index) {
        _tabstream.add(value);
        if (value != 0) {
          appdata.showFAB.add(false);
        } else {
          appdata.showFAB.add(true);
        }
      }
    });
    super.initState();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment=false;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _tabstream.close();
  }

  void addToDownloadList(DownloadInfoSet newItem) {
    downloadList.add(newItem);
    List<DownloadInfoSet> tmpList = [];
    tmpList.add(downloadList.last);
    downloadList.forEach((item){
      if (item == newItem) return;
      tmpList.add(item);
    });
    downloadList = tmpList;
    downloadListController.add(downloadList);
    print(downloadList);
  }

  checkPermissions() async {
    final status = await Permission.storage.status;
    if (status.isUndetermined) {
      await showAlertDialog(context, false);
      final response = await Permission.storage.request();
      if (response.isDenied) exit(0);
      if (response.isPermanentlyDenied) exit(0);
    } else if (status.isGranted) {
      return;
    } else if (status.isDenied) {
      await showAlertDialog(context, false);
      final response = await Permission.storage.request();
      if (response.isDenied) exit(0);
      if (response.isPermanentlyDenied) exit(0);
    } else if (status.isPermanentlyDenied) {
      await showAlertDialog(context, true);
      exit(0);
    }
  }

  Widget _videoQualityWidget(BuildContext context) {
    Downloader downloader = new Downloader();
    Converter converter = new Converter();
    youtube.AudioStreamInfo audio = appdata.audio;
    List<youtube.VideoStreamInfo> videoList = downloader.extractVideoStreams(appdata.mediaStream);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AnimationController controller;
    Animation<double> scaleAnimation;
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.addListener(() => setState(() {}));
    controller.forward();
    return Center(
      child: Material(
        color: Colors.transparent,
        child: FadeTransition(
          opacity: scaleAnimation,
          child: Container(
            height: height*0.5,
            width: width*0.7,
            child: Container(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: height*0.1,
                      width: width*0.4,
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          "Video Quality",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).canvasColor.withOpacity(0.9),
                        ),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: videoList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Row(
                                  children: <Widget>[
                                    if (videoList[index].videoQualityLabel == "144p")
                                    Text("SD   - ", style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.body1.color)),
                                    if (videoList[index].videoQualityLabel == "240p")
                                    Text("SD   - ", style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.body1.color)),
                                    if (videoList[index].videoQualityLabel == "360p")
                                    Text("SD   - ", style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.body1.color)),
                                    if (videoList[index].videoQualityLabel == "480p")
                                    Text("SD   - ", style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.body1.color)),
                                    if (videoList[index].videoQualityLabel == "720p")
                                    Text("HD   - ", style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.body1.color)),
                                    if (videoList[index].videoQualityLabel == "1080p")
                                    Text("FHD - ", style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.body1.color)),
                                    if (videoList[index].videoQualityLabel == "1440p")
                                    Text("2K   - ", style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.body1.color)),
                                    if (videoList[index].videoQualityLabel == "2160p")
                                    Text("4K   - ", style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.body1.color)),
                                    if (videoList[index].videoQualityLabel == "4320p")
                                    Text("8K   - ", style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.body1.color)),
                                    Text(videoList[index].videoQualityLabel, style: TextStyle(color: Theme.of(context).textTheme.body1.color)),
                                    Text(" " + videoList[index].framerate.toString() + "fps", style: TextStyle(color: Theme.of(context).textTheme.body1.color)),
                                    Spacer(),
                                    Text(
                                      ((videoList[index].size/1024)/1024).toStringAsFixed(1) + "MB",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                         color: Theme.of(context).textTheme.body1.color
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  Navigator.of(context).pop();
                                  showToast(context, "Downloading Video...", Duration(seconds: 4));
                                  StreamController<double> downloadProgress = new StreamController.broadcast();
                                  StreamController<double> dataProgress = new StreamController.broadcast();
                                  StreamController<String> currentAction = new StreamController.broadcast();
                                  MediaMetaData _metadata = MediaMetaData(
                                    appdata.titleController.text,
                                    appdata.albumController.text,
                                    appdata.artistController.text,
                                    appdata.genreController.text,
                                    appdata.coverUrl,
                                    appdata.dateController.text,
                                    appdata.diskController.text,
                                    appdata.trackController.text
                                  );
                                  DownloadInfoSet _infoset = new DownloadInfoSet(
                                    downloadProgress,
                                    dataProgress,
                                    currentAction,
                                    DownloadType.video,
                                    audio,
                                    videoList,
                                    appdata.mediaStream,
                                    appdata.videoId,
                                    _metadata,
                                  );
                                  addToDownloadList(_infoset);
                                  _tabController.animateTo(1, duration: Duration(milliseconds: 200), curve: Curves.easeInBack);
                                  appdata.showFAB.add(false);
                                  await ActionHandler().handleVideoDownload(
                                  Provider.of<AppDataProvider>(context, listen: false),
                                    downloader,
                                    converter,
                                    _infoset,
                                    index
                                  );
                                  downloadProgress.close();
                                  currentAction.close();
                                  dataProgress.close();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    Brightness _systemBrightness = Theme.of(context).brightness;
    Brightness _statusBarBrightness = _systemBrightness == Brightness.light
        ? Brightness.dark
        : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: _statusBarBrightness,
        systemNavigationBarColor: Theme.of(context).canvasColor,
        systemNavigationBarIconBrightness: Theme.of(context).brightness,
      ),
    );
    return Scaffold(
        appBar: appData.appBarEnabled == true
        ? AppBar(
          title: Text(
            _appBarTitle,
            style: TextStyle(color: Theme.of(context).textTheme.body1.color),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
          centerTitle: true,
        )
        : PreferredSize(child: Container(), preferredSize: Size(kToolbarHeight*0.5, 0)),
        body: TabBarView(
          controller: _tabController,
          physics: BouncingScrollPhysics(),
          children: [
            HomeTab(),
            DownloadTab(),
            SettingsTab(),
          ]
        ),
        backgroundColor: Theme.of(context).canvasColor,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 8, right: 8),
          child: StreamBuilder<Object>(
            stream: appdata.showFAB.stream,
            builder: (context, snapshot) {
              return AnimatedOpacity(
                opacity: snapshot.data == true ? 1.0 : 0.0,
                duration: Duration(milliseconds: 200),
                curve: Curves.decelerate,
                child: FloatingActionButton(
                  child: Icon(Icons.file_download),
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        AnimationController controller;
                        Animation<double> scaleAnimation;
                        controller = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
                        scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
                        controller.addListener(() => setState(() {}));
                        controller.forward();
                        double height = MediaQuery.of(context).size.height;
                        double width = MediaQuery.of(context).size.width;
                        appdata.unloadFocus();
                        return Center(
                          child: Material(
                            color: Colors.transparent,
                            child: FadeTransition(
                              opacity: scaleAnimation,
                              child: Container(
                                child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                height: height*0.5,
                                width: width*0.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    // Download title
                                    Container(
                                      height: height*0.1,
                                      width: width*0.2,
                                      color: Colors.transparent,
                                      child: Center(
                                        child: Text(
                                          "Download",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Download Audio
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: InkWell(
                                        onTap: () async {
                                          showToast(context, "Downloading Audio...", Duration(seconds: 4));
                                          Downloader downloader = new Downloader();
                                          Converter converter = new Converter();
                                          youtube.AudioStreamInfo audio = appdata.audio;
                                          List<youtube.VideoStreamInfo> videoList;
                                          StreamController<double> downloadProgress = new StreamController.broadcast();
                                          StreamController<double> dataProgress = new StreamController.broadcast();
                                          StreamController<String> currentAction = new StreamController.broadcast();
                                          MediaMetaData _metadata = MediaMetaData(
                                            appdata.titleController.text,
                                            appdata.albumController.text,
                                            appdata.artistController.text,
                                            appdata.genreController.text,
                                            appdata.coverUrl,
                                            appdata.dateController.text,
                                            appdata.diskController.text,
                                            appdata.trackController.text
                                          );
                                          DownloadInfoSet _infoset = new DownloadInfoSet(
                                            downloadProgress,
                                            dataProgress,
                                            currentAction,
                                            DownloadType.audio,
                                            audio,
                                            videoList,
                                            appdata.mediaStream,
                                            appdata.videoId,
                                            _metadata,
                                          );
                                          addToDownloadList(_infoset);
                                          Navigator.pop(context);
                                          _tabController.animateTo(1, duration: Duration(milliseconds: 200), curve: Curves.easeInBack);
                                          await ActionHandler().handleAudioDownload(
                                            Provider.of<AppDataProvider>(context, listen: false),
                                            downloader,
                                            converter,
                                            _infoset,
                                          );
                                          downloadProgress.close();
                                          currentAction.close();
                                          dataProgress.close();
                                        },
                                        child: Container(
                                          height: height*0.13,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor.withOpacity(0.85),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.4),
                                                blurRadius: 10.0,
                                                spreadRadius: 0.1,
                                                offset: Offset(
                                                  1.0,
                                                  5.0,
                                                ),
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(left: 16, right: 16),
                                                child: Icon(Icons.music_note, size: 30)
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "Song",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 8.0),
                                                      child: Text(
                                                        "Download Song from video at maximum Quality",
                                                        maxLines: 2,
                                                        overflow: TextOverflow.clip,
                                                        softWrap: true,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height*0.02,
                                    ),
                                    // Download Video
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: InkWell(
                                        onTap: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (context) => _videoQualityWidget(context)
                                          );
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          height: height*0.13,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor.withOpacity(0.85),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.4),
                                                blurRadius: 10.0,
                                                spreadRadius: 0.1,
                                                offset: Offset(
                                                  1.0,
                                                  5.0,
                                                ),
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(left: 16, right: 16),
                                                child: Icon(Icons.videocam, size: 30)
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "Video",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 8.0),
                                                      child: Text(
                                                        "Select Quality to download Video",
                                                        maxLines: 2,
                                                        overflow: TextOverflow.clip,
                                                        softWrap: true,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                          ),
                              ),
                        ),
                      ),
                    );
                  },
                );
              }
              )
              );
            }
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: StreamBuilder<Object>(
              stream: _tabstream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData){
                return Theme(
                  data: ThemeData(
                    canvasColor: Theme.of(context).cardColor
                  ),
                  child: BottomNavigationBar(
                    elevation: 0,
                    backgroundColor: Theme.of(context).cardColor,
                    unselectedItemColor: Theme.of(context).iconTheme.color,
                    showSelectedLabels: false,
                    fixedColor: Colors.red,
                    showUnselectedLabels: false,
                    currentIndex: snapshot.data,
                    onTap: (int _index) {
                      setState(() {
                        _tabController.index = _index;
                        _tabstream.add(_index);
                        if (_index != 0) {
                          appdata.showFAB.add(false);
                        } else {
                          appdata.showFAB.add(true);
                        }
                      });
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Icon(Icons.home),
                            AnimatedSize(
                              duration: Duration(milliseconds: 200),
                              vsync: this,
                              curve: Curves.easeInBack,
                              child: snapshot.data == 0
                              ? Text(
                                "  Home",
                                style: TextStyle(
                                color: Theme.of(context).textTheme.body1.color
                                ),
                              )
                              : Container()
                            ),
                          ]
                        ),
                        title: Text("")
                      ),
                      BottomNavigationBarItem(
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Icon(Icons.cloud_download),
                            AnimatedSize(
                              duration: Duration(milliseconds: 200),
                              vsync: this,
                              curve: Curves.easeInBack,
                              child: snapshot.data == 1
                              ? Text(
                                "  Downloads",
                                style: TextStyle(
                                color: Theme.of(context).textTheme.body1.color
                                ),
                              )
                              : Container()
                            ),
                          ]
                        ),
                        title: Text("")
                      ),
                      BottomNavigationBarItem(
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Icon(Icons.settings),
                            AnimatedSize(
                              duration: Duration(milliseconds: 200),
                              vsync: this,
                              curve: Curves.easeInBack,
                              child: snapshot.data == 2
                              ? Text(
                                "  Settings",
                                style: TextStyle(
                                color: Theme.of(context).textTheme.body1.color
                                ),
                              )
                              : Container()
                            ),
                          ]
                        ),
                        title: Text("")
                      ),
                    ]
                    ),
                );
                } else {
                  return Container();
                }
              }
            ),
          ),
        ),
    );
  }
}
