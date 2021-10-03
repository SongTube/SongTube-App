// Flutter
import 'package:animations/animations.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newpipeextractor_dart/extractors/playlist.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/models/playlist.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:newpipeextractor_dart/utils/url.dart';
import 'package:package_info/package_info.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/internal/systemUi.dart';

// Internal
import 'package:songtube/internal/updateChecker.dart';
import 'package:songtube/players/components/musicPlayer/collapsedPanel.dart';
import 'package:songtube/players/components/musicPlayer/expandedPanel.dart';
import 'package:songtube/players/components/youtubePlayer/collapsedPanel.dart';
import 'package:songtube/players/components/youtubePlayer/expandedPanel.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/screens/downloads.dart';
import 'package:songtube/screens/home.dart';
import 'package:songtube/screens/music.dart';
import 'package:songtube/screens/library.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:songtube/screens/subscriptions.dart';
import 'package:songtube/ui/components/fancyScaffold.dart';
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
  GlobalKey<ScaffoldState> _internalScaffoldKey;

  @override
  void initState() {
    super.initState();
    _screenIndex = 0;
    var keyboardVisibilityController = KeyboardVisibilityController();
    _internalScaffoldKey = GlobalKey<ScaffoldState>();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment=false;
    keyboardVisibilityController.onChange.listen((bool visible) {
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
        setState(() {});
        PreferencesProvider prefs = Provider.of<PreferencesProvider>(context, listen: false);
        DownloadsProvider downloads = Provider.of<DownloadsProvider>(context, listen: false);
        if (downloads.downloadingList.isNotEmpty ||
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
    Provider.of<MediaProvider>(context, listen: false).loadSongList().then((value) {
      Provider.of<ConfigurationProvider>(context, listen: false).preferences.saveCachedSongs(value);
    });
    Provider.of<MediaProvider>(context, listen: false).loadVideoList();
    // Disclaimer
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<ManagerProvider>(context, listen: false).internalScaffoldKey =
        this._internalScaffoldKey;
      _showSheets();
      _checkForUpdates();
    });
    AudioService.runningStream.listen((_) {
      setState(() {});
    });
    AudioService.currentMediaItemStream.listen((event) {
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
    if (config.showDownloadFixDialog && config.preferences.sdkInt >= 30) {
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
        double newVersion = double.parse(details.version
          .split("+").first.trim().replaceRange(3, 5, ""));
        if (appVersion < newVersion) {
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
      YoutubeVideo video = await VideoExtractor.getStream(intent);
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
    setSystemUiColor(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: _libBody()
    );
  }

  Widget _libBody() {
    return FancyScaffold(
      backgroundColor: Theme.of(context).cardColor,
      resizeToAvoidBottomInset: false,
      internalKey: _internalScaffoldKey,
      body: SafeArea(
        child: Consumer3<MediaProvider, ManagerProvider, VideoPageProvider>(
          builder: (context, mediaProvider, manager, pageProvider, child) {
            return WillPopScope(
              onWillPop: () {
                if (pageProvider.fwController.isAttached && pageProvider.fwController.isPanelOpen) {
                  pageProvider.fwController.close();
                  return Future.value(false);
                } else if (mediaProvider.slidingPanelOpen) {
                  mediaProvider.slidingPanelOpen = false;
                  mediaProvider.fwController.close();
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
      floatingWidgetTwins: _currentFloatingTwins(),
      floatingWidgetConfig: _currentFloatingWidetConfig(),
      floatingWidgetController: _currentFloatingWidgetController(),
    );
  }

  Widget _currentScreen(screenIndex) {
    if (screenIndex == 0) {
      return HomeScreen();
    } else if (screenIndex == 1) {
      return SubscriptionsScreen();
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
  
  FloatingWidgetTwins _currentFloatingTwins() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    if (pageProvider.infoItem != null) {
      return _youtubePlayerTwins();
    } else {
      if (AudioService?.currentMediaItem != null) {
        return _musicPlayerTwins();
      } else {
        return null;
      }
    }
  }
  
  FloatingWidgetConfig _currentFloatingWidetConfig() {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    if (pageProvider.infoItem != null) {
      return FloatingWidgetConfig(
        maxHeight: MediaQuery.of(context).size.height,
      );
    } else if (AudioService?.currentMediaItem != null) {
      return _floatingMusicWidgetConfig();
    } else {
      return FloatingWidgetConfig(
        maxHeight: MediaQuery.of(context).size.height,
      );
    }
  }

  FloatingWidgetTwins _musicPlayerTwins() {
    return FloatingWidgetTwins(
      expanded: ExpandedPlayer(),
      collapsed: CollapsedPanel()
    );
  }

  FloatingWidgetTwins _youtubePlayerTwins() {
    return FloatingWidgetTwins(
      expanded: YoutubePlayerVideoPage(),
      collapsed: VideoPageCollapsed()
    );
  }

  FloatingWidgetConfig _floatingMusicWidgetConfig() {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context, listen: false);
    return FloatingWidgetConfig(
      backdropBlurStrength: prefs.enableBlurUI ? 15 : 0,
      maxHeight: MediaQuery.of(context).size.height,
      onSlide: (double position) {
        int sdkInt = config.preferences.sdkInt;
        final iconColor = Theme.of(context).brightness == Brightness.dark
          ? Brightness.light : Brightness.dark;
        if (position > 0.95) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarIconBrightness: prefs.enablePlayerBlurBackground ? mediaProvider.textColor == Colors.black
                ? Brightness.dark : Brightness.light : iconColor,
              systemNavigationBarIconBrightness: prefs.enablePlayerBlurBackground ? sdkInt >= 30 ?
                mediaProvider.textColor == Colors.black ? Brightness.dark : Brightness.light : null : iconColor,
            ),
          );
        } else if (position < 0.95) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarIconBrightness: iconColor,
              systemNavigationBarIconBrightness: iconColor,
            ),
          );
        }
      }
    );
  }

  FloatingWidgetController _currentFloatingWidgetController() {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    if (pageProvider.infoItem != null) {
      return pageProvider.fwController;
    } else {
      if (AudioService?.currentMediaItem != null) {
        return mediaProvider.fwController;
      } else {
        return null;
      }
    }
  }

}