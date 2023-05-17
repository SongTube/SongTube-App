// Dart
import 'dart:io';
import 'dart:ui';

// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:image_fade/image_fade.dart';
import 'package:parallax_sensors_bg/parallax_sensors_bg.dart';
import 'package:provider/provider.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/internal/global.dart';
import 'package:transparent_image/transparent_image.dart';

class BackgroundCarousel extends StatefulWidget {
  final bool enabled;
  final File? backgroundImage;
  final bool enableBlur;
  final double blurIntensity;
  final Color backdropColor;
  final double backdropOpacity;
  final double transparency;
  const BackgroundCarousel({
    required this.enabled,
    required this.backgroundImage,
    this.enableBlur = true,
    this.blurIntensity = 22.0,
    this.backdropColor = Colors.black,
    this.transparency = 1,
    this.backdropOpacity = 0.4,
    Key? key
  }) : super(key: key);

  @override
  State<BackgroundCarousel> createState() => _BackgroundCarouselState();
}

class _BackgroundCarouselState extends State<BackgroundCarousel> with TickerProviderStateMixin {

  late AnimationController animationController = 
    AnimationController(vsync: this, duration: const Duration(milliseconds: 300), value: 1);

  @override
  void initState() {
    audioHandler.mediaItem.listen((event) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    // if (animationController.status == AnimationStatus.forward) {
    //   if (mediaProvider.showLyrics) {
    //     animationController.reverse();
    //   }
    // } else if (animationController.status == AnimationStatus.forward) {
    //   if (!mediaProvider.showLyrics) {
    //     animationController.forward();
    //   }
    // }
    AppSettings appSettings = Provider.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: widget.enabled ? Opacity(
        opacity: widget.transparency,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              AppSettings.enableMusicPlayerBackgroundParallax && widget.enableBlur
                ? Parallax(
                    sensor: ParallaxSensor.accelerometer,
                    layers: [
                      Layer(
                        sensitivity: 6,
                        child: Transform.scale(
                          scale: 1.5,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: widget.enableBlur ? ImageFade(
                              image: widget.backgroundImage != null
                                ? FileImage(widget.backgroundImage!)
                                : MemoryImage(kTransparentImage) as ImageProvider,
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ) : Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            )
                          ),
                        ),
                      ),
                    ],
                  )
                : Transform.scale(
                    scale: AppSettings.enableMusicPlayerBackgroundParallax ? 1.5 : appSettings.musicPlayerArtworkZoom,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: widget.enableBlur ? ImageFade(
                        image: widget.backgroundImage != null
                          ? FileImage(widget.backgroundImage!)
                          : MemoryImage(kTransparentImage) as ImageProvider,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ) : Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      )
                    ),
                  ),
              AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: widget.backdropColor.withOpacity(widget.backdropOpacity), //mediaProvider.showLyrics ? 0.8 : widget.backdropOpacity),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        tileMode: TileMode.mirror,
                        sigmaX: widget.blurIntensity * animationController.value,
                        sigmaY: widget.blurIntensity * animationController.value,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                      )
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ) : const SizedBox(),
    );
  }
}