import 'package:audio_service/audio_service.dart';
import 'package:iconsax/iconsax.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/providers/playlist_provider.dart';
import 'package:songtube/ui/animations/mini_music_visualizer.dart';
import 'package:songtube/ui/components/song_thumbnail.dart';
import 'package:songtube/ui/sheets/song_options.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:songtube/ui/ui_utils.dart';

class SongTile extends StatefulWidget {
  const SongTile({
    required this.song,
    this.onPlay,
    this.disablePlayingBackground = false,
    this.disablePlayingVisualizer = false,
    this.isDownload = false,
    this.disableLongPress = false,
    this.padding,
    Key? key }) : super(key: key);
  final SongItem song;
  final Function()? onPlay;
  final bool disablePlayingBackground;
  final bool disablePlayingVisualizer;
  final bool isDownload;
  final bool disableLongPress;
  final EdgeInsetsGeometry? padding;
  @override
  State<SongTile> createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {

  // Provider
  MediaProvider get mediaProvider => Provider.of<MediaProvider>(context, listen: false);

  Color get dominantColor => mediaProvider.currentColors.vibrant ?? mediaProvider.currentColors.dominant ?? Theme.of(context).textTheme.bodyText1!.color!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: audioHandler.mediaItem,
      builder: (context, media) {
        bool isPlaying = media.data?.id == widget.song.id;
        return GestureDetector(
          onTap: widget.onPlay,
          onLongPress: () {
            if (widget.onPlay != null && !widget.song.isVideo) {
              UiUtils.showModal(
                context: internalNavigatorKey.currentContext!,
                modal: SongOptionsSheet(song: widget.song, isDownload: widget.isDownload)
              );
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: widget.disablePlayingBackground ? Colors.transparent : isPlaying ? dominantColor.withOpacity(0.05) : Colors.transparent,
            ),
            padding: const EdgeInsets.all(16).copyWith(top: 8, bottom: 8),
            height: 72,
            child: Row(
              children: [
                _leading(),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.song.title,
                        style: smallTextStyle(context),
                        maxLines: 1,
                      ),
                      Text(
                        widget.song.artist ?? 'Unknown',
                        style: tinyTextStyle(context, opacity: 0.6),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                _trailing(media)
              ],
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
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          SongThumbnail(uri: widget.song.id),
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
          : Semantics(
            label: 'Like song',
            child: Bounce(
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
              ),
          )
        : const SizedBox()
    );
  }
}