import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:songtube/internal/models/media_playlist.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/components/palette_loader.dart';
import 'package:songtube/ui/playlist_artwork.dart';
import 'package:songtube/ui/text_styles.dart';

class PlaylistGridTile extends StatelessWidget {
  const PlaylistGridTile({
    required this.playlist,
    this.onTap,
    Key? key}) : super(key: key);
  final MediaPlaylist playlist;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Album Artwork
            Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
              child: PlaylistArtwork(artwork: playlist.artworkPath ?? playlist.songs.first.artworkPath)),
            // Album Details
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
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
                                  playlist.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: tinyTextStyle(context).copyWith(
                                    fontWeight: FontWeight.bold)
                                ),
                                Text(
                                  playlist.songs.isEmpty ? Languages.of(context)!.labelEmpty : '${playlist.songs.length} ${Languages.of(context)!.labelSongs}',
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: tinyTextStyle(context, opacity: 0.7),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(EvaIcons.listOutline, size: 18)
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