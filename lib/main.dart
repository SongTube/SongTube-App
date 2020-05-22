// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/internal/focusnodes.dart';
import 'package:songtube/internal/textcontrollers.dart';
import 'package:songtube/provider/themes.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/library.dart';

// Packages
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  AppDataProvider provider = AppDataProvider();
  await provider.initProvider();
  runApp(Main(provider));
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
        Provider<FocusNodes>(create: (context) => FocusNodes()),
        Provider<TextControllers>(create: (context) => TextControllers()),
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
          home: Library(),
        );
      }, ),
    );

  }
}

