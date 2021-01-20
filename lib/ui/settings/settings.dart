// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';

// Internal
import 'package:songtube/ui/settings/components/backupSettings.dart';
import 'package:songtube/ui/settings/components/downloadSettings.dart';
import 'package:songtube/ui/settings/components/generalSettings.dart';
import 'package:songtube/ui/settings/components/themeSettings.dart';

class SettingsTab extends StatefulWidget {
  
  // Scaffold Key
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  
  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          kToolbarHeight
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -2), //(x,y)
                blurRadius: 10.0,
                spreadRadius: 0.6
              ),
            ],
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              Languages.of(context).labelSettings,
              style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
            ),
            iconTheme: IconThemeData(
              color: Theme.of(context).iconTheme.color
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: ListView(
          
          children: <Widget>[
            // Themes Settings
            ThemeSettings(),
            // General Settings
            GeneralSettings(),
            // Downloads Settings
            DownloadSettings(),
            // Backup Options
            BackupSettings(scaffoldKey: scaffoldState),
          ],
        ),
      ),
    );
  }

}
