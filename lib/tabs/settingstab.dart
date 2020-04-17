import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import 'package:circular_check_box/circular_check_box.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 4
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView(
          children: <Widget>[
            // ---------------
            // Themes Settings
            // ---------------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Theme.of(context).cardColor,
                elevation: 3,
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
                    if (appData.systemThemeEnabled == false)
                    ListTile(
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
            // Converter Settings
            // ------------------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Theme.of(context).cardColor,
                elevation: 3,
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
                    ListTile(
                      title: Text(
                        "Format to Convert Audio",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.body1.color,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text("Select a format for audio download", style: TextStyle(fontSize: 12),),
                      trailing: CircularCheckBox(
                        activeColor: Colors.redAccent,
                        value: appData.systemThemeEnabled,
                        onChanged: (bool newValue) {
                          appData.systemThemeEnabled = newValue;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
