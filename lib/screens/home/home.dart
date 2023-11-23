import 'dart:async';

import 'package:animations/animations.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newpipeextractor_dart/utils/url.dart';
import 'package:provider/provider.dart';
import 'package:receive_intent/receive_intent.dart' as intent;
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/screens/home/home_default/home_default.dart';
import 'package:songtube/screens/home/home_downloads/home_downloads.dart';
import 'package:songtube/screens/home/home_library/home_library.dart';
import 'package:songtube/screens/home/home_music/home_music.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/components/bottom_navigation_bar.dart';
import 'package:songtube/ui/components/fancy_scaffold.dart';
import 'package:songtube/ui/components/nested_will_pop_scope.dart';
import 'package:songtube/ui/sheets/disclaimer.dart';
import 'package:songtube/ui/sheets/join_telegram.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    this.initIntent,
    Key? key}) : super(key: key);
  final intent.Intent? initIntent;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {

  // Bottom Navigation Bar Current Index
  int bottomNavigationBarIndex = AppSettings.defaultLandingPage;

  // Intent Listener
  StreamSubscription? _sub;

  final List<Widget> screens = const [
    HomeDefault(),
    HomeMusic(),
    HomeDownloads(),
    HomeLibrary()
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _sub = intent.ReceiveIntent.receivedIntentStream.listen(processIntent, onError: (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // Check first run
      if (appFirstRun) {
        // Show Disclaimer
        await showModalBottomSheet(
          context: internalNavigatorKey.currentContext!,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const DisclaimerSheet());
        // Show join telegram
        await showModalBottomSheet(
          context: internalNavigatorKey.currentContext!,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const JoinTelegramSheet());
        await sharedPreferences.setBool('appFirstRun', false);
      }
      processIntent(widget.initIntent);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sub?.cancel();
    super.dispose();
  }

  void processIntent(intent.Intent? intent) async {
    ContentProvider contentProvider = Provider.of(context, listen: false);
    UiProvider uiProvider = Provider.of(context, listen: false);
    final url = intent?.extra?['android.intent.extra.TEXT'];
    if (url != null) {
      final video = await YoutubeId.getIdFromStreamUrl(url);
      final playlist = await YoutubeId.getIdFromPlaylistUrl(url);
      if (video != null || playlist != null) {
        await contentProvider.loadVideoPlayer(url);
        uiProvider.currentPlayer = CurrentPlayer.video;
        uiProvider.fwController.open();
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        Provider.of<MediaProvider>(context, listen: false).fetchMedia();
        if (kDebugMode) {
          print('App resumed');
          if (AppSettings.enableBackgroundPlayback) {
            ContentProvider contentProvider = Provider.of(context, listen: false);
            audioHandler.customAction('stopBackgroundPlayback').then((data) {
              final controller = contentProvider.playingContent!.videoPlayerController.videoPlayerController!;
              final position = Duration(seconds: data['position']);
              if (position == controller.value.position) {
                controller.play();
              } else {
                controller.seekTo(position).then((_) {
                  controller.play();
                });
              }}
            );
          }
        }
        ContentProvider contentProvider = Provider.of(context, listen: false);
        contentProvider.setState();
        break;
      case AppLifecycleState.inactive:
        if (kDebugMode) {
          print('App inactive');
        }
        break;
      case AppLifecycleState.paused:
        if (kDebugMode) {
          print('App paused');
        }
        if (AppSettings.enableBackgroundPlayback) {
          ContentProvider contentProvider = Provider.of(context, listen: false);
          final playing = contentProvider.playingContent != null
            && (contentProvider.playingContent?.videoPlayerController.videoPlayerController?.value.isPlaying ?? false);
          if (playing) {
            contentProvider.playingContent!.videoPlayerController.videoPlayerController!.pause().then((_) {
              final controller = contentProvider.playingContent!.videoPlayerController.videoPlayerController!.value;
              audioHandler.customAction('initBackgroundPlayback', {
                'position': controller.position.inSeconds,
                'audioUrl': contentProvider.playingContent!.videoDetails!.audioWithBestAacQuality!.url,
                'videoStream': contentProvider.playingContent!.videoDetails!.toStreamInfoItem().toMap(),
              });
            });
          }
        }
        break;
      case AppLifecycleState.detached:
        if (kDebugMode) {
          print('App detached');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Theme.of(context).brightness,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).cardColor,
        systemNavigationBarIconBrightness: Theme.of(context).brightness,
      )
    );
    final ContentProvider contentProvider = Provider.of(context);
    final UiProvider uiProvider = Provider.of(context);
    return NestedWillPopScope(
      onWillPop: () {
        if (uiProvider.fwController.isPanelOpen) {
          uiProvider.fwController.close();
          return Future.value(false);
        } else {
          if (uiProvider.onAltRoute) {
            return Future.value(true);
          } else {
            if (bottomNavigationBarIndex == 0) {
              if (uiProvider.homeSearchNode.hasFocus) {
                uiProvider.homeSearchNode.unfocus();
                contentProvider.setState();
                return Future.value(false);
              }
              if (contentProvider.searchContent != null) {
                contentProvider.clearSearchContent();
                return Future.value(false);
              }
            }
            if (bottomNavigationBarIndex == 1) {
              if (uiProvider.musicSearchNode.hasFocus) {
                uiProvider.musicSearchNode.unfocus();
                contentProvider.setState();
                return Future.value(false);
              }
              if (uiProvider.musicSearchController.text.isNotEmpty) {
                uiProvider.musicSearchController.clear();
                uiProvider.setState();
                return Future.value(false);
              }
            }
            return Future.value(true);
          }
        }
      },
      child: FancyScaffold(
        body: PageTransitionSwitcher(
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              fillColor: Colors.transparent,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          duration: const Duration(milliseconds: 300),
          child: screens[bottomNavigationBarIndex]
        ),
        bottomNavigationBar: SongTubeNavigation(
          selectedIndex: bottomNavigationBarIndex,
          backgroundColor: Theme.of(context).cardColor,
          onItemTap: (int tappedIndex) {
            setState(() {
              bottomNavigationBarIndex = tappedIndex;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(EvaIcons.homeOutline, color: Theme.of(context).iconTheme.color!.withOpacity(0.4)),
              selectedIcon: const AppAnimatedIcon(EvaIcons.homeOutline),
              label: Languages.of(context)!.labelHome,
            ),
            NavigationDestination(
              icon: Icon(EvaIcons.musicOutline, color: Theme.of(context).iconTheme.color!.withOpacity(0.4)),
              selectedIcon: const AppAnimatedIcon(EvaIcons.musicOutline),
              label: Languages.of(context)!.labelMusic,
            ),
            NavigationDestination(
              icon: Icon(EvaIcons.downloadOutline, color: Theme.of(context).iconTheme.color!.withOpacity(0.4)),
              selectedIcon: const AppAnimatedIcon(EvaIcons.downloadOutline),
              label: Languages.of(context)!.labelDownloads,
            ),
            NavigationDestination(
              icon: Icon(EvaIcons.bookOpenOutline, color: Theme.of(context).iconTheme.color!.withOpacity(0.4)),
              selectedIcon: const AppAnimatedIcon(EvaIcons.bookOpenOutline),
              label: Languages.of(context)!.labelLibrary,
            ),
          ],
        ),
      ),
    );
  }

}