import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/playlist_provider.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/sheets/new_playlist.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/playlist_tile.dart';
import 'package:songtube/ui/tiles/song_tile.dart';
class AddToPlaylistSheet extends StatelessWidget {
  const AddToPlaylistSheet({
    required this.song,
    Key? key}) : super(key: key);
  final SongItem song;
  @override
  Widget build(BuildContext context) {
    PlaylistProvider playlistProvider = Provider.of(context);
    final playlists = playlistProvider.globalPlaylists;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16).copyWith(left: 8, right: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: BottomSheetPhill()),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text('Add to Playlist', style: textStyle(context)),
          ),
          const SizedBox(height: 8),
          SongTile(song: song),
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
          ListView.builder(
            shrinkWrap: true,
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              return PlaylistTile(
                playlist: playlist,
                song: song,
              );
            }
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(context: internalNavigatorKey.currentContext!, backgroundColor: Colors.transparent, isScrollControlled: true, builder: (context) {
                return NewPlaylistSheet(fallbackSong: song);
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.07),
                borderRadius: BorderRadius.circular(20),
              ),
              height: kToolbarHeight,
              child: Center(child: Text('Create Playlist', style: subtitleTextStyle(context).copyWith(color: Theme.of(context).primaryColor))),
            ),
          )
        ],
      ),
    );
  }
}