// Dart
import 'dart:io';
import 'dart:ui';

// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:transparent_image/transparent_image.dart';
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
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          child: enableBlur ? ImageFade(
            image: FileImage(backgroundImage),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ) : Container()
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 600),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: backdropColor.withOpacity(backdropOpacity),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blurIntensity,
              sigmaY: blurIntensity
            ),
            child: child,
          ),
        )
      ],
    );
  }
}