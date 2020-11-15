// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

// Internal
import 'package:songtube/internal/updateChecker.dart';
import 'package:songtube/player/components/musicPlayer/playerPadding.dart';
import 'package:songtube/provider/configurationProvider.dart';
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
import 'package:songtube/ui/components/navigationBar.dart';
import 'package:songtube/ui/dialogs/appUpdateDialog.dart';
import 'package:songtube/ui/internal/disclaimerDialog.dart';
import 'package:songtube/ui/internal/downloadFixDialog.dart';
import 'package:songtube/ui/internal/lifecycleEvents.dart';

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

class _LibraryState extends State<Library> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment=false;
    KeyboardVisibility.onChange.listen((bool visible) {
        if (visible == false) FocusScope.of(context).unfocus();
      }
    );
    WidgetsBinding.instance.addObserver(
      new LifecycleEventHandler(resumeCallBack: () {
        Provider.of<ManagerProvider>(context, listen: false).handleIntent();
        return;
      })
    );
    Provider.of<MediaProvider>(context, listen: false).loadSongList();
    Provider.of<MediaProvider>(context, listen: false).loadVideoList();
    // Disclaimer
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Show Disclaimer
      if (!Provider.of<ConfigurationProvider>(context, listen: false).disclaimerAccepted) {
        await showDialog(
          context: context,
          builder: (context) => DisclaimerDialog()
        );
      }
      if (Provider.of<ConfigurationProvider>(context, listen: false).showDownloadFixDialog) {
        await showDialog(
          context: context,
          builder: (context) => DownloadFixDialog()
        );
        Provider.of<ConfigurationProvider>(context, listen: false)
          .showDownloadFixDialog = false;
      }
      // Check for Updates
      PackageInfo.fromPlatform().then((android) {
        double appVersion = double
          .parse(android.version.replaceRange(3, 5, ""));
        getLatestRelease().then((details) {
          if (appVersion < details.version) {
            // Show the user an Update is available
            showDialog(
              context: context,
              builder: (context) => AppUpdateDialog(details)
            );
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    manager.snackBar = new AppSnack(
      scaffoldKey: manager.libraryScaffoldKey,
      context: context
    );
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        key: manager.libraryScaffoldKey,
        body: SafeArea(
          child: WillPopScope(
            onWillPop: () {
              if (mediaProvider.slidingPanelOpen) {
                mediaProvider.slidingPanelOpen = false;
                mediaProvider.panelController.close();
                return Future.value(false);
              } else if (manager.showSearchBar) {
                manager.showSearchBar = false;
                return Future.value(false);
              } else {
                return manager.handlePop(manager.screenIndex);
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child: _currentScreen(manager)
                  ),
                ),
                MusicPlayerPadding(manager.showSearchBar)
              ],
            ),
          ),
        ),
        bottomNavigationBar: AppBottomNavigationBar(
          onItemTap: (int index) => manager.screenIndex = index,
          currentIndex: manager.screenIndex
        ),
      ),
    );
  }

  Widget _currentScreen(manager) {
    if (manager.screenIndex == 0) {
      return HomeScreen();
    } else if (manager.screenIndex == 1) {
      return DownloadTab();
    } else if (manager.screenIndex == 2) {
      return MediaScreen();
    } else if (manager.screenIndex == 3) {
      return Navigate(
        searchQuery: manager.navigateQuery,
      );
    } else if (manager.screenIndex == 4) {
      return MoreScreen();
    } else {
      return Container();
    }
  }

  
}