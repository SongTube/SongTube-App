// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/internal/preferences.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/library.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:provider/provider.dart';
import 'package:songtube/screens/introduction.dart';
import 'package:songtube/ui/snackbar.dart';

// UI
import 'package:songtube/ui/themeValues.dart';

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
        ChangeNotifierProvider<AppDataProvider>(create: (context) => AppDataProvider(
          preferences: preloadedFs
        )),
        ChangeNotifierProvider<ManagerProvider>(create: (context) => ManagerProvider())
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
            'homeScreen':  (context) => AudioServiceWidget(child: Library()),
            'introScreen': (context) => IntroScreen()
          },
        );
      }, ),
    );

  }
}

