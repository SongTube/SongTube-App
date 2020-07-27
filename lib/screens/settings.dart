// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:songtube/screens/settings/backupSettings.dart';
import 'package:songtube/screens/settings/converterSettings.dart';
import 'package:songtube/screens/settings/downloadSettings.dart';
import 'package:songtube/screens/settings/themeSettings.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Settings",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            // Themes Settings
            ThemeSettings(),
            // Downloads Settings
            DownloadSettings(),
            // Converter Settings
            ConverterSettings(),
            // Backup Options
            BackupSettings(),
          ],
        ),
      ),
    );
  }
}
