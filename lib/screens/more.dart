import 'package:avatar_glow/avatar_glow.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/screens/settings.dart';
import 'package:songtube/screens/moreScreen/quickAcessTile.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // App Logo
                AvatarGlow(
                  repeat: true,
                  endRadius: 80,
                  showTwoGlows: false,
                  glowColor: Theme.of(context).accentColor,
                  repeatPauseDuration: Duration(milliseconds: 50),
                  child: Container(
                    width: 120,
                    height: 120,
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
                    child: Image.asset('assets/images/logo.png')
                  ),
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
                            child: Text(
                              appData.appName,
                              style: TextStyle(
                                fontSize: 26,
                                fontFamily: "YTSans",
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).accentColor
                              ),
                            )
                          ),
                          SizedBox(height: 8),
                          // App Version
                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Version: ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "YTSans",
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
                                    color: Theme.of(context).accentColor
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