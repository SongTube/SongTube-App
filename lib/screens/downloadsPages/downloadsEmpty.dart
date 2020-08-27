// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class NoDownloads extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 240,
      width: MediaQuery.of(context).size.width*0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.08),
            offset: Offset(0,0),
            spreadRadius: 0.01,
            blurRadius: 20.0
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(EvaIcons.cloudDownloadOutline, size: 100, color: Theme.of(context).accentColor),
            SizedBox(height: 8),
            Text(
              "No downloads yet",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Varela'
              ),
            ),
            SizedBox(height: 4),
            Text("All your ongoing downloads will be shown here", textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}