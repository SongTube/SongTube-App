import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/internal/artwork_manager.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:transparent_image/transparent_image.dart';

class ArtworkCarousel extends StatefulWidget {
  const ArtworkCarousel({
    required this.onSwitchSong,
    required this.animationController,
    required this.song,
    Key? key }) : super(key: key);
  final Function(int) onSwitchSong;
  final AnimationController animationController;
  final SongItem song;

  @override
  State<ArtworkCarousel> createState() => _ArtworkCarouselState();
}

class _ArtworkCarouselState extends State<ArtworkCarousel> {
  bool _isLeftDoubleTapped = false;
  bool _isRightDoubleTapped = false;

  // Image Getter
  Future<File> getAlbumImage() async {
    await ArtworkManager.writeArtwork(widget.song.id);
    return artworkFile(widget.song.id);
  }

  @override
  Widget build(BuildContext context) {
    AppSettings appSettings = Provider.of(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.all(Tween<double>(begin: 14, end: 32).animate(widget.animationController).value),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Tween<double>(begin: 20, end: 25).animate(widget.animationController).value),
              boxShadow: [
                BoxShadow(
                  blurRadius: AppSettings.musicPlayerArtworkShadowRadius.toDouble(),
                  offset: const Offset(0,0),
                  color: Theme.of(context).shadowColor.withOpacity(AppSettings.musicPlayerArtworkShadowLevel)
                )
              ],
            ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              Tween<double>(begin: 20, end: 25)
                  .animate(widget.animationController)
                  .value,
            ),
            child: GestureDetector(
              child: Stack(
                children: [
                  if (child != null) child,
                  if (_isRightDoubleTapped)
                    _animatedOpacity(_isRightDoubleTapped, true),
                  if (_isLeftDoubleTapped)
                    _animatedOpacity(_isLeftDoubleTapped, false),
                ],
              ),
              onDoubleTapDown: (details) {
                final tapPosition = details.globalPosition.dx;
                if (tapPosition < screenWidth / 2) {
                  _isLeftDoubleTapped = true;
                  audioHandler.rewind();
                } else {
                  _isRightDoubleTapped = true;
                  audioHandler.fastForward();
                }
                setState(() {});
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    _isLeftDoubleTapped = false;
                    _isRightDoubleTapped = false;
                  });
                });
              },
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity == null) return;

                if (details.primaryVelocity! > 0) {
                  audioHandler.skipToPrevious();
                } else if (details.primaryVelocity! < 0) {
                  audioHandler.skipToNext();
                }
              },
            ),
          ),
        );
      },
      child: Transform.scale(
        scale: appSettings.musicPlayerArtworkZoom,
        child: FutureBuilder<File>(
          future: getAlbumImage(),
          builder: (context, snapshot) {
            return ImageFade(
              fadeCurve: Curves.ease,
              placeholder: const SizedBox(),
              image: snapshot.hasData
                ? FileImage(snapshot.data!)
                : MemoryImage(kTransparentImage) as ImageProvider,
              fit: BoxFit.cover,
            );
          }
        ),
      ),
    );
  }

  AnimatedOpacity _animatedOpacity(bool isDoubleTapped, bool isForward) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
      opacity: isDoubleTapped ? 1 : 0,
      child: Container(
        color: Colors.grey.withOpacity(0.3),
        child: Center(
          child: Icon(
            isForward ? Icons.forward_10_rounded : Icons.replay_10_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}