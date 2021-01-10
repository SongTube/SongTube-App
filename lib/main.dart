// Flutter
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/randomString.dart';

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
import 'package:songtube/ui/internal/scrollBehavior.dart';

// UI
import 'package:songtube/ui/internal/themeValues.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LegacyPreferences preferences = new LegacyPreferences();
  await preferences.initPreferences();
  runApp(Main(preloadedFs: preferences));
}

class Main extends StatefulWidget {

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MainState>();
    state.setLocale(newLocale);
  }

  final LegacyPreferences preloadedFs;
  Main({
    @required this.preloadedFs
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
    List lastSearchQuery = (jsonDecode(widget.preloadedFs.getSearchHistory())
      as List<dynamic>).cast<String>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConfigurationProvider>(
          create: (context) => ConfigurationProvider(preferences: widget.preloadedFs)
        ),
        ChangeNotifierProvider<ManagerProvider>(
          create: (context) => ManagerProvider(
            lastSearchQuery.isNotEmpty
              ? lastSearchQuery[0]
              : RandomString.getRandomLetter()
          )
        ),
        ChangeNotifierProvider<DownloadsProvider>(
          create: (context) => DownloadsProvider()
        ),
        ChangeNotifierProvider<MediaProvider>(
          create: (context) => MediaProvider()
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (context) => PreferencesProvider(),
        )
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
            'homeScreen':  (context) => AudioServiceWidget(child: MainLib()),
            'introScreen': (context) => IntroScreen()
          },
        );
      }),
    );
  }
}

