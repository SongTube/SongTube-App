import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/media_playlist.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/playlist_provider.dart';
import 'package:songtube/screens/playlist.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/playlist_grid_tile.dart';
import 'package:songtube/ui/ui_utils.dart';

class PlaylistsPage extends StatefulWidget {
  const PlaylistsPage({ Key? key }) : super(key: key);

  @override
  State<PlaylistsPage> createState() => _PlaylistsPageState();
}

class _PlaylistsPageState extends State<PlaylistsPage> {
  @override
  Widget build(BuildContext context) {
    PlaylistProvider playlistProvider = Provider.of(context);
    final globalPlaylists = List<MediaPlaylist>.from(playlistProvider.globalPlaylists);
    // Inject liked songs as Playlist
    if (playlistProvider.favorites.songs.isNotEmpty) {
      globalPlaylists.insert(0, playlistProvider.favorites);
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: globalPlaylists.isNotEmpty ? GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 4, right: 4, top: 12, bottom: (kToolbarHeight*1.5)+16),
        itemCount: globalPlaylists.length,
        clipBehavior: Clip.none,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 2),
            child: PlaylistGridTile(
              playlist: globalPlaylists[index],
              onTap: () async {
                final mediaSet = globalPlaylists[index].toMediaSet();
                mediaSet.artwork ??= mediaSet.songs.first.artworkPath;
                await UiUtils.pushRouteAsync(context, PlaylistScreen(mediaSet: mediaSet));
              },
            ),
          );
        },
      ) : _emptyPage(context),
    );
  }

  Widget _emptyPage(context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Iconsax.music_playlist, size: 64),
        const SizedBox(height: 8),
        Text(Languages.of(context)!.labelNoPlaylistsYet, style: textStyle(context)),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Text(Languages.of(context)!.labelNoPlaylistsYetDescription, style: subtitleTextStyle(context, opacity: 0.6), textAlign: TextAlign.center,),
        ),
      ],
    ));
  }
}