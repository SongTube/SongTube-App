// Flutter
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/screens/settings/dialogs/accentPicker.dart';
import 'package:songtube/screens/settings/ui/columnTile.dart';

// Packages
import 'package:provider/provider.dart';

class ThemeSettings extends StatefulWidget {
  @override
  _ThemeSettingsState createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    return SettingsColumnTile(
      title: "Theme",
      icon: Icons.color_lens,
      children: <Widget>[
        ListTile(
          onTap: () => appData.systemThemeEnabled = !appData.systemThemeEnabled,
          title: Text(
            "Use System Theme",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text("Enable/Disable automatic theme", style: TextStyle(fontSize: 12),),
          trailing: CircularCheckBox(
            activeColor: Theme.of(context).accentColor,
            value: appData.systemThemeEnabled,
            onChanged: (bool newValue) {
              appData.systemThemeEnabled = newValue;
            },
          ),
        ),
        // Enable/Disable Dark Theme
        AnimatedSize(
          vsync: this,
          curve: Curves.easeInOutBack,
          duration: Duration(milliseconds: 500),
          child: appData.systemThemeEnabled == false
          ? ListTile(
              onTap: () => appData.darkThemeEnabled = !appData.darkThemeEnabled,
              title: Text(
                "Enable Dark Theme",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontWeight: FontWeight.w500
                ),
              ),
              subtitle: Text("Use dark theme by default", style: TextStyle(fontSize: 12),),
              trailing: CircularCheckBox(
                activeColor: Theme.of(context).accentColor,
                value: appData.darkThemeEnabled,
                onChanged: (bool newValue) {
                  appData.darkThemeEnabled = newValue;
                },
              ),
            )
          : Container()
        ),
        // Enable/Disable Black Theme
        ListTile(
          onTap: () => appData.blackThemeEnabled = !appData.blackThemeEnabled,
          title: Text(
            "Enable Black Theme",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text("Pure black theme", style: TextStyle(fontSize: 12),),
          trailing: CircularCheckBox(
            activeColor: Theme.of(context).accentColor,
            value: appData.blackThemeEnabled,
            onChanged: (bool newValue) {
              appData.blackThemeEnabled = newValue;
            },
          ),
        ),
        // App AccentColor Setting
        ListTile(
          onTap: () => appData.systemThemeEnabled = !appData.systemThemeEnabled,
          title: Text(
            "Accent Color",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text("Customize accent color", style: TextStyle(fontSize: 12),),
          trailing: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: IconButton(
              icon: Icon(Icons.colorize),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AccentPicker(
                      onColorChanged: (Color color) {
                        appData.accentColor = color;
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          )
        ),
      ],
    );
  }
}