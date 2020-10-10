// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Internal
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/player/widgets/musicPlayer/playerPadding.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/screens/downloads.dart';
import 'package:songtube/screens/home.dart';
import 'package:songtube/screens/media.dart';
import 'package:songtube/screens/more.dart';
import 'package:songtube/screens/navigate.dart';
import 'package:songtube/player/musicPlayer.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:songtube/ui/widgets/navigationBar.dart';
import 'package:songtube/ui/widgets/navigationItems.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// UI
import 'package:songtube/ui/internal/snackbar.dart';

class MainLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Library(),
          SlidingPlayerPanel()
        ],
      )
    );
  }
}

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment=false;
    KeyboardVisibility.onChange.listen((bool visible) {
        if (visible == false) FocusScope.of(context).unfocus();
      }
    );
    Provider.of<MediaProvider>(context, listen: false).loadSongList();
    Provider.of<MediaProvider>(context, listen: false).loadVideoList();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      String _url; String _id;
      await NativeMethod.handleIntent().then((resultText) => _url = resultText);
      if (_url == null) return;
      _id = VideoId.parseVideoId(_url);
      if (_id == null) return;
    }
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
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
        systemNavigationBarIconBrightness: _statusBarBrightness,
      ),
    );
    manager.downloadInfoSetList.forEach((element) {
      if (!element.currentAction.isClosed) {
        element.currentAction.stream.listen((event) {
          if (event == "Completed") {
            manager.getDatabase();
            setState(() {});
          }
          if (event == "Access Denied") {
            setState(() {});
          }
        });
      }
    });
    manager.snackBar = new AppSnack(
      scaffoldKey: manager.libraryScaffoldKey,
      context: context
    );
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        key: manager.libraryScaffoldKey,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: WillPopScope(
            onWillPop: () => manager.handlePop(manager.screenIndex),
            child: Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child: currentScreen(manager)
                  ),
                ),
                MusicPlayerPadding()
              ],
            ),
          ),
        ),
        bottomNavigationBar: AppBottomNavigationBar(
          onItemTap: (int index) => manager.screenIndex = index,
          navigationItems: BottomNavigationItems.items,
          currentIndex: manager.screenIndex
        ),
      ),
    );
  }

  Widget currentScreen(ManagerProvider manager) {
    if (manager.screenIndex == 0) {
      return HomeScreen();
    } else if (manager.screenIndex == 1) {
      return DownloadTab();
    } else if (manager.screenIndex == 2) {
      return MediaScreen();
    } else if (manager.screenIndex == 3) {
      return Navigate(
        searchQuery: manager.navigateIntent,
      );
    } else if (manager.screenIndex == 4) {
      return MoreScreen();
    } else {
      return Container();
    }
  }

  
}