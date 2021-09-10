// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:avatar_glow/avatar_glow.dart';
import 'package:songtube/internal/languages.dart';

class SongTubeBanner extends StatelessWidget {
  final String appName;
  final String appVersion;
  SongTubeBanner({
    @required this.appName,
    @required this.appVersion
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
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
              child: Image.asset(
                DateTime.now().month == 12
                  ? 'assets/images/logo_christmas.png'
                  : 'assets/images/logo.png'
              )
            ),
          ),
          // App Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: appName != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // App Name
                    Container(
                      child: Text(
                        appName,
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
                            Languages.of(context).labelVersion+": ",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "YTSans",
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).iconTheme.color
                            ),
                          ),
                          Text(
                            appVersion,
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
    );
  }
}