import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/providers/playlist_provider.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/animations/animated_text.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/sheets/new_playlist.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/playlist_tile.dart';
import 'package:songtube/ui/tiles/song_tile.dart';
import 'package:songtube/ui/ui_utils.dart';
class AddToPlaylistSheet extends StatelessWidget {
  const AddToPlaylistSheet({
    required this.song,
    Key? key}) : super(key: key);
  final SongItem song;
  @override
  Widget build(BuildContext context) {
    PlaylistProvider playlistProvider = Provider.of(context);
    final playlists = playlistProvider.globalPlaylists;
    return CommonSheet(
      useCustomScroll: false,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(12).copyWith(top: 0),
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const AppAnimatedIcon(Iconsax.arrow_left, size: 22)
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(Languages.of(context)!.labelAddToPlaylist, style: textStyle(context, bold: false))),
                ],
              ),
              const SizedBox(height: 8),
              SongTile(song: song,
                padding: EdgeInsets.zero,
                disablePlayingBackground: true,
                disablePlayingVisualizer: true),
              const SizedBox(height: 8),
              Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 3,
                    child: Divider(endIndent: 12, color: Theme.of(context).dividerColor)),
                  Flexible(
                    flex: 2,
                    child: Text('PLAYLISTS', style: tinyTextStyle(context, opacity: 0.2).copyWith(letterSpacing: 1, fontWeight: FontWeight.bold, fontSize: 10))),
                  Flexible(
                    flex: 3,
                    child: Divider(indent: 12, color: Theme.of(context).dividerColor)),
                ],
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 8),
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: PlaylistTile(
                        disablePaddings: true,
                        playlist: playlist,
                        song: song,
                      ),
                    );
                  }
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  UiUtils.showModal(
                    context: internalNavigatorKey.currentContext!,
                    modal: NewPlaylistSheet(fallbackSong: song),
                  );
                },
                child: Consumer<MediaProvider>(
                  builder: (context, provider, child) {
                    return Container(
                      margin: const EdgeInsets.only(),
                      decoration: BoxDecoration(
                        color: provider.currentColors.vibrant?.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: kToolbarHeight,
                      child: child,
                    );
                  },
                  child: Center(child: AnimatedText(Languages.of(context)!.labelCreatePlaylist, style: subtitleTextStyle(context).copyWith(), auto: true)),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}