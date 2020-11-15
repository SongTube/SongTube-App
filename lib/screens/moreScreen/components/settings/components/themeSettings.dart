// Flutter
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';

// Internal
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/screens/moreScreen/components/settings/dialogs/accentPicker.dart';
import 'package:songtube/screens/moreScreen/components/settings/columnTile.dart';

// Packages
import 'package:provider/provider.dart';

class ThemeSettings extends StatefulWidget {
  @override
  _ThemeSettingsState createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    ConfigurationProvider appData = Provider.of<ConfigurationProvider>(context);
    return SettingsColumnTile(
      title: Languages.of(context).labelTheme,
      icon: Icons.color_lens,
      children: <Widget>[
        ListTile(
          onTap: () => appData.systemThemeEnabled = !appData.systemThemeEnabled,
          title: Text(
            Languages.of(context).labelUseSystemTheme,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(Languages.of(context).labelUseSystemThemeJustification,
            style: TextStyle(fontSize: 12),),
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
                Languages.of(context).labelEnableDarkTheme,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontWeight: FontWeight.w500
                ),
              ),
              subtitle: Text(Languages.of(context).labelEnableDarkThemeJustification,
                style: TextStyle(fontSize: 12),),
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
            Languages.of(context).labelEnableBlackTheme,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(Languages.of(context).labelEnableBlackThemeJustification,
            style: TextStyle(fontSize: 12),),
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
            Languages.of(context).labelAccentColor,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(Languages.of(context).labelAccentColorJustification,
            style: TextStyle(fontSize: 12),),
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