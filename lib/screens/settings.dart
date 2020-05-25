// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/app_provider.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:circular_check_box/circular_check_box.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
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
                    if (appData.systemThemeEnabled == false)
                    ListTile(
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
                          child: Icon(Icons.transform, color: Theme.of(context).iconTheme.color),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 8,
                            bottom: 4
                          ),
                          child: Text(
                            "App Design",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(indent: 8, endIndent: 8),
                  ],
                ),
              ),
            ),*/
            // ------------------
            // App UI Settings
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
                      subtitle: Text("Enable/Disable audio convertion, default audio format is .opus",
                        style: TextStyle(fontSize: 12)
                      ),
                      trailing: CircularCheckBox(
                        activeColor: Colors.redAccent,
                        value: appData.enableAudioConvertion,
                        onChanged: (bool newValue) {
                          appData.enableAudioConvertion = newValue;
                        },
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
                    Text("SongTube: build 1.0.3+4"),
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
