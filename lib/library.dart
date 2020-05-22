// Dart
import 'dart:async';
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Internal
import 'package:songtube/internal/native.dart';
import 'package:songtube/internal/youtube/infoparser.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/provider/media_provider.dart';
import 'package:songtube/screens/donate.dart';
import 'package:songtube/screens/downloads.dart';
import 'package:songtube/screens/home.dart';
import 'package:songtube/screens/navigate.dart';
import 'package:songtube/screens/settings.dart';

// Packages
import 'package:permission_handler/permission_handler.dart';

// UI
import 'package:songtube/ui/drawer_layout.dart';
import 'package:songtube/ui/reusable/drawer_item.dart';
import 'package:songtube/ui/snackbar.dart';
import 'package:songtube/ui/ui_elements.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> with WidgetsBindingObserver, TickerProviderStateMixin {

  // Constants
  static const String _appName = "SongTube";
  static const String _navigateTitle = "youtube.com";
  static const String _navigateSelectedUrl = "https://youtube.com";

  // Local Variables
  DateTime currentBackPressTime;
  List<String> _appBarTitle = [_appName, "Downloads", _navigateTitle, "Settings", "Donate"];
  int _appBarTitleIndex = 0;

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
        _appBarTitleIndex = 0;
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
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: _themeBrightness,
      ),
    );
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    appSnack = new AppSnack(scaffoldKey: appData.libraryScaffoldKey, context: context);
    return Scaffold(
      key: appData.libraryScaffoldKey,
      appBar: AppBar(
        title: Text(_appBarTitle[_appBarTitleIndex], style: TextStyle(color: Theme.of(context).textTheme.body1.color)),
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        centerTitle: true,
        iconTheme: new IconThemeData(color: Theme.of(context).iconTheme.color),
      ),
      resizeToAvoidBottomPadding: true,
      body: WillPopScope(
        onWillPop: () => handlePop(appData),
        child: ChangeNotifierProvider(
          create: (context) => MediaProvider(),
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
                  child: appData.screenIndex == 2 ? Navigate(_navigateSelectedUrl) : Container(),
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
            ],
          ),
        ),
      ),
      drawerEdgeDragWidth: appData.screenIndex != 2 ? MediaQuery.of(context).size.width : 0,
      drawer: DrawerLayout(
        headerColor: Theme.of(context).tabBarTheme.labelColor,
        title: Text("SongTube", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
        children: <Widget>[
          DrawerItem(
            title: Text("Home", style: TextStyle(color: Theme.of(context).textTheme.body1.color)),
            backgroundColor: Theme.of(context).tabBarTheme.labelColor,
            leadingIcon: Icons.home,
            leadingIconColor: Colors.blueAccent,
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _appBarTitleIndex = 0;
                appData.screenIndex = 0;
              });
            },
          ),
          SizedBox(height: 14),
          DrawerItem(
            title: Text("Downloads", style: TextStyle(color: Theme.of(context).textTheme.body1.color)),
            backgroundColor: Theme.of(context).tabBarTheme.labelColor,
            leadingIcon: Icons.file_download,
            leadingIconColor: Colors.greenAccent,
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _appBarTitleIndex = 1;
                appData.screenIndex = 1;
              });
            },
          ),
          SizedBox(height: 14),
          DrawerItem(
            title: Text("Youtube", style: TextStyle(color: Theme.of(context).textTheme.body1.color)),
            backgroundColor: Theme.of(context).tabBarTheme.labelColor,
            leadingIcon: Icons.play_arrow,
            leadingIconColor: Colors.redAccent,
            onTap: () async {
              Navigator.pop(context);
              setState(() {
                _appBarTitleIndex = 2;
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
                _appBarTitleIndex = 4;
                appData.screenIndex = 4;
              });
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
                _appBarTitleIndex = 3;
                appData.screenIndex = 3;
              });
            },
          ),
        ),
      ),
    );
  }
}