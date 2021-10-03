// Flutter
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/provider/preferencesProvider.dart';

class GeneralSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return ListView(
      children: <Widget>[
        FutureBuilder(
          future: DeviceInfoPlugin().androidInfo,
          builder: (context, AsyncSnapshot<AndroidDeviceInfo> info) {
            if (info.hasData && info.data.version.sdkInt > 29) {
              return ListTile(
                title: Text(
                  Languages.of(context).labelAndroid11Fix,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.w500
                  ),
                ),
                subtitle: Text(Languages.of(context).labelAndroid11FixJustification,
                  style: TextStyle(fontSize: 12)
                ),
                onTap: () {
                  NativeMethod.requestAllFilesPermission();
                },
              );
            } else {
              return Container();
            }
          }
        ),
        ListTile(
          title: Text(
            Languages.of(context).labelLanguage,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          trailing: Container(
            color: Colors.transparent,
            child: DropdownButton<LanguageData>(
              iconSize: 30,
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
          ),
        ),
        SwitchListTile(
          title: Text(
            "Picture in Picture",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(
            "Automatically enters PiP mode upon tapping Home button while watching a video",
            style: TextStyle(fontSize: 12)
          ),
          value: prefs.autoPipMode,
          onChanged: (value) => prefs.autoPipMode = value,
        ),
        // AutoPlay
        SwitchListTile(
          title: Text(
            "Auto-play videos",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(
            "Automatically play videos on the video page",
            style: TextStyle(fontSize: 12)
          ),
          value: prefs.videoPageAutoPlay,
          onChanged: (value) => prefs.videoPageAutoPlay = value,
        ),
        // SearchBar Auto-Correct
        SwitchListTile(
          title: Text(
            "Text Correction",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(
            "Enable or disable text correction in the Home screen search bar",
            style: TextStyle(fontSize: 12)
          ),
          value: prefs.autocorrectSearchBar,
          onChanged: (value) => prefs.autocorrectSearchBar = value,
        ),
        // Enable/Disable Watch History
        SwitchListTile(
          title: Text(
            "Enable Watch History",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          value: prefs.enableWatchHistory,
          onChanged: (value) => prefs.enableWatchHistory = value,
        ),
      ],
    );
  }
}