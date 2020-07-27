import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/settings/ui/columnTile.dart';

class BackupSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return SettingsColumnTile(
      title: "Backup",
      icon: EvaIcons.saveOutline,
      children: <Widget>[
        ListTile(
          title: Text(
            "Backup",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text("Backup your media library",
            style: TextStyle(fontSize: 12)
          ),
          trailing: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).accentColor
            ),
            child: IconButton(
              icon: Icon(EvaIcons.cloudDownloadOutline, color: Colors.white),
              onPressed: () async {
                Directory documentsDirectory = await getApplicationDocumentsDirectory();
                String backupPath = await ExtStorage.getExternalStorageDirectory() + "/SongTube/Backup/";
                if (!await Directory(backupPath).exists()) await Directory(backupPath).create();
                String path = join(documentsDirectory.path, 'MediaItems.db');
                if (!await File(path).exists()) {
                  manager.snackBar.showSnackBar(
                    icon: Icons.warning,
                    title: "Your Library is Empty",
                    duration: Duration(seconds: 2)
                  );
                  return;
                }
                await File(path).copy(backupPath + 'MediaItems.db');
                manager.snackBar.showSnackBar(
                  icon: Icons.backup,
                  title: "Backup Completed",
                  duration: Duration(seconds: 2)
                );
              }
            )
          )
        ),
        ListTile(
          title: Text(
            "Restore",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text("Restore your media library",
            style: TextStyle(fontSize: 12)
          ),
          trailing: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).accentColor
            ),
            child: IconButton(
              icon: Icon(EvaIcons.refreshOutline, color: Colors.white),
              onPressed: () async {
                Directory documentsDirectory = await getApplicationDocumentsDirectory();
                String backupPath = await ExtStorage.getExternalStorageDirectory() + "/SongTube/Backup/";
                String path = join(documentsDirectory.path, 'downloadDatabase.db');
                if (!await File(backupPath + 'downloadDatabase.db').exists()) {
                  manager.snackBar.showSnackBar(
                    icon: Icons.warning,
                    title: "You have no Backup",
                    duration: Duration(seconds: 2)
                  );
                  return;
                }
                await File(backupPath + 'downloadDatabase.db').copy(path);
                manager.snackBar.showSnackBar(
                    icon: Icons.restore,
                    title: "Restore Completed",
                    duration: Duration(seconds: 2)
                  );
                manager.getDatabase();
              }
            )
          )
        ),
      ],
    );
  }
}