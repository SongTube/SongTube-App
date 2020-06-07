// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Internal
import 'package:songtube/internal/native.dart';
import 'package:songtube/internal/youtube/infoparser.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/provider/player_provider.dart';
import 'package:songtube/screens/donate.dart';
import 'package:songtube/screens/downloads.dart';
import 'package:songtube/screens/home.dart';
import 'package:songtube/screens/navigate.dart';
import 'package:songtube/screens/settings.dart';

// Packages
import 'package:permission_handler/permission_handler.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:songtube/ui/reusable/alertdialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

// UI
import 'package:songtube/ui/drawer_layout.dart';
import 'package:songtube/ui/reusable/drawer_item.dart';
import 'package:songtube/ui/snackbar.dart';
import 'package:songtube/ui/ui_elements.dart';
import 'package:songtube/ui/downloads_screen/player_widget.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> with WidgetsBindingObserver, TickerProviderStateMixin {

  // Constants
  static const String _appName = "SongTube";
  static const String _navigateTitle = "Youtube";

  // Local Variables
  DateTime currentBackPressTime;
  List<String> _appBarTitle = [_appName, "Downloads", _navigateTitle, "Settings", "Donate"];

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
      _id = YoutubeInfo.getLinkID(_url);
      if (_id == null) return;
    }
  }

  Future<bool> handlePop(AppDataProvider provider) async {
    if (provider.screenIndex != 0) {
      setState(() {
        provider.screenIndex = 0;
      });
      return false;
    } else {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null || 
          now.difference(currentBackPressTime) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        appSnack.pressAgainExit();
        return Future.value(false);
      }
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        statusBarIconBrightness: appData.screenIndex == 2 ? Brightness.light : _statusBarBrightness,
        systemNavigationBarColor: appData.screenIndex == 2 ? Colors.redAccent : Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: _themeBrightness
      ),
    );
    Player audioPlayer = Provider.of<Player>(context);
    appSnack = new AppSnack(scaffoldKey: appData.libraryScaffoldKey, context: context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        key: appData.libraryScaffoldKey,
        appBar: AppBar(
          title: appData.screenIndex == 2
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(MdiIcons.youtube, color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                    _appBarTitle[appData.screenIndex],
                    style: TextStyle(
                      color: appData.screenIndex == 2
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyText1.color
                    )
                  )
                ],
              )
            : Text(
                _appBarTitle[appData.screenIndex],
                style: TextStyle(
                  color: appData.screenIndex == 2
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyText1.color
                )
              ),
          elevation: 0,
          backgroundColor: appData.screenIndex == 2
            ? Colors.redAccent
            : Colors.transparent,
          centerTitle: true,
          leading: appData.screenIndex == 2
            ? Container()
            : null,
          iconTheme: new IconThemeData(color: Theme.of(context).iconTheme.color),
          actions: <Widget>[
            AnimatedOpacity(
              opacity: audioPlayer.playerState == PlayerState.playing || audioPlayer.playerState == PlayerState.paused ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: PlayerWidget(
                playerState: audioPlayer.playerState,
                onPlayPauseTap: () {
                  if (audioPlayer.playerState == PlayerState.paused) audioPlayer.play();
                  if (audioPlayer.playerState == PlayerState.playing) audioPlayer.pause();
                },
                onPlayPauseLongPress: () => audioPlayer.stop(),
                showPlayPause: audioPlayer.showMediaPlayer ? false : true,
                leadingIcon: Icon(audioPlayer.showMediaPlayer ? Icons.expand_less : Icons.expand_more),
                leadingAction: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  setState(() {
                    audioPlayer.showMediaPlayer = !audioPlayer.showMediaPlayer;
                  });
                },
              ),
            ),
            SizedBox(width: 12)
          ],
        ),
        resizeToAvoidBottomPadding: true,
        body: WillPopScope(
          onWillPop: () => handlePop(appData),
          child: Stack(
            children: <Widget>[
              IgnorePointer(
                ignoring: appData.screenIndex == 0 ? false : true,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: appData.screenIndex == 0 ? 1.0 : 0.0,
                  child: HomeScreen()
                )
              ),
              IgnorePointer(
                ignoring: appData.screenIndex == 1 ? false : true,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: appData.screenIndex == 1 ? 1.0 : 0.0,
                  child: DownloadTab()
                )
              ),
              IgnorePointer(
                ignoring: appData.screenIndex == 2 ? false : true,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: appData.screenIndex == 2 ? 1.0 : 0.0,
                  child: appData.screenIndex == 2 ? Navigate() : Container(),
                )
              ),
              IgnorePointer(
                ignoring: appData.screenIndex == 3 ? false : true,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: appData.screenIndex == 3 ? 1.0 : 0.0,
                  child: SettingsTab(),
                )
              ),
              IgnorePointer(
                ignoring: appData.screenIndex == 4 ? false : true,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: appData.screenIndex == 4 ? 1.0 : 0.0,
                  child: DonateScreen()
                )
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 150),
                child: audioPlayer.showMediaPlayer
                  ? FullPlayerWidget()
                  : Container()
              )
            ],
          ),
        ),
        drawerEdgeDragWidth: appData.screenIndex != 2 ? MediaQuery.of(context).size.width : 0,
        drawer: DrawerLayout(
          headerColor: Theme.of(context).tabBarTheme.labelColor,
          title: Text("SongTube", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
          children: <Widget>[
            DrawerItem(
              title: Text("Home", style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color,
               fontSize: 16, fontWeight: FontWeight.w600)),
              backgroundColor: Theme.of(context).tabBarTheme.labelColor,
              leadingIcon: MdiIcons.home,
              leadingIconColor: Colors.blue,
              padding: EdgeInsets.only(left: 20),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  appData.screenIndex = 0;
                });
              },
            ),
            SizedBox(height: 14),
            DrawerItem(
              title: Text("Downloads", style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color,
               fontSize: 16, fontWeight: FontWeight.w600)),
              backgroundColor: Theme.of(context).tabBarTheme.labelColor,
              leadingIcon: MdiIcons.download,
              leadingIconColor: Colors.green,
              padding: EdgeInsets.only(left: 20),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  appData.screenIndex = 1;
                });
              },
            ),
            SizedBox(height: 14),
            DrawerItem(
              title: Text("Youtube", style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color,
               fontSize: 16, fontWeight: FontWeight.w600)),
              backgroundColor: Theme.of(context).tabBarTheme.labelColor,
              leadingIcon: MdiIcons.play,
              leadingIconColor: Colors.red,
              padding: EdgeInsets.only(left: 20),
              onTap: () async {
                Navigator.pop(context);
                setState(() {
                  appData.screenIndex = 2;
                });
              },
            ),
          ],
          leftBottomIcon: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).tabBarTheme.labelColor,
              borderRadius: BorderRadius.circular(30)
            ),
            child: IconButton(
              icon: Icon(Icons.favorite, color: Colors.redAccent),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  appData.screenIndex = 4;
                });
              },
            ),
          ),
          middleBottomIcon: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).tabBarTheme.labelColor,
              borderRadius: BorderRadius.circular(30)
            ),
            child: IconButton(
              icon: Icon(MdiIcons.telegram, color: Colors.blue),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlert(
                      leadingIcon: Icon(MdiIcons.telegram, color: Colors.blue),
                      title: "Telegram",
                      content: "Join our Telegram Channel and Group! You'll get the latest app updates and you can request features and report bugs",
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Join"),
                          onPressed: () async {
                            Navigator.pop(context);
                            await launch("https://t.me/songtubechannel");
                          }
                        )
                      ],
                    );
                  }
                );
              },
            ),
          ),
          rightBottomIcon: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).tabBarTheme.labelColor,
              borderRadius: BorderRadius.circular(30)
            ),
            child: IconButton(
              icon: Icon(Icons.settings, color: Colors.grey),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  appData.screenIndex = 3;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}