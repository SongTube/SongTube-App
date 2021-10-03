// Flutter
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:songtube/internal/globals.dart';
import 'package:songtube/internal/languages.dart';

// Internal
import 'package:songtube/intro/introduction.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/lib.dart';
import 'package:songtube/internal/legacyPreferences.dart';
import 'package:songtube/provider/mediaProvider.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/ui/internal/scrollBehavior.dart';
import 'package:newpipeextractor_dart/utils/reCaptcha.dart';
import 'package:newpipeextractor_dart/utils/navigationService.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

// UI
import 'package:songtube/ui/internal/themeValues.dart';

// Debug
import 'package:flutter/scheduler.dart' show timeDilation;

// const dsn = '';
// final sentry = SentryClient(SentryOptions(dsn: dsn));

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  globalPrefs = await SharedPreferences.getInstance();
  LegacyPreferences preferences = new LegacyPreferences();
  await preferences.initPreferences();
  final cachedSongs = await preferences.getCachedSongs();
  if (kDebugMode)
    timeDilation = 1.0;
  runApp(Main(
    preloadedFs: preferences,
    cachedSongs: cachedSongs,
  ));
  /* if (dsn.isNotEmpty) {
    runZonedGuarded(() => runApp(Main(preloadedFs: preferences)),
      (error, stackTrace) async {
        await sentry.captureException(
          error, stackTrace: stackTrace,
        );
      },
    );
    FlutterError.onError = (details, {bool forceReport = false}) {
      if (
        !(details.exception is AssertionError)
      ) {
        sentry.captureException(
          details.exception,
          stackTrace: details.stack,
        );
      }
    };
  } else {
    
  } */
}

class Main extends StatefulWidget {

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MainState>();
    state.setLocale(newLocale);
  }

  final LegacyPreferences preloadedFs;
  final List<MediaItem> cachedSongs;
  Main({
    @required this.preloadedFs,
    @required this.cachedSongs
  });

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  // Language
  Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConfigurationProvider>(
          create: (context) => ConfigurationProvider(preferences: widget.preloadedFs)
        ),
        ChangeNotifierProvider<ManagerProvider>(
          create: (context) => ManagerProvider()
        ),
        ChangeNotifierProvider<DownloadsProvider>(
          create: (context) => DownloadsProvider()
        ),
        ChangeNotifierProvider<MediaProvider>(
          create: (context) => MediaProvider(
            cachedSongs: widget.cachedSongs
          )
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (context) => PreferencesProvider(),
        ),
        ChangeNotifierProvider<VideoPageProvider>(
          create: (context) => VideoPageProvider(),
        ),
      ],
      child: Builder( builder: (context) {
        ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
        ThemeData customTheme;
        ThemeData darkTheme;

        darkTheme = config.blackThemeEnabled 
                    ? AppTheme.black(config.accentColor)
                    : AppTheme.dark(config.accentColor);

        customTheme = config.darkThemeEnabled
                      ? darkTheme
                      : AppTheme.white(config.accentColor);

        List<Locale> supportedLocales = [];
        supportedLanguages.forEach((element) =>
          supportedLocales.add(Locale(element.languageCode, '')));

        return MaterialApp(
          locale: _locale,
          supportedLocales: supportedLocales,
          localizationsDelegates: [
            FallbackLocalizationDelegate(),
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale?.languageCode == locale?.languageCode &&
                  supportedLocale?.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales?.first;
          },
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: child,
            );
          },
          navigatorKey: NavigationService.instance.navigationKey,
          title: "SongTube",
          theme: config.systemThemeEnabled
                 ? AppTheme.white(config.accentColor)
                 : customTheme,
          darkTheme: config.systemThemeEnabled
                     ? darkTheme
                     : customTheme,
          initialRoute: config.preferences.showIntroductionPages()
            ? 'introScreen'
            : 'homeScreen',
          routes: {
            'homeScreen':  (context) => AudioServiceWidget(child: Material(child: Lib())),
            'introScreen': (context) => IntroScreen(),
            'reCaptcha': (context) => ReCaptchaPage(),
          },
        );
      }),
    );
  }
}

