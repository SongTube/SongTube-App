import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:songtube/internal/artwork_manager.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/media_utils.dart';
import 'package:songtube/internal/models/media_playlist.dart';
import 'package:songtube/internal/models/media_set.dart';
import 'package:songtube/internal/music_brainz.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:validators/validators.dart';

class PlaylistArtwork extends StatefulWidget {
  const PlaylistArtwork({
    required this.mediaSet,
    this.useThumbnail = false,
    this.enableHeroAnimation = true,
    this.fit = BoxFit.cover,
    this.opacity = 0,
    this.color = Colors.transparent,
    this.enableBlur = false,
    this.shadowIntensity = 1,
    this.shadowSpread = 12,
    Key? key}) : super(key: key);
  final MediaSet mediaSet;
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

  // Extract Artwork can only run once
  bool extractArtworkProcess = true;

  void extractArtwork() async {
    extractArtworkProcess = false;
    await ArtworkManager.writeArtwork(widget.mediaSet.songs.first.id);
    imageCache.clear();
    imageCache.clearLiveImages();
    setState(() {});
  }

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
              borderRadius: BorderRadius.circular(20),
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

    if (widget.enableHeroAnimation) {
      return Hero(
        tag: widget.mediaSet.id ?? UniqueKey(),
        child: body()
      );
    } else {
      return body();
    }
  }

  Widget _image() {
    final artwork = widget.mediaSet.artwork ?? artworkFile(widget.mediaSet.songs.first.id);
    const fit = BoxFit.cover;
    if (widget.mediaSet.isArtist) {
      return FutureBuilder<String?>(
        future: MusicBrainzAPI.getArtistImage(widget.mediaSet.name.trim()),
        builder: (context, snapshot) {
          return ImageFade(
            placeholder: Image.asset('assets/images/artworkPlaceholder_big.png', fit: fit, width: double.infinity, height: double.infinity),
            image: snapshot.hasData && snapshot.data != null
              ? NetworkImage(snapshot.data!)
              : MemoryImage(kTransparentImage) as ImageProvider,
            fit: BoxFit.cover,
            errorBuilder: (context, child, exception) {
              return Image.asset('assets/images/artworkPlaceholder_big.png', fit: fit, width: double.infinity, height: double.infinity);
            },
          );
        }
      );
    }
    if (artwork is File) {
      return Image.file(
        artwork, fit: fit, width: double.infinity, height: double.infinity,
        errorBuilder:(context, error, stackTrace) {
          return Image.asset('assets/images/artworkPlaceholder_big.png', fit: BoxFit.cover);
        },
      );
    } else if (artwork is Uint8List) {
      return Image.memory(artwork, fit: fit, width: double.infinity, height: double.infinity);
    } else if (isURL(artwork)) {
      return Image.network(artwork, fit: fit, width: double.infinity, height: double.infinity);
    } else if (artwork is String) {
      return Image.file(File(artwork), fit: fit, width: double.infinity, height: double.infinity);
    } else {
      if (extractArtworkProcess) {
        extractArtwork();
      }
      return Image.asset('assets/images/artworkPlaceholder_big.png', key: ValueKey('${widget.mediaSet.name}asset'), fit: fit, width: double.infinity, height: double.infinity);
    }
  }

}