import 'dart:io';

import 'package:songtube/internal/artwork_manager.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/ui/animations/mini_music_visualizer.dart';
import 'package:songtube/ui/components/palette_loader.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:image_fade/image_fade.dart';
import 'package:ionicons/ionicons.dart';
import 'package:transparent_image/transparent_image.dart';

class SongCardTile extends StatefulWidget {
  const SongCardTile({
    required this.song,
    this.height = 100,
    this.width = 100,
    required this.onPlay,
    Key? key }) : super(key: key);
  final SongItem song;
  final double height;
  final double width;
  final Function() onPlay;

  @override
  State<SongCardTile> createState() => _SongCardTileState();
}

class _SongCardTileState extends State<SongCardTile> {

  // Image Getter
  Future<File> getArtwork() async {
    await ArtworkManager.writeArtwork(widget.song.id, forceRefresh: true);
    return artworkFile(widget.song.id);
  }

  @override
  Widget build(BuildContext context) {
    bool isPlaying = audioHandler.mediaItem.value?.id == widget.song.id;
    return PaletteLoader(
      song: widget.song,
      builder: (context, palette) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Bounce(
            duration: const Duration(milliseconds: 80),
            onPressed: widget.onPlay,
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Album Artwork
                  Container(
                    height: widget.height,
                    width: widget.width,
                    margin: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12,
                          offset: const Offset(0,0),
                          color: Theme.of(context).shadowColor.withOpacity(0.1)
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FutureBuilder<File>(
                        future: getArtwork(),
                        builder: (context, snapshot) {
                          return ImageFade(
                            placeholder: Image.asset('assets/images/artworkPlaceholder_big.png', fit: BoxFit.cover),
                            image: snapshot.hasData
                              ? FileImage(snapshot.data!)
                              : MemoryImage(kTransparentImage) as ImageProvider,
                            fit: BoxFit.cover,
                          );
                        }
                      ),
                    ),
                  ),
                  // Album Details
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedContainer(
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                        width: double.infinity,
                        height: kToolbarHeight,
                        decoration: BoxDecoration(
                          color: (palette?.dominant ?? Theme.of(context).cardColor).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Album Title
                                      Text(
                                        widget.song.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        style: tinyTextStyle(context).copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: palette?.text)
                                      ),
                                      Text(
                                        widget.song.album ?? 'Unknown',
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        style: tinyTextStyle(context).copyWith(color: (palette?.text)?.withOpacity(0.8))
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 400),
                                  child: isPlaying 
                                    ? SizedBox(
                                        height: 20, width: 20,
                                        child: MiniMusicVisualizer(color: palette?.text, width: 2, height: 12))
                                    : Icon(Ionicons.play, color: palette?.text, size: 16))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}