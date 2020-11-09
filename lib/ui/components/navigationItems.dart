// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomNavigationItems {
  static List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(EvaIcons.homeOutline),
      label: "Home"
    ),
    BottomNavigationBarItem(
      icon: Icon(EvaIcons.cloudDownloadOutline),
      label: "Downloads"
    ),
    BottomNavigationBarItem(
      icon: Icon(EvaIcons.musicOutline),
      label: "Media"
    ),
    BottomNavigationBarItem(
      icon: Icon(EvaIcons.videoOutline),
      label: "YouTube"
    ),
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.dotsHorizontal),
      label: "More"
    )
  ];
}