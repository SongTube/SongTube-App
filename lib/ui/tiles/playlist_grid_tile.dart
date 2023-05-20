import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:songtube/internal/models/media_playlist.dart';
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
              child: PlaylistArtwork(artwork: playlist.artworkPath)),
            // Album Details
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                  width: double.infinity,
                  height: kToolbarHeight,
                  decoration: BoxDecoration(
                    color: playlist.songs.first.palette?.dominant?.withOpacity(0.9) ?? Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
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
                                    fontWeight: FontWeight.bold,
                                    color: playlist.songs.first.palette?.text.withOpacity(0.9) ?? Colors.white)
                                ),
                                Text(
                                  playlist.songs.isEmpty ? 'Empty' : '${playlist.songs.length} songs',
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: tinyTextStyle(context).copyWith(color: (playlist.songs.first.palette?.text.withOpacity(0.8) ?? Colors.white))
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(Iconsax.music_playlist, color: playlist.songs.first.palette?.text.withOpacity(0.8) ?? Colors.white, size: 16)
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