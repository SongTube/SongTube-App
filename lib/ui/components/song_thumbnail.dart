import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:songtube/internal/artwork_manager.dart';
import 'package:transparent_image/transparent_image.dart';

class SongThumbnail extends StatefulWidget {
  const SongThumbnail({
    required this.uri,
    this.artwork,
    this.borderRadius,
    this.highRes = false,
    super.key});
  final String uri;
  final File? artwork;
  final BorderRadiusGeometry? borderRadius;
  final bool highRes;
  @override
  State<SongThumbnail> createState() => _SongThumbnailState();
}

class _SongThumbnailState extends State<SongThumbnail> {

  File? artwork;

  @override
  void initState() {
    getArtwork();
    super.initState();
  }

  void getArtwork() async {
    await Future.delayed(const Duration(milliseconds: 50));
    if (mounted) {
      artwork = widget.highRes
        ? await ArtworkManager.writeArtwork(widget.uri)
        : await ArtworkManager.writeThumbnail(widget.uri);
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(15),
        child: ImageFade(
          fadeDuration: const Duration(milliseconds: 300),
          image: widget.artwork != null ? Image.file(widget.artwork!).image
            : artwork != null ? Image.file(artwork!).image : Image.memory(kTransparentImage).image,
          placeholder: Image.memory(kTransparentImage),
          fit: BoxFit.cover,
          errorBuilder: (context, child, exception) {
            return Image.memory(kTransparentImage);
          },
        ),
      ),
    );
  }
}