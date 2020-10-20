// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/screens/moreScreen/settings.dart';
import 'package:songtube/screens/moreScreen/components/quickAcessTile.dart';

// Packages
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:songtube/screens/moreScreen/components/songtubeBanner.dart';
import 'package:songtube/ui/animations/showUp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [
            ShowUpTransition(
              forward: true,
              duration: Duration(milliseconds: 400),
              slideSide: SlideFromSlide.TOP,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8, left: 16),
                    child: Icon(
                      EvaIcons.gridOutline,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Text(
                    "More",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "YTSans",
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            ShowUpTransition(
              forward: true,
              duration: Duration(milliseconds: 600),
              delay: Duration(milliseconds: 400),
              slideSide: SlideFromSlide.TOP,
              child: GestureDetector(
                onTap: () => launch("https://paypal.me/artixo"),
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.black12.withOpacity(0.04)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(EvaIcons.heartOutline, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        "Donate",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ))
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Icon(EvaIcons.settingsOutline,
                  color: Theme.of(context).iconTheme.color),
                onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SettingsTab())),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: <Widget>[
                // SongTube Banner
                SongTubeBanner(
                  appName: appData.appName,
                  appVersion: appData.appVersion,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                SizedBox(height: 60)
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  launch('https://github.com/Hexer10/youtube_explode_dart');
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Icon(
                          MdiIcons.youtube,
                          size: 40,
                          color: Colors.red
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'YTSans',
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).textTheme.bodyText1.color
                          ),
                          children: [
                            TextSpan(
                              text: "Powered by\n"
                            ),
                            TextSpan(
                              text: "YouTubeExplode",
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600
                              )
                            )
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              ShowUpTransition(
                forward: true,
                duration: Duration(milliseconds: 600),
                delay: Duration(milliseconds: 200),
                slideSide: SlideFromSlide.BOTTOM,
                child: IconButton(
                  icon: Icon(MdiIcons.instagram),
                  onPressed: () {
                    launch("https://www.instagram.com/songtubeapp/");
                  }
                ),
              ),
              ShowUpTransition(
                forward: true,
                duration: Duration(milliseconds: 600),
                delay: Duration(milliseconds: 400),
                slideSide: SlideFromSlide.BOTTOM,
                child: IconButton(
                  icon: Icon(MdiIcons.twitter),
                  onPressed: () {
                    launch("https://twitter.com/artxdev");
                  }
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}