// Flutter
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/nativeMethods.dart';

class GeneralSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}