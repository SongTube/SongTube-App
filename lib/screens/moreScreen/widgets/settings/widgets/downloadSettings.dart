// Dart
import 'dart:io';

// Flutter
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// Internal
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/screens/moreScreen/widgets/settings/columnTile.dart';

// Packages
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:provider/provider.dart';
import 'package:circular_check_box/circular_check_box.dart';

// UI
import 'package:songtube/ui/dialogs/alertDialog.dart';

class DownloadSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    return SettingsColumnTile(
      title: "Downloads",
      icon: EvaIcons.downloadOutline,
      children: <Widget>[
        ListTile(
          title: Text(
            "Audio Folder",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text("Choose a Folder for Audio downloads",
            style: TextStyle(fontSize: 12)
          ),
          trailing: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).scaffoldBackgroundColor
            ),
            child: IconButton(
              icon: Icon(EvaIcons.folderOutline, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Permission.storage.request().then((status) {
                  if (status == PermissionStatus.granted) {
                    FilePicker.getDirectoryPath().then((path) {
                      if (path != null) {
                        appData.audioDownloadPath = path;
                      }
                    });
                  }
                });
              }
            )
          )
        ),
        ListTile(
          title: Text(
            "Video Folder",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text("Choose a Folder for Video downloads",
            style: TextStyle(fontSize: 12)
          ),
          trailing: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).scaffoldBackgroundColor
            ),
            child: IconButton(
              icon: Icon(EvaIcons.folderOutline, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Permission.storage.request().then((status) {
                  if (status == PermissionStatus.granted) {
                    FilePicker.getDirectoryPath().then((path) {
                      if (path != null) {
                        appData.videoDownloadPath = path;
                      }
                    });
                  }
                });
              }
            )
          )
        ),
        ListTile(
          title: Text(
            "Album Folder",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text("Create a Folder for each Song Album",
            style: TextStyle(fontSize: 12)
          ),
          trailing: CircularCheckBox(
            activeColor: Theme.of(context).accentColor,
            value: appData.enableAlbumFolder,
            onChanged: (bool newValue) async {
              appData.enableAlbumFolder = newValue;
            },
          ),
        ),
        ListTile(
          title: Text(
            "Delete Cache",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text("Clear SongTube Cache",
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
                String tmpPath = (await getTemporaryDirectory()).path;
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
                        title: "Cleaning",
                        content: "Temporal folder is empty!",
                        actions: <Widget>[
                          FlatButton(
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
                      title: "Cleaning",
                      content: "You're about to clear: " + totalSize.toStringAsFixed(2) + "MB",
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () async {
                            await Directory(tmpPath).delete(recursive: true);
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        )
                      ],
                    );
                  }
                );
              },
            ), 
          )
        ),
      ],
    );
  }
}