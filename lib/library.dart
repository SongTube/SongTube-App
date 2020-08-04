// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Internal
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/internal/playerService.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/downloads.dart';
import 'package:songtube/screens/home.dart';
import 'package:songtube/screens/more.dart';
import 'package:songtube/screens/navigate.dart';

// Packages
import 'package:permission_handler/permission_handler.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

// UI
import 'package:songtube/ui/elementsUI.dart';
import 'package:songtube/screens/musicPlayer.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> with WidgetsBindingObserver, TickerProviderStateMixin {

  @override
  void initState() {
    checkPermissions();
    super.initState();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment=false;
  }

  // App external storage permission check
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      String _url; String _id;
      await NativeMethod.handleIntent().then((resultText) => _url = resultText);
      if (_url == null) return;
      _id = yt.VideoId.parseVideoId(_url);
      if (_id == null) return;
    }
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    Brightness _themeBrightness = Theme.of(context).brightness;
    Brightness _systemBrightness = Theme.of(context).brightness;
    Brightness _statusBarBrightness = _systemBrightness == Brightness.light
        ? Brightness.dark
        : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: _statusBarBrightness,
        statusBarIconBrightness: _statusBarBrightness,
        systemNavigationBarColor: Theme.of(context).cardColor,
        systemNavigationBarIconBrightness: _themeBrightness
      ),
    );
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        key: manager.libraryScaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            kToolbarHeight*0.05
          ),
          child: Container(
            color: manager.screenIndex != 0
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).cardColor
          ),
        ),
        body: WillPopScope(
          onWillPop: () => manager.handlePop(),
          child: Stack(
            children: <Widget>[
              IgnorePointer(
                ignoring: manager.screenIndex == 0 ? false : true,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: manager.screenIndex == 0 ? 1.0 : 0.0,
                  child: HomeScreen()
                )
              ),
              IgnorePointer(
                ignoring: manager.screenIndex == 1 ? false : true,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: manager.screenIndex == 1 ? 1.0 : 0.0,
                  child: DownloadTab()
                )
              ),
              IgnorePointer(
                ignoring: manager.screenIndex == 2 ? false : true,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: manager.screenIndex == 2 ? 1.0 : 0.0,
                  child: manager.screenIndex == 2 ? Navigate() : Container(),
                )
              ),
              IgnorePointer(
                ignoring: manager.screenIndex == 3 ? false : true,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: manager.screenIndex == 3 ? 1.0 : 0.0,
                  child: MoreScreen(),
                )
              ),
              StreamBuilder<ScreenState>(
                stream: manager.screenStateStream,
                builder: (context, snapshot) {
                  final screenState = snapshot.data;
                  final state = screenState?.playbackState;
                  final processingState =
                    state?.processingState ?? AudioProcessingState.none;
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: processingState != AudioProcessingState.none
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              FullPlayerWidget(pushedFrom: "SongTube")));
                          },
                          child: Container(
                            width: 54,
                            height: 54,
                            margin: EdgeInsets.only(left: 12, top: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: appData.accentColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(3.5, 3.5), //(x,y)
                                  blurRadius: 5.0,
                                  spreadRadius: 2.1 
                                )
                              ]
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Container()
                  );
                }
              ),
            ],
          ),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          ),
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).cardColor,
            currentIndex: manager.screenIndex,
            elevation: 10,
            selectedFontSize: 14,
            selectedItemColor: Theme.of(context).accentColor,
            unselectedItemColor: Theme.of(context).iconTheme.color,
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              if (manager.showMediaPlayer == true) {
                manager.showMediaPlayer = false;
                Future.delayed(Duration(milliseconds: 150), () => manager.screenIndex = index);
              } else {
                manager.screenIndex = index;
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.homeOutline),
                title: Text("Home", style: TextStyle(
                  fontFamily: "Varela",
                  fontWeight: FontWeight.w600
                )),
              ),
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.cloudDownloadOutline),
                title: Text("Downloads", style: TextStyle(
                  fontFamily: "Varela",
                  fontWeight: FontWeight.w600
                )),
              ),
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.browserOutline),
                title: Text("YouTube", style: TextStyle(
                  fontFamily: "Varela",
                  fontWeight: FontWeight.w600
                )),
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.dotsHorizontal),
                title: Text("More", style: TextStyle(
                  fontFamily: "Varela",
                  fontWeight: FontWeight.w600
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}