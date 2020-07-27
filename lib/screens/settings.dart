// Dart
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// Internal
import 'package:songtube/provider/app_provider.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:songtube/screens/settings/accentPicker.dart';

// UI
import 'package:songtube/ui/reusable/alertDialog.dart';
import 'package:songtube/ui/reusable/directoryPicker.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Settings",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 4
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          controller: ScrollController(
            initialScrollOffset: 20.0,
            keepScrollOffset: true
          ),
          children: <Widget>[
            // Padding
            SizedBox(height: 16),
            // ---------------
            // Themes Settings
            // ---------------
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      offset: Offset(0, 3), //(x,y)
                      blurRadius: 6.0,
                      spreadRadius: 0.01 
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 16,
                            bottom: 4
                          ),
                          child: Icon(Icons.color_lens, color: Theme.of(context).iconTheme.color),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 8,
                            bottom: 4
                          ),
                          child: Text(
                            "Theme",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(indent: 8, endIndent: 8),
                    ListTile(
                      onTap: () => appData.systemThemeEnabled = !appData.systemThemeEnabled,
                      title: Text(
                        "Use System Theme",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Enable/Disable automatic theme", style: TextStyle(fontSize: 12),),
                      trailing: Checkbox(
                        activeColor: Theme.of(context).accentColor,
                        value: appData.systemThemeEnabled,
                        onChanged: (bool newValue) {
                          appData.systemThemeEnabled = newValue;
                        },
                      ),
                    ),
                    AnimatedSize(
                      vsync: this,
                      curve: Curves.easeInOutBack,
                      duration: Duration(milliseconds: 500),
                      child: appData.systemThemeEnabled == false
                      ? ListTile(
                          onTap: () => appData.darkThemeEnabled = !appData.darkThemeEnabled,
                          title: Text(
                            "Enable Dark Theme",
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1.color,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          subtitle: Text("Use dark theme by default", style: TextStyle(fontSize: 12),),
                          trailing: Checkbox(
                            activeColor: Theme.of(context).accentColor,
                            value: appData.darkThemeEnabled,
                            onChanged: (bool newValue) {
                              appData.darkThemeEnabled = newValue;
                            },
                          ),
                        )
                      : Container()
                    ),
                    ListTile(
                      onTap: () => appData.blackThemeEnabled = !appData.blackThemeEnabled,
                      title: Text(
                        "Enable Black Theme",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Pure black theme", style: TextStyle(fontSize: 12),),
                      trailing: Checkbox(
                        activeColor: Theme.of(context).accentColor,
                        value: appData.blackThemeEnabled,
                        onChanged: (bool newValue) {
                          appData.blackThemeEnabled = newValue;
                        },
                      ),
                    ),
                    ListTile(
                      onTap: () => appData.systemThemeEnabled = !appData.systemThemeEnabled,
                      title: Text(
                        "Accent Color",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Customize accent color", style: TextStyle(fontSize: 12),),
                      trailing: IconButton(
                        icon: Icon(Icons.colorize),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AccentPicker(
                                onColorChanged: (Color color) {
                                  appData.accentColor = color;
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        },
                      )
                    ),
                  ],
                ),
              ),
            ),
            // ---------------
            // Themes Settings
            // ---------------

            // ------------------
            // App UI Settings
            // ------------------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      offset: Offset(0, 3), //(x,y)
                      blurRadius: 6.0,
                      spreadRadius: 0.01 
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 16,
                            bottom: 4
                          ),
                          child: Icon(Icons.file_download, color: Theme.of(context).iconTheme.color),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 8,
                            bottom: 4
                          ),
                          child: Text(
                            "Downloads",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(indent: 8, endIndent: 8),
                    ListTile(
                      title: Text(
                        "Audio Download Path",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Select a folder to download all your Audio files",
                        style: TextStyle(fontSize: 12)
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).accentColor
                        ),
                        child: IconButton(
                          icon: Icon(Icons.folder, color: Colors.white),
                          onPressed: () async {
                            String dir = await ExtStorage.getExternalStorageDirectory();
                            String path = await showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: DirectoryExplorer(
                                    backgroundColor: Theme.of(context).canvasColor,
                                    rootPath: dir,
                                    title: "Select a Folder",
                                    itemPrefix: Icon(Icons.folder),
                                  ),
                                );
                              }
                            );
                            appData.audioDownloadPath = path;
                          }
                        )
                      )
                    ),
                    Divider(color: Colors.transparent),
                    ListTile(
                      title: Text(
                        "Video Download Path",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Select a folder to download all your Video files",
                        style: TextStyle(fontSize: 12)
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).accentColor
                        ),
                        child: IconButton(
                          icon: Icon(Icons.folder, color: Colors.white),
                          onPressed: () async {
                            String dir = await ExtStorage.getExternalStorageDirectory();
                            String path = await showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: DirectoryExplorer(
                                    backgroundColor: Theme.of(context).canvasColor,
                                    rootPath: dir,
                                    title: "Select a Folder",
                                    itemPrefix: Icon(Icons.folder),
                                  ),
                                );
                              }
                            );
                            appData.videoDownloadPath = path;
                          }
                        )
                      )
                    ),
                    Divider(color: Colors.transparent),
                    ListTile(
                      title: Text(
                        "Clear Temporal Folder",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Clear SongTube temporal folder, recommended to do once in a while",
                        style: TextStyle(fontSize: 12)
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).accentColor
                        ),
                        child: IconButton(
                          icon: Icon(MdiIcons.trashCan, color: Colors.white),
                          onPressed: () async {
                            double totalSize = 0;
                            String tmpPath = await ExtStorage.getExternalStorageDirectory() + "/SongTube/tmp";
                            if (!await Directory(tmpPath).exists()) {
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
                            List<FileSystemEntity> listFiles = Directory(tmpPath).listSync();
                            listFiles.forEach((element) {
                              if (element is File) {
                                totalSize += element.statSync().size;
                              }
                            });
                            totalSize = totalSize * 0.000001;
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
                    Divider(color: Colors.transparent),
                  ],
                ),
              ),
            ),
            // ------------------
            // App UI Settings
            // ------------------

            // ------------------
            // Screens Settings
            // ------------------
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 16,
                            bottom: 4
                          ),
                          child: Icon(Icons.file_download, color: Theme.of(context).iconTheme.color),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 8,
                            bottom: 4
                          ),
                          child: Text(
                            "Downloads",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(indent: 8, endIndent: 8),
                    Divider(color: Colors.transparent),
                    ListTile(
                      title: Text(
                        "Use Webview for Youtube",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Youtube Screen will be replaced with a \"youtube.com\" WebView",
                        style: TextStyle(fontSize: 12)
                      ),
                      trailing: CircularCheckBox(
                        activeColor: Theme.of(context).accentColor,
                        value: appData.useYoutubeWebview,
                        onChanged: (bool newValue) {
                          appData.useYoutubeWebview = newValue;
                        },
                      ),
                    ),
                    Divider(color: Colors.transparent),
                  ],
                ),
              ),
            ),*/
            // ------------------
            // Screens Settings
            // ------------------

            // ------------------
            // Converter Settings
            // ------------------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      offset: Offset(0, 3), //(x,y)
                      blurRadius: 6.0,
                      spreadRadius: 0.01 
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 16,
                            bottom: 4
                          ),
                          child: Icon(Icons.gradient, color: Theme.of(context).iconTheme.color),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 8,
                            bottom: 4
                          ),
                          child: Text(
                            "Converter",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(indent: 8, endIndent: 8),
                    Divider(color: Colors.transparent),
                    ListTile(
                      title: Text(
                        "Convert Audio",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Enable/Disable audio conversion, default audio format is .ogg",
                        style: TextStyle(fontSize: 12)
                      ),
                      trailing: Checkbox(
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
                    Divider(color: Colors.transparent),
                    ListTile(
                      title: Text(
                        "Audio Conversion Format",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Audio will be converted to this selected format",
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
                    ),
                    Divider(color: Colors.transparent),
                  ],
                ),
              ),
            ),
            // ------------------
            // Converter Settings
            // ------------------

            // ------------------
            // Backup Options
            // ------------------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      offset: Offset(0, 3), //(x,y)
                      blurRadius: 6.0,
                      spreadRadius: 0.01 
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 16,
                            bottom: 4
                          ),
                          child: Icon(Icons.backup, color: Theme.of(context).iconTheme.color),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 8,
                            bottom: 4
                          ),
                          child: Text(
                            "Backup",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(indent: 8, endIndent: 8),
                    ListTile(
                      title: Text(
                        "Backup Library",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Do a Backup of all your downloaded media Library",
                        style: TextStyle(fontSize: 12)
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).accentColor
                        ),
                        child: IconButton(
                          icon: Icon(Icons.backup, color: Colors.white),
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
                    Divider(color: Colors.transparent),
                    ListTile(
                      title: Text(
                        "Restore Library",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Restore a Backup of all your downloaded media Library",
                        style: TextStyle(fontSize: 12)
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).accentColor
                        ),
                        child: IconButton(
                          icon: Icon(Icons.restore, color: Colors.white),
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
                    Divider(color: Colors.transparent),
                  ],
                ),
              ),
            ),
            // ------------------
            // Backup Options
            // ------------------
          ],
        ),
      ),
    );
  }
}
