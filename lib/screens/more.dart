import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/screens/settings.dart';
import 'package:songtube/ui/more_screen/quickaccess_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // App Logo
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.15),
                        offset: Offset(2.0, 2.0), //(x,y)
                        blurRadius: 20.0,
                        spreadRadius: 4.0
                      ),
                    ],
                  ),
                  child: Image.asset('assets/images/ic_launcher.png', width: 150, height: 150)
                ),
                // App Info
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: appData.appName != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // App Name
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).cardColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.05),
                                  offset: Offset(3, 3), //(x,y)
                                  blurRadius: 6.0,
                                  spreadRadius: 1 
                                )
                              ]
                            ),
                            child: Text(
                              appData.appName,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Varela",
                                fontWeight: FontWeight.w700,
                                color: Colors.redAccent
                              ),
                            )
                          ),
                          SizedBox(height: 8),
                          // App Version
                          Container(
                            padding: EdgeInsets.all(10),
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
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Version: ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Varela",
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).iconTheme.color
                                  ),
                                ),
                                Text(
                                  appData.appVersion,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Varela",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.redAccent
                                  ),
                                ),
                              ],
                            )
                          )
                        ],
                      )
                    : Container(),
                  ),
                )
              ],
            ),
          ),
          // Settings
          QuickAccessTile(
            tileIcon: Icon(EvaIcons.settingsOutline, color: Colors.redAccent),
            title: "Settings",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsTab()));
            }
          ),
          // Telegram Channel
          QuickAccessTile(
            tileIcon: Icon(MdiIcons.telegram, color: Colors.blue),
            title: "Telegram",
            onTap: () {
              launch("https://t.me/songtubechannel");
            },
          ),
          // Github
          QuickAccessTile(
            tileIcon: Icon(EvaIcons.githubOutline, color: Colors.blueGrey),
            title: "GitHub",
            onTap: () {
              launch("https://github.com/SongTube");
            },
          ),
          // Licenses
          QuickAccessTile(
            tileIcon: Icon(EvaIcons.heartOutline, color: Colors.redAccent),
            title: "Donate",
            onTap: () {
              launch("https://paypal.me/artixo");
            },
          ),
          // Licenses
          QuickAccessTile(
            tileIcon: Icon(MdiIcons.license, color: Colors.green),
            title: "Licenses",
            onTap: () {
              showLicensePage(
                applicationName: appData.appName,
                applicationIcon: Image.asset('assets/images/ic_launcher.png', height: 50, width: 50),
                applicationVersion: appData.appVersion,
                context: context
              );
            },
          )
        ],
      ),
    );
  }
}