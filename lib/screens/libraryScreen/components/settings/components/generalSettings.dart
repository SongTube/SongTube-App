// Flutter
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/nativeMethods.dart';

// Internal
import 'package:songtube/screens/libraryScreen/components/settings/columnTile.dart';

class GeneralSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsColumnTile(
      title: Languages.of(context).labelGeneral,
      icon: Icons.architecture_rounded,
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
        )
      ],
    );
  }
}