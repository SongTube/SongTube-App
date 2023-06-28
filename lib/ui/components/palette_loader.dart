import 'package:flutter/material.dart';
import 'package:songtube/internal/media_utils.dart';
import 'package:songtube/internal/models/song_item.dart';

import '../../internal/models/colors_palette.dart';

class PaletteLoader extends StatefulWidget {
  const PaletteLoader({
    required this.builder,
    required this.song,
    super.key});
  final Widget Function(BuildContext context, ColorsPalette? palette) builder;
  final SongItem song;

  @override
  State<PaletteLoader> createState() => _PaletteLoaderState();
}

class _PaletteLoaderState extends State<PaletteLoader> {

  ColorsPalette? palette;

  // Load palette colors
  void loadPalette() async {
    final result = await MediaUtils.generateColorsPalette(widget.song);
    setState(() {
      palette = result;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPalette();
  }

  @override
  void didUpdateWidget(covariant PaletteLoader oldWidget) {
    if (widget.song.id != oldWidget.song.id) {
      loadPalette();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, palette);
}