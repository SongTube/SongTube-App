// Flutter
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';

// Internal
import 'package:songtube/screens/moreScreen/components/settings/components/backupSettings.dart';
import 'package:songtube/screens/moreScreen/components/settings/components/downloadSettings.dart';
import 'package:songtube/screens/moreScreen/components/settings/components/themeSettings.dart';

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
            actions: [
              _createLanguageDropDown(context)
            ],
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
            // Backup Options
            BackupSettings(scaffoldKey: scaffoldState),
          ],
        ),
      ),
    );
  }

  _createLanguageDropDown(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: DropdownButton<LanguageData>(
        iconSize: 30,
        icon: Icon(EvaIcons.globe2Outline,
          color: Theme.of(context).iconTheme.color),
        onChanged: (LanguageData language) {
          changeLanguage(context, language.languageCode);
        },
        underline: DropdownButtonHideUnderline(child: Container()),
        items: supportedLanguages
          .map<DropdownMenuItem<LanguageData>>(
            (e) =>
            DropdownMenuItem<LanguageData>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    e.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'YTSans',
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                  )
                ],
              ),
            ),
          )
          .toList(),
      ),
    );
  }

}
