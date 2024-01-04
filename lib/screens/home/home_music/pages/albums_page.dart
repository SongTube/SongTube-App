import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/media_item_models.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/screens/playlist.dart';
import 'package:songtube/ui/tiles/album_card_tile.dart';
import 'package:songtube/ui/ui_utils.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of(context);
    final albums = MediaItemAlbum.fetchAlbums(mediaProvider.songs);
    return GridView.builder(
      padding: const EdgeInsets.only(left: 4, right: 4, bottom: (kToolbarHeight*1.5)+16),
      itemCount: albums.length,
      clipBehavior: Clip.none,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: AlbumCardTile(
            album: albums[index],
            onTap: (album) {
              UiUtils.pushRouteAsync(context, PlaylistScreen(mediaSet: album.toMediaSet()));
            },
          ),
        );
      },
    );
  }
}