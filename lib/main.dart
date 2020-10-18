// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/intro/introduction.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/app_provider.dart';
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

class Main extends StatelessWidget {

  final Preferences preloadedFs;
  Main({
    @required this.preloadedFs
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppDataProvider>(
          create: (context) => AppDataProvider(preferences: preloadedFs)
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
        AppDataProvider appData = Provider.of<AppDataProvider>(context);        
        ThemeData customTheme;
        ThemeData darkTheme;

        darkTheme = appData.blackThemeEnabled 
                    ? AppTheme.black(appData.accentColor)
                    : AppTheme.dark(appData.accentColor);

        customTheme = appData.darkThemeEnabled
                      ? darkTheme
                      : AppTheme.white(appData.accentColor);

        return MaterialApp(
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
      }, ),
    );

  }
}

