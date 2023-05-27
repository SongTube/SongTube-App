import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/screens/intro/pages/finish_page.dart';
import 'package:songtube/screens/intro/pages/intro_page.dart';
import 'package:songtube/screens/intro/pages/permissions_page.dart';
import 'package:songtube/screens/intro/pages/theme_page.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({ Key? key }) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  // User Songs Fetch Status
  bool songsFetchRunning = false;

  // Current Page Index
  int pageIndex = 0;

  void switchNext() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: pageIndex == 0
          ? accentColor
          : Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: pageIndex == 0
          ? Brightness.light
          : Theme.of(context).brightness
      )
    );
    setState(() {
      pageIndex = pageIndex+1;
    });
  }

  @override
  void initState() {
    // Clear data from previous SongTube so we avoid getting into weird bugs
    if (appFirstRun) {
      sharedPreferences.clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaProvider = Provider.of<MediaProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: pageIndex == 0
          ? accentColor
          : Colors.transparent,
        systemNavigationBarIconBrightness: pageIndex == 0
          ? Brightness.light
          : Theme.of(context).brightness,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: pageIndex == 0
          ? Brightness.light
          : Theme.of(context).brightness
      )
    );

    // Intro Pages
    List<Widget> pages = [
      // Intro
      IntroPage(onNextPage: switchNext),
      // Permissions
      PermissionIntroPage(
        onStorageGranted: (alreadyGranted) {
          if (!alreadyGranted) {
            mediaProvider.fetchMedia();
          }
          switchNext();
        },
      ),
      // Theme
      ThemeIntroPage(onNextPage: switchNext),
      // Finish
      FinishIntroPage(
        onIntroFinish: () {
          AppSettings.initSettings();
          initialRoute = 'home';
          Navigator.of(context).pushReplacementNamed('home', arguments: {'fetchSongs': false});
        },
      )
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedContainer(
        width: double.infinity,
        height: double.infinity,
        duration: const Duration(milliseconds: 400),
        color: pageIndex == 0
          ? accentColor
          : Theme.of(context).cardColor,
        child: DefaultTabController(
          initialIndex: pageIndex,
          length: 4,
          child: pages[pageIndex],
        ),
      ),
    );
  }
}