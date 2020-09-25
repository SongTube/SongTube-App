// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/screens/moreScreen/widgets/settings/widgets/backupSettings.dart';
import 'package:songtube/screens/moreScreen/widgets/settings/widgets/converterSettings.dart';
import 'package:songtube/screens/moreScreen/widgets/settings/widgets/downloadSettings.dart';
import 'package:songtube/screens/moreScreen/widgets/settings/widgets/themeSettings.dart';

class SettingsTab extends StatelessWidget {
  
  // Scaffold Key
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
              "Settings",
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
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            // Themes Settings
            ThemeSettings(),
            // Downloads Settings
            DownloadSettings(),
            // Converter Settings
            ConverterSettings(),
            // Backup Options
            BackupSettings(scaffoldKey: scaffoldState),
          ],
        ),
      ),
    );
  }
}
