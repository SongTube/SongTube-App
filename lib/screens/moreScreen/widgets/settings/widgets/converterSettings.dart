// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/screens/moreScreen/widgets/settings/columnTile.dart';

// Packages
import 'package:circular_check_box/circular_check_box.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:provider/provider.dart';

// UI
import 'package:songtube/ui/dialogs/alertDialog.dart';

class ConverterSettings extends StatefulWidget {
  @override
  _ConverterSettingsState createState() => _ConverterSettingsState();
}

class _ConverterSettingsState extends State<ConverterSettings> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    return SettingsColumnTile(
      title: "Converter",
      icon: EvaIcons.grid,
      children: <Widget>[
        ListTile(
          title: Text(
            "Convert Audio",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text("Enable/Disable Audio conversion.",
            style: TextStyle(fontSize: 12)
          ),
          trailing: CircularCheckBox(
            activeColor: Theme.of(context).accentColor,
            value: appData.enableAudioConvertion,
            onChanged: (bool newValue) async {
              if (newValue == false) {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlert(
                      leadingIcon: Icon(Icons.warning),
                      title: "Warning",
                      content: "Disabling audio conversion will disable Tags & Artwork writting",
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("OK"),
                        )
                      ],
                    );
                  }
                );
              }
              appData.enableAudioConvertion = newValue;
            },
          ),
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 200),
          vsync: this,
          curve: Curves.easeInOutBack,
          child: appData.enableAudioConvertion == true
            ? ListTile(
                title: Text(
                  "Audio Format",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.w500
                  ),
                ),
                subtitle: Text("Select audio format",
                  style: TextStyle(fontSize: 12)
                ),
                trailing: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: [
                      DropdownMenuItem<String>(
                        child: Text('AAC (.m4a)', style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w500
                        )),
                        value: 'AAC',
                      ),
                      DropdownMenuItem<String>(
                        child: Text('OGG (.ogg)', style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w500
                        )),
                        value: 'OGG Vorbis',
                      ),
                      DropdownMenuItem<String>(
                        child: Text('MP3 (.mp3)', style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w500
                        )),
                        value: 'MP3',
                      ),
                    ],
                    onChanged: (String value) async {
                      if (value == "OGG Vorbis") {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlert(
                              leadingIcon: Icon(Icons.warning),
                              title: "Warning",
                              content: "OGG doesn't support Artwork writting yet!",
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK"),
                                )
                              ],
                            );
                          }
                        );
                      }
                      appData.audioConvertFormat = value;
                    },
                    value: appData.audioConvertFormat,
                    elevation: 1,
                    dropdownColor: Theme.of(context).cardColor,
                  ),
                ),
              )
            : Container()
        ),
      ],
    );
  }
}