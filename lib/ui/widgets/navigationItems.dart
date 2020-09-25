// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomNavigationItems {
  static List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(EvaIcons.homeOutline),
      title: Text("Home", style: TextStyle(
        fontFamily: "Varela",
        fontWeight: FontWeight.w600
      )),
    ),
    BottomNavigationBarItem(
      icon: Icon(EvaIcons.cloudDownloadOutline),
      title: Text("Downloads", style: TextStyle(
        fontFamily: "Varela",
        fontWeight: FontWeight.w600
      )),
    ),
    BottomNavigationBarItem(
      icon: Icon(EvaIcons.musicOutline),
      title: Text("Media", style: TextStyle(
        fontFamily: "Varela",
        fontWeight: FontWeight.w600
      )),
    ),
    BottomNavigationBarItem(
      icon: Icon(EvaIcons.browserOutline),
      title: Text("YouTube", style: TextStyle(
        fontFamily: "Varela",
        fontWeight: FontWeight.w600
      )),
    ),
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.dotsHorizontal),
      title: Text("More", style: TextStyle(
        fontFamily: "Varela",
        fontWeight: FontWeight.w600
      )),
    )
  ];
}