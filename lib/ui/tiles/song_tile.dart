import 'package:audio_service/audio_service.dart';
import 'package:iconsax/iconsax.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/media_playlist.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/playlist_provider.dart';
import 'package:songtube/ui/animations/mini_music_visualizer.dart';
import 'package:songtube/ui/playlist_artwork.dart';
import 'package:songtube/ui/sheets/song_options.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class SongTile extends StatefulWidget {
  const SongTile({
    required this.song,
    this.onPlay,
    this.disablePlayingBackground = false,
    this.disablePlayingVisualizer = false,
    this.isDownload = false,
    Key? key }) : super(key: key);
  final SongItem song;
  final Function()? onPlay;
  final bool disablePlayingBackground;
  final bool disablePlayingVisualizer;
  final bool isDownload;
  @override
  State<SongTile> createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {

  Color get dominantColor => widget.song.palette?.vibrant ?? widget.song.palette?.dominant ?? Theme.of(context).textTheme.bodyText1!.color!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: audioHandler.mediaItem,
      builder: (context, media) {
        bool isPlaying = media.data?.id == widget.song.id;
        return Padding(
          padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: widget.disablePlayingBackground ? Colors.transparent : isPlaying ? dominantColor.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(20)
            ),
            child: ListTile(
              onTap: widget.onPlay,
              onLongPress: () {
                if (widget.onPlay != null && !widget.song.isVideo) {
                  showModalBottomSheet(
                    context: internalNavigatorKey.currentContext!,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => SongOptionsSheet(song: widget.song, isDownload: widget.isDownload));
                }
              },
              leading: _leading(),
              title: Text(
                widget.song.title,
                style: smallTextStyle(context).copyWith(fontWeight: FontWeight.normal),
                maxLines: 1,
              ),
              subtitle: Text(
                widget.song.artist ?? 'Unknown',
                style: tinyTextStyle(context, opacity: 0.6).copyWith(fontWeight: FontWeight.w500),
                maxLines: 1,
              ),
              trailing: _trailing(media)
            ),
          ),
        );
      }
    );
  }

  Widget _leading() {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
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
              child: FadeInImage(
                fadeInDuration: const Duration(milliseconds: 200),
                image: widget.song.isVideo && widget.song.artworkUrl != null
                  ? NetworkImage(widget.song.artworkUrl.toString()) as ImageProvider
                  : FileImage(widget.song.thumbnailPath!),
                placeholder: MemoryImage(kTransparentImage),
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/artworkPlaceholder_big.png', fit: BoxFit.cover);
                },
              ),
            ),
          ),
          if (widget.song.isVideo)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context).cardColor.withOpacity(0.4)
            ),
            child: Icon(Iconsax.video, color: Theme.of(context).iconTheme.color, size: 20),
          )
        ],
      ),
    );
  }

  Widget _trailing(AsyncSnapshot<MediaItem?> media) {
    PlaylistProvider playlistProvider = Provider.of(context);
    bool isFavorite = playlistProvider.favorites.songs.any((element) => element.id == widget.song.id);
    bool isPlaying = media.data?.id == widget.song.id;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: !widget.song.isVideo
        ? isPlaying && !widget.disablePlayingVisualizer
          ? Container(
              margin: const EdgeInsets.only(left: 16, right: 8),
              height: 20, width: 20,
              child: StreamBuilder<PlaybackState>(
                stream: audioHandler.playbackState,
                builder: (context, state) {
                  bool isPaused = !(state.data?.playing ?? true);
                  return MiniMusicVisualizer(color: dominantColor, width: 2, height: 12, pause: isPaused);
                }
              ))
          : Bounce(
              duration: const Duration(milliseconds: 150),
              onPressed: () {
                playlistProvider.addToFavorites(widget.song);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0).copyWith(right: 8),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    isFavorite ? Ionicons.heart : Ionicons.heart_outline,
                    key: ValueKey(widget.song.id+isFavorite.toString()),
                    color: isFavorite ? Colors.red : Theme.of(context).iconTheme.color!.withOpacity(0.2), size: 18)),
              ),
            )
        : const SizedBox()
    );
  }
}