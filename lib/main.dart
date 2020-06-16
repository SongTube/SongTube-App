// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/downloads_manager.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/library.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:provider/provider.dart';

// UI
import 'package:songtube/ui/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  AppDataProvider provider = AppDataProvider();
  provider.initProvider();
  await Future.delayed(Duration(milliseconds: 150), () {
    runApp(Main(provider));
  });
}

AppDataProvider appData;

class Main extends StatelessWidget {

  final AppDataProvider provider;
  Main(this.provider);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: provider),
        ChangeNotifierProvider<ManagerProvider>(create: (context) => ManagerProvider())
      ],
      child: Builder( builder: (context) {
        appData = Provider.of<AppDataProvider>(context);
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
          home: AudioServiceWidget(child: Library()),
        );
      }, ),
    );

  }
}

