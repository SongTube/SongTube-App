import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/media_item_models.dart';
import 'package:songtube/internal/music_brainz.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/screens/playlist.dart';
import 'package:songtube/ui/tiles/artist_card_tile.dart';
import 'package:songtube/ui/ui_utils.dart';

class ArtistsPage extends StatelessWidget {
  const ArtistsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of(context);
    final artists = MediaItemArtist.fetchArtists(mediaProvider.songs);
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 4, right: 4, top: 12, bottom: kToolbarHeight+16),
      itemCount: artists.length,
      clipBehavior: Clip.none,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: ArtistCardTile(
            artist: artists[index],
            onTap: (artist) {
              UiUtils.pushRouteAsync(context, PlaylistScreen(mediaSet: artist.toMediaSet(isArtist: true)));
            },
          ),
        );
      },
    );
  }
}