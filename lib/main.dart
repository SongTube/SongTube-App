import 'package:flutter/material.dart';
import 'theme/themes.dart';
import 'package:provider/provider.dart';
import 'theme/theme_provider.dart';
import 'library.dart';

void main() => runApp(Main());

AppDataProvider appData;

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ ChangeNotifierProvider<AppDataProvider>.value(
        value: AppDataProvider(),
      ) ],
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

