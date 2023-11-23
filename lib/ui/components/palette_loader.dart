import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:songtube/internal/media_utils.dart';
import 'package:songtube/internal/models/colors_palette.dart';
import 'package:songtube/internal/models/song_item.dart';

class PaletteLoader extends StatefulWidget {
  const PaletteLoader({
    required this.builder,
    required this.song,
    required this.video,
    this.controller,
    Key? key}) : super(key: key);
  final Widget Function(BuildContext context, ColorsPalette palette) builder;
  final SongItem? song;
  final YoutubeVideo? video;
  final PaletteLoaderController? controller;
  @override
  State<PaletteLoader> createState() => PaletteLoaderState();
}

class PaletteLoaderState extends State<PaletteLoader> {

  ColorsPalette palette = ColorsPalette(dominant: Colors.black, vibrant: Colors.white);

  // Load palette colors from Songs
  void loadSongPalette() async {
    if (widget.song != null) {
      final result = await MediaUtils.generateColorsPalette(widget.song!);
      setState(() {
        palette = result
          ?? ColorsPalette(dominant: Colors.black, vibrant: Colors.white);
      });
    }
  }

  // Load palette colors from Video
  void loadVideoPalette() async {
    if (widget.video != null) {
      final result = await MediaUtils.generateVideoColorsPalette(widget.video!);
      setState(() {
        palette = result
          ?? ColorsPalette(dominant: Colors.black, vibrant: Colors.white);
      });
    }
  }

  void loadDefault() async {
    setState(() {
      palette = ColorsPalette(dominant: Theme.of(context).primaryColor, vibrant: Theme.of(context).primaryColor);
    });
  }

  @override
  void initState() {
    super.initState();
    loadSongPalette();
  }

  @override
  void didUpdateWidget(covariant PaletteLoader oldWidget) {
    if ((widget.song?.id != oldWidget.song?.id)) {
      loadSongPalette();
    }
    if (widget.video?.videoInfo.id != oldWidget.video?.videoInfo.id) {
      loadVideoPalette();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    widget.controller?._addState(this);
    return widget.builder(context, palette);
  }
}

class PaletteLoaderController {

  PaletteLoaderState? loaderState;

  void _addState(PaletteLoaderState state){
    loaderState = state;
  }

  // Switch to Song Colors
  void switchToSongColors() {
    loaderState?.loadSongPalette();
  }

  // Switch to Video Colors
  void switchToVideoColors() {
    loaderState?.loadVideoPalette();
  }

  // Switch to Default Colors
  void switchToDefaultColors() {
    loaderState?.loadDefault();
  }

}