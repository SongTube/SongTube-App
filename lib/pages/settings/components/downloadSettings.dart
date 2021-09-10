// Dart
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';

// Internal
import 'package:songtube/provider/configurationProvider.dart';

// Packages
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';

// UI
import 'package:songtube/ui/dialogs/alertDialog.dart';

class DownloadSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context);
    return ListView(
      children: <Widget>[
        ListTile(
          isThreeLine: true,
          onTap: () {
            Permission.storage.request().then((status) {
              if (status == PermissionStatus.granted) {
                FilePicker.platform.getDirectoryPath().then((path) {
                  if (path != null) {
                    config.audioDownloadPath = path;
                  }
                });
              }
            });
          },
          title: Text(
            Languages.of(context).labelAudioFolder,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 12),
              children: [
                TextSpan(
                  text: Languages.of(context).labelAudioFolderJustification+"\n",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color
                      .withOpacity(0.8),
                  )
                ),
                TextSpan(
                  text: config.audioDownloadPath,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Theme.of(context).textTheme.bodyText1.color
                      .withOpacity(0.8),
                  )
                )
              ]
            ),
          ),
          trailing: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).scaffoldBackgroundColor
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(EvaIcons.folderOutline,
                color: Theme.of(context).iconTheme.color,
                size: 24),
            ),
          )
        ),
        ListTile(
          isThreeLine: true,
          onTap: () {
            Permission.storage.request().then((status) {
              if (status == PermissionStatus.granted) {
                FilePicker.platform.getDirectoryPath().then((path) {
                  if (path != null) {
                    config.videoDownloadPath = path;
                  }
                });
              }
            });
          },
          title: Text(
            Languages.of(context).labelVideoFolder,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 12),
              children: [
                TextSpan(
                  text: Languages.of(context).labelVideoFolderJustification+"\n",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color
                      .withOpacity(0.8),
                  )
                ),
                TextSpan(
                  text: config.videoDownloadPath,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Theme.of(context).textTheme.bodyText1.color
                      .withOpacity(0.8),
                  )
                )
              ]
            ),
          ),
          trailing: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).scaffoldBackgroundColor
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(EvaIcons.folderOutline,
                color: Theme.of(context).iconTheme.color,
                size: 24),
            ),
          )
        ),
        ListTile(
          title: Text(
            Languages.of(context).labelAlbumFolder,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(Languages.of(context).labelAlbumFolderJustification,
            style: TextStyle(fontSize: 12)
          ),
          trailing: Checkbox(
            activeColor: Theme.of(context).accentColor,
            value: config.enableAlbumFolder,
            onChanged: (bool newValue) async {
              config.enableAlbumFolder = newValue;
            },
          ),
        ),
        ListTile(
          title: Text(
            Languages.of(context).labelDeleteCache,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(Languages.of(context).labelDeleteCacheJustification,
            style: TextStyle(fontSize: 12)
          ),
          trailing: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).scaffoldBackgroundColor
            ),
            child: IconButton(
              icon: Icon(EvaIcons.trashOutline, color: Theme.of(context).iconTheme.color),
              onPressed: () async {
                double totalSize = 0;
                String tmpPath = (await getExternalStorageDirectory()).path;
                List<FileSystemEntity> listFiles = Directory(tmpPath).listSync();
                listFiles.forEach((element) {
                  if (element is File) {
                    totalSize += element.statSync().size;
                  }
                });
                totalSize = totalSize * 0.000001;
                if (totalSize < 1) {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return CustomAlert(
                        leadingIcon: Icon(MdiIcons.trashCan),
                        title: Languages.of(context).labelCleaning,
                        content: Languages.of(context).labelCacheIsEmpty,
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    }
                  );
                  return;
                }
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlert(
                      leadingIcon: Icon(MdiIcons.trashCan),
                      title: Languages.of(context).labelCleaning,
                      content: Languages.of(context).labelYouAreAboutToClear +
                        ": " + totalSize.toStringAsFixed(2) + "MB",
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            await Directory(tmpPath).delete(recursive: true);
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(Languages.of(context).labelCancel),
                        )
                      ],
                    );
                  }
                );
              },
            ), 
          )
        ),
        Divider(),
        ListTile(
          title: Text(
            "Maximum simultaneous downloads",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                "${prefs.maxSimultaneousDownloads}",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    thumbColor: Theme.of(context).accentColor,
                    activeTrackColor: Theme.of(context).accentColor,
                    inactiveTrackColor: Colors.black.withOpacity(0.1)
                  ),
                  child: Slider(
                    value: prefs.maxSimultaneousDownloads.toDouble(),
                    min: 1,
                    max: 10,
                    onChanged: (value) {
                      prefs.maxSimultaneousDownloads = value.round();
                    },
                    onChangeEnd: (value) {
                      downloadsProvider.maxSimultaneousDownloads = value.round();
                      downloadsProvider.checkQueue();
                    },
                  ),
                ),
              ),
              Text(
                "10",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
            ],
          )
        ),
      ],
    );
  }
}