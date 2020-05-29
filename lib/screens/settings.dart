// Flutter
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/app_provider.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:songtube/ui/reusable/alertdialog.dart';
import 'package:songtube/ui/reusable/directory_picker.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 4
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          controller: ScrollController(
            initialScrollOffset: 20.0,
            keepScrollOffset: true
          ),
          children: <Widget>[
            // ---------------
            // Themes Settings
            // ---------------
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
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
                          color: Theme.of(context).textTheme.body1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Enable/Disable automatic theme", style: TextStyle(fontSize: 12),),
                      trailing: CircularCheckBox(
                        activeColor: Colors.redAccent,
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
                              color: Theme.of(context).textTheme.body1.color,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          subtitle: Text("Use dark theme by default", style: TextStyle(fontSize: 12),),
                          trailing: CircularCheckBox(
                            activeColor: Colors.redAccent,
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
                          color: Theme.of(context).textTheme.body1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Pure black theme", style: TextStyle(fontSize: 12),),
                      trailing: CircularCheckBox(
                        activeColor: Colors.redAccent,
                        value: appData.blackThemeEnabled,
                        onChanged: (bool newValue) {
                          appData.blackThemeEnabled = newValue;
                        },
                      ),
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
                        "Audio Download Path",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.body1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Select a folder to download all your Audio files",
                        style: TextStyle(fontSize: 12)
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.redAccent
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
                          color: Theme.of(context).textTheme.body1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Select a folder to download all your Video files",
                        style: TextStyle(fontSize: 12)
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.redAccent
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
                          color: Theme.of(context).textTheme.body1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Youtube Screen will be replaced with a \"youtube.com\" WebView",
                        style: TextStyle(fontSize: 12)
                      ),
                      trailing: CircularCheckBox(
                        activeColor: Colors.redAccent,
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
                          color: Theme.of(context).textTheme.body1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Enable/Disable audio conversion, default audio format is .ogg",
                        style: TextStyle(fontSize: 12)
                      ),
                      trailing: CircularCheckBox(
                        activeColor: Colors.redAccent,
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
                          color: Theme.of(context).textTheme.body1.color,
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
                                color: Theme.of(context).textTheme.body1.color,
                                fontWeight: FontWeight.w500
                              )),
                              value: 'AAC',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('OGG (.ogg)', style: TextStyle(
                                color: Theme.of(context).textTheme.body1.color,
                                fontWeight: FontWeight.w500
                              )),
                              value: 'OGG Vorbis',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('MP3 (.mp3)', style: TextStyle(
                                color: Theme.of(context).textTheme.body1.color,
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
                    /*ListTile(
                      title: Text(
                        "Convert Video",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.body1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Enable/Disable video convertion, default video format is .webm - Warning: VIDEO CONVERTION IS BROKEN",
                        style: TextStyle(fontSize: 12)
                      ),
                      trailing: CircularCheckBox(
                        activeColor: Colors.redAccent,
                        value: appData.enableVideoConvertion,
                        onChanged: (bool newValue) {
                          appData.enableVideoConvertion = newValue;
                        },
                      ),
                    ),
                    Divider(color: Colors.transparent),
                    */
                  ],
                ),
              ),
            ),
            Theme(
              data: ThemeData(
                textTheme: TextTheme(
                  body1: Theme.of(context).textTheme.body1,
                )
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text("SongTube: build 1.1.0+1"),
                    Text("By: Artx <artx4dev@gmail.com>")
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
