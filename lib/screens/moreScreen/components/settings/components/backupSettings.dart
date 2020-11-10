// Dart
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/downloadsProvider.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

// UI
import 'package:songtube/screens/moreScreen/components/settings/columnTile.dart';
import 'package:songtube/ui/internal/snackbar.dart';

class BackupSettings extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  BackupSettings({
    @required this.scaffoldKey
  });
  @override
  Widget build(BuildContext context) {
    AppSnack snackbar = new AppSnack(scaffoldKey: scaffoldKey, context: context, addPadding: false);
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context);
    return SettingsColumnTile(
      title: Languages.of(context).labelBackup,
      icon: EvaIcons.saveOutline,
      children: <Widget>[
        ListTile(
          title: Text(
            Languages.of(context).labelBackup,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(Languages.of(context).labelBackupJustification,
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
                  snackbar.showSnackBar(
                    icon: Icons.warning,
                    title: Languages.of(context).labelBackupLibraryEmpty,
                    duration: Duration(seconds: 2)
                  );
                  return;
                }
                await File(path).copy(backupPath + 'MediaItems.db');
                snackbar.showSnackBar(
                  icon: Icons.backup,
                  title: Languages.of(context).labelBackupCompleted,
                  duration: Duration(seconds: 2)
                );
              }
            )
          )
        ),
        ListTile(
          title: Text(
            Languages.of(context).labelRestore,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(Languages.of(context).labelRestoreJustification,
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
                String path = join(documentsDirectory.path, 'MediaItems.db');
                if (!await File(backupPath + 'MediaItems.db').exists()) {
                  snackbar.showSnackBar(
                    icon: Icons.warning,
                    title: Languages.of(context).labelRestoreNotFound,
                    duration: Duration(seconds: 2)
                  );
                  return;
                }
                await File(backupPath + 'MediaItems.db').copy(path);
                snackbar.showSnackBar(
                    icon: Icons.restore,
                    title: Languages.of(context).labelRestoreCompleted,
                    duration: Duration(seconds: 2)
                  );
                downloadsProvider.getDatabase();
              }
            )
          )
        ),
      ],
    );
  }
}