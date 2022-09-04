// Dart
import 'dart:io';
import 'dart:ui';

// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:image_fade/image_fade.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:transparent_image/transparent_image.dart';

class PlayerBackground extends StatefulWidget {
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
  State<PlayerBackground> createState() => _PlayerBackgroundState();
}

class _PlayerBackgroundState extends State<PlayerBackground> with TickerProviderStateMixin {

  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this, duration: Duration(milliseconds: 400), value: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    if (animationController.status == AnimationStatus.forward) {
      if (mediaProvider.showLyrics) {
        animationController.reverse();
      }
    } else if (animationController.status == AnimationStatus.forward) {
      if (!mediaProvider.showLyrics) {
        animationController.forward();
      }
    }
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: widget.enableBlur ? ImageFade(
            image: widget.backgroundImage.path.isEmpty
              ? MemoryImage(kTransparentImage)
              : FileImage(widget.backgroundImage),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ) : Container(
            color: Theme.of(context).scaffoldBackgroundColor,
          )
        ),
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return AnimatedContainer(
              duration: Duration(seconds: 1),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: widget.backdropColor.withOpacity(mediaProvider.showLyrics ? 0.8 : widget.backdropOpacity),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  tileMode: TileMode.mirror,
                  sigmaX: widget.blurIntensity * animationController.value,
                  sigmaY: widget.blurIntensity * animationController.value,
                ),
                child: child
              ),
            );
          },
          child: Column(
            children: [
              Expanded(child: widget.child),
              Container(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        ),
      ],
    );
  }
}