// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:songtube/internal/languages.dart';

// Internal
import 'package:songtube/intro/introduction.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/library.dart';
import 'package:songtube/internal/preferences.dart';
import 'package:songtube/provider/mediaProvider.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:provider/provider.dart';

// UI
import 'package:songtube/ui/internal/themeValues.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Preferences preferences = new Preferences();
  await preferences.initPreferences();
  runApp(Main(preloadedFs: preferences));
}

class Main extends StatefulWidget {

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MainState>();
    state.setLocale(newLocale);
  }

  final Preferences preloadedFs;
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
          create: (context) => MediaProvider()
        )
      ],
      child: Builder( builder: (context) {
        ConfigurationProvider appData = Provider.of<ConfigurationProvider>(context);        
        ThemeData customTheme;
        ThemeData darkTheme;

        darkTheme = appData.blackThemeEnabled 
                    ? AppTheme.black(appData.accentColor)
                    : AppTheme.dark(appData.accentColor);

        customTheme = appData.darkThemeEnabled
                      ? darkTheme
                      : AppTheme.white(appData.accentColor);

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
          title: "SongTube",
          theme: appData.systemThemeEnabled
                 ? AppTheme.white(appData.accentColor)
                 : customTheme,
          darkTheme: appData.systemThemeEnabled
                     ? darkTheme
                     : customTheme,
          initialRoute: appData.preferences.showIntroductionPages()
            ? 'introScreen'
            : 'homeScreen',
          routes: {
            'homeScreen':  (context) => AudioServiceWidget(child: MainLibrary()),
            'introScreen': (context) => IntroScreen()
          },
        );
      }),
    );
  }
}

