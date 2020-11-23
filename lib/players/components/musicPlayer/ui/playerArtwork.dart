// Dart
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:transparent_image/transparent_image.dart';

class PlayerArtwork extends StatelessWidget {
  final File image;
  final double roundedCorners;
  PlayerArtwork({
    @required this.image,
    this.roundedCorners = 20
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: 320,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(roundedCorners),
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
        borderRadius: BorderRadius.circular(roundedCorners),
        child: ImageFade(
          image: FileImage(image),
          fadeDuration: Duration(milliseconds: 300),
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        )
      ),
    );
  }
}