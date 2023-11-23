import 'dart:io';

import 'package:provider/provider.dart';
import 'package:songtube/internal/artwork_manager.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/ui/animations/mini_music_visualizer.dart';
import 'package:songtube/ui/sheets/song_options.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:flutter/material.dart';
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
    return GestureDetector(
      onLongPress: () {
        if (!widget.song.isVideo) {
          showModalBottomSheet(
            context: internalNavigatorKey.currentContext!,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => SongOptionsSheet(song: widget.song, isDownload: false));
        }
      },
      onTap: widget.onPlay,
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
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FutureBuilder<File>(
                  future: getArtwork(),
                  builder: (context, snapshot) {
                    return ImageFade(
                      placeholder: Image.memory(kTransparentImage, fit: BoxFit.cover),
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
                  margin: const EdgeInsets.only(left: 12, bottom: 12, right: 12),
                  width: double.infinity,
                  height: kToolbarHeight,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.90),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
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
                                    fontWeight: FontWeight.bold)
                                ),
                                Text(
                                  widget.song.album ?? 'Unknown',
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: tinyTextStyle(context, opacity: 0.7),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            child: isPlaying 
                              ? Consumer<MediaProvider>(
                                  builder: (context, provider, _) {
                                    return SizedBox(
                                      height: 20, width: 20,
                                      child: MiniMusicVisualizer(color: provider.currentColors.vibrant, width: 2, height: 12));
                                  }
                              )
                              : const Icon(Ionicons.play, size: 16))
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
    );
  }
}