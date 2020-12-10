// Dart
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/preferencesProvider.dart';

class PlayerArtwork extends StatelessWidget {
  final File image;
  PlayerArtwork({
    @required this.image,
  });
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return Container(
      height: 320,
      width: 320,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(
          prefs.musicPlayerArtworkRoundCorners),
        boxShadow: [
          BoxShadow(
            color: Colors.black87.withOpacity(0.2),
            offset: Offset(0,0), //(x,y)
            blurRadius: 14.0,
            spreadRadius: 2.0 
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          prefs.musicPlayerArtworkRoundCorners),
        child: ImageFade(
          image: FileImage(image),
          fadeDuration: Duration(milliseconds: 150),
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        )
      ),
    );
  }
}