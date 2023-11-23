import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:validators/validators.dart';

class PlaylistArtwork extends StatefulWidget {
  const PlaylistArtwork({
    required this.artwork,
    this.useThumbnail = false,
    this.enableHeroAnimation = true,
    this.fit = BoxFit.cover,
    this.opacity = 0,
    this.color = Colors.transparent,
    this.enableBlur = false,
    this.shadowIntensity = 1,
    this.shadowSpread = 12,
    Key? key}) : super(key: key);
  final dynamic artwork;
  final bool useThumbnail;
  final bool enableHeroAnimation;
  final BoxFit fit;
  final double opacity;
  final Color color;
  final bool enableBlur;
  final double shadowIntensity;
  final double shadowSpread;
  @override
  State<PlaylistArtwork> createState() => _PlaylistArtworkState();
}

class _PlaylistArtworkState extends State<PlaylistArtwork> {

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: widget.enableBlur ? 15 : 0, sigmaY: widget.enableBlur ? 15 : 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: widget.shadowSpread,
                offset: const Offset(0,0),
                color: Theme.of(context).shadowColor.withOpacity(0.1*widget.shadowIntensity)
              )
            ],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _image(),
                  Container(
                    color: widget.color.withOpacity(widget.opacity),
                  )
                ],
              ))),
        ),
      );
    }

    return body();
  }

  Widget _image() {
    const fit = BoxFit.cover;
    return ImageFade(
      fadeDuration: const Duration(milliseconds: 300),
      fadeCurve: Curves.ease,
      image: image(),
      fit: fit, width: double.infinity, height: double.infinity,
      errorBuilder:(context, error, stackTrace) {
        return Image.asset('assets/images/artworkPlaceholder_big.png', fit: BoxFit.cover);
      },
    );
  }

  ImageProvider image() {
    final artwork = widget.artwork;
    if (artwork is File) {
      return FileImage(artwork);
    } else if (artwork is Uint8List) {
      return MemoryImage(artwork);
    } else if (isURL(artwork)) {
      return NetworkImage(artwork);
    } else if (artwork is String) {
      return FileImage(File(artwork));
    } else {
      return const AssetImage('assets/images/artworkPlaceholder_big.png');
    }
  }

}