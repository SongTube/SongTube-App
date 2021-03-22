// Flutter
import 'package:animations/animations.dart';
import 'package:audio_service/audio_service.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newpipeextractor_dart/extractors/playlist.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/models/playlist.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:newpipeextractor_dart/utils/url.dart';
import 'package:package_info/package_info.dart';
import 'package:songtube/internal/nativeMethods.dart';

// Internal
import 'package:songtube/internal/updateChecker.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/players/youtubePlayer.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/screens/downloads.dart';
import 'package:songtube/screens/home.dart';
import 'package:songtube/screens/media.dart';
import 'package:songtube/screens/library.dart';
import 'package:songtube/players/musicPlayer.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:songtube/screens/music.dart';
import 'package:songtube/ui/components/autohideScaffold.dart';
import 'package:songtube/ui/components/navigationBar.dart';
import 'package:songtube/ui/components/styledBottomSheet.dart';
import 'package:songtube/ui/sheets/appUpdate.dart';
import 'package:songtube/ui/sheets/joinTelegram.dart';
import 'package:songtube/ui/dialogs/loadingDialog.dart';
import 'package:songtube/ui/sheets/disclaimer.dart';
import 'package:songtube/ui/sheets/downloadFix.dart';
import 'package:songtube/ui/internal/lifecycleEvents.dart';

class Lib extends StatefulWidget {
  @override
  _LibState createState() => _LibState();
}

class _LibState extends State<Lib> {

  // Current Screen Index
  int _screenIndex;

  // This Widget ScaffoldKey
  GlobalKey<AutoHideScaffoldState> _scaffoldStateKey;
  GlobalKey<ScaffoldState> _internalScaffoldKey;

  @override
  void initState() {
    super.initState();
    _screenIndex = 0;
    _scaffoldStateKey = new GlobalKey();
    _internalScaffoldKey = GlobalKey<ScaffoldState>();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment=false;
    KeyboardVisibility.onChange.listen((bool visible) {
        if (visible == false) FocusScope.of(context).unfocus();
      }
    );
    NativeMethod.handleIntent().then((intent) async {
      if (intent != null) {
        _handleIntent(intent);
      }
    });
    WidgetsBinding.instance.addObserver(
      new LifecycleEventHandler(resumeCallBack: () async {
        PreferencesProvider prefs = Provider.of<PreferencesProvider>(context, listen: false);
        DownloadsProvider downloads = Provider.of<DownloadsProvider>(context, listen: false);
        if (downloads.queueList.isNotEmpty ||
          downloads.downloadingList.isNotEmpty ||
          downloads.convertingList.isNotEmpty ||
          downloads.completedList.isNotEmpty
        ) {
          if (prefs.showJoinTelegramDialog && prefs.remindTelegramLater == false) {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
                )
              ),
              context: context,
              builder: (_) => Wrap(children: [
                JoinTelegramSheet()
              ])
            );
          }
        }
        String intent = await NativeMethod.handleIntent();
        if (intent == null) return;
        _handleIntent(intent);
        return;
      })
    );
    Provider.of<MediaProvider>(context, listen: false).loadSongList();
    Provider.of<MediaProvider>(context, listen: false).loadVideoList();
    // Disclaimer
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Save ScaffoldState Key
      Provider.of<ManagerProvider>(context, listen: false).scaffoldStateKey =
        this._scaffoldStateKey;
      Provider.of<ManagerProvider>(context, listen: false).internalScaffoldKey =
        this._internalScaffoldKey;
      _showSheets();
      _checkForUpdates();
    });
    AudioService.runningStream.listen((_) {
      setState(() {});
    });
  }

  void _showSheets() {
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context, listen: false);
    // Build our list of BottomSheets to show
    List<Widget> bottomSheets = [];
    if (!config.disclaimerAccepted) {
      bottomSheets.add(DisclaimerSheet());
      config.disclaimerAccepted = true;
    }
    if (config.showDownloadFixDialog) {
      bottomSheets.add(DownloadFixSheet());
      config.showDownloadFixDialog = false;
    }
    // Show our Sheets if there is any
    if (bottomSheets.isNotEmpty) {
      showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)
          )
        ),
        context: context,
        builder: (context) => Wrap(children: [
          StyledBottomSheetList(children: bottomSheets)
        ])
      );
    }
  }

  void _checkForUpdates() {
    PackageInfo.fromPlatform().then((android) {
      double appVersion = double
        .parse(android.version.replaceRange(3, 5, ""));
      getLatestRelease().then((details) {
        if (appVersion < details.version) {
          // Show the user an Update is available
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
              )
            ),
            context: context,
            builder: (context) => AppUpdateSheet(details)
          );
        }
      });
    });
  }

  void _handleIntent(String intent) async {
    String streamId = await YoutubeId.getIdFromStreamUrl(intent);
    String playlistId = await YoutubeId.getIdFromPlaylistUrl(intent);
    if (streamId != null) {
      showDialog(
        context: context,
        builder: (_) => LoadingDialog()
      );
      YoutubeVideo video = await VideoExtractor
        .getVideoInfoAndStreams(intent);
      Provider.of<VideoPageProvider>(context, listen: false)
        .infoItem = video.toStreamInfoItem();
      Navigator.pop(context);
    }
    if (playlistId != null) {
      showDialog(
        context: context,
        builder: (_) => LoadingDialog()
      );
      YoutubePlaylist playlist = await PlaylistExtractor
        .getPlaylistDetails(intent);
      Provider.of<VideoPageProvider>(context, listen: false)
        .infoItem = playlist.toPlaylistInfoItem();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: _libBody()
    );
  }

  Widget _libBody() {
    return AutoHideScaffold(
      backgroundColor: Theme.of(context).cardColor,
      resizeToAvoidBottomInset: false,
      key: _scaffoldStateKey,
      internalKey: _internalScaffoldKey,
      body: SafeArea(
        child: Consumer3<MediaProvider, ManagerProvider, VideoPageProvider>(
          builder: (context, mediaProvider, manager, pageProvider, child) {
            return WillPopScope(
              onWillPop: () {
                if (pageProvider.panelController.isAttached && pageProvider.panelController.isPanelOpen) {
                  pageProvider.panelController.close();
                  return Future.value(false);
                } else if (mediaProvider.slidingPanelOpen) {
                  mediaProvider.slidingPanelOpen = false;
                  mediaProvider.panelController.close();
                  return Future.value(false);
                } else if (_screenIndex != 0) {
                  setState(() => _screenIndex = 0);
                  return Future.value(false);
                } else if (manager.youtubeSearch != null) {
                  manager.youtubeSearch = null;
                  manager.setState();
                  return Future.value(false);
                } else if (_screenIndex == 0 && manager.currentHomeTab != HomeScreenTab.Trending) {
                  manager.currentHomeTab = HomeScreenTab.Trending;
                  return Future.value(false);
                } else {
                  return Future.value(true);
                }
              },
              child: child,
            );
          },
          child: PageTransitionSwitcher(
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return FadeThroughTransition(
                fillColor: Theme.of(context).cardColor,
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            duration: Duration(milliseconds: 300),
            child: _currentScreen(_screenIndex)
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _screenIndex,
        onItemTap: (int index) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          setState(() => _screenIndex = index);
        }
      ),
      floatingWidget: Consumer<VideoPageProvider>(
        builder: (context, provider, _) {
          return Stack(
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: provider.infoItem == null
                  ? SlidingPlayerPanel(
                      callback: (double position) {
                        _scaffoldStateKey.currentState
                          .updateInternalController(position);
                      },
                    )
                  : Container(),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: provider.infoItem != null
                  ? SlidableVideoPage(
                      callback: (double position) {
                        _scaffoldStateKey.currentState
                          .updateInternalController(position);
                      },
                    )
                  : Container(),
              )
            ],
          );
        }
      )
    );
  }

  Widget _currentScreen(screenIndex) {
    if (screenIndex == 0) {
      return HomeScreen();
    } else if (screenIndex == 1) {
      return MusicScreen();
    } else if (screenIndex == 2) {
      return DownloadTab();
    } else if (screenIndex == 3) {
      return MediaScreen();
    } else if (screenIndex == 4) {
      return LibraryScreen();
    } else {
      return Container();
    }
  }
  
}