// Dart
import 'dart:io';
import 'dart:ui';

// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:image_fade/image_fade.dart';

class PlayerBackground extends StatelessWidget {
  final File backgroundImage;
  final bool enableBlur;
  final double blurIntensity;
  final Widget child;
  final Color backdropColor;
  final double backdropOpacity;
  PlayerBackground({
    @required this.backgroundImage,
    this.enableBlur = true,
    this.blurIntensity = 22.0,
    @required this.child,
    this.backdropColor = Colors.black,
    this.backdropOpacity = 0.4
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      decoration: BoxDecoration(
        image: enableBlur ? DecorationImage(
          image: FileImage(backgroundImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            backdropColor.withOpacity(backdropOpacity),
            BlendMode.darken
          )
        ) : null,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurIntensity,
          sigmaY: blurIntensity
        ),
        child: child,
      ),
    );
  }
}