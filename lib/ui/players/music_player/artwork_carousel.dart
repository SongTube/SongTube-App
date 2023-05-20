import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:provider/provider.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/internal/artwork_manager.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/media_utils.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/providers/media_provider.dart';
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

  // Image Getter
  Future<File> getAlbumImage() async {
    await ArtworkManager.writeArtwork(widget.song.id);
    return artworkFile(widget.song.id);
  }

  @override
  Widget build(BuildContext context) {
    AppSettings appSettings = Provider.of(context);
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
            borderRadius: BorderRadius.circular(Tween<double>(begin: 20, end: 25).animate(widget.animationController).value),
            child: child
          ),
        );
      },
      child: Transform.scale(
        scale: appSettings.musicPlayerArtworkZoom,
        child: FutureBuilder<File>(
          future: getAlbumImage(),
          builder: (context, snapshot) {
            return ImageFade(
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
}