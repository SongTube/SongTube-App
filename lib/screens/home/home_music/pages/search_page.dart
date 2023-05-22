import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/media_item_models.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/screens/playlist.dart';
import 'package:songtube/ui/components/custom_inkwell.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/album_card_tile.dart';
import 'package:songtube/ui/tiles/artist_card_tile.dart';
import 'package:songtube/ui/tiles/song_tile.dart';
import 'package:songtube/ui/ui_utils.dart';

class MusicSearchPage extends StatelessWidget {
  const MusicSearchPage({
    required this.searchController,
    super.key});
  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of(context);
    UiProvider uiProvider = Provider.of(context);
    // Songs
    final List<SongItem> songs = mediaProvider.songs.where((element) => element.title.trim().toLowerCase().contains(searchController.text.trim().toLowerCase())).toList();
    // Albums
    final List<MediaItemAlbum> albums = MediaItemAlbum.fetchAlbums(songs).where((element) => element.albumTitle.trim().toLowerCase().contains(searchController.text.trim().toLowerCase())).toList();
    // Artists
    final List<MediaItemArtist> artists = MediaItemArtist.fetchArtists(songs).where((element) => element.artistName.trim().toLowerCase().contains(searchController.text.trim().toLowerCase())).toList();
    return Container(
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: songs.isEmpty && albums.isEmpty && artists.isEmpty ? _searchEmpty(context) : AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 12),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Artists
              if (artists.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12, top: 4),
                  child: Row(
                    children: [
                      Text(Languages.of(context)!.labelArtistResults, style: smallTextStyle(context).copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.4)),
                    ],
                  ),
                ),
              ),
              if (artists.isNotEmpty)
              SizedBox(
                height: 160,
                child: Builder(
                  builder: (context) {
                    return ListView.builder(
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: artists.length.clamp(0, 10),
                      itemBuilder: (context, index) {
                        final artist = artists[index];
                        return Padding(
                          padding: EdgeInsets.only(left: index == 0 ? 0 : 8),
                          child: ArtistCardTile(
                            artist: artist,
                            onTap: (artist) {
                              UiUtils.pushRouteAsync(context, PlaylistScreen(mediaSet: artist.toMediaSet()));
                            },
                          ),
                        );
                      },
                    );
                  }
                ),
              ),
              // Albums
              if (albums.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12, top: 4),
                  child: Row(
                    children: [
                      Text(Languages.of(context)!.labelAlbumResults, style: smallTextStyle(context).copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.4)),
                    ],
                  ),
                ),
              ),
              if (albums.isNotEmpty)
              SizedBox(
                height: 160,
                child: Builder(
                  builder: (context) {
                    return ListView.builder(
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: albums.length.clamp(0, 10),
                      itemBuilder: (context, index) {
                        final album = albums[index];
                        return Padding(
                          padding: EdgeInsets.only(left: index == 0 ? 0 : 8),
                          child: AlbumCardTile(
                            album: album,
                            onTap: (album) {
                              UiUtils.pushRouteAsync(context, PlaylistScreen(mediaSet: album.toMediaSet()));
                            },
                          ),
                        );
                      },
                    );
                  }
                ),
              ),
              if (songs.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4, top: 4),
                  child: Row(
                    children: [
                      Text(Languages.of(context)!.labelSongResults, style: smallTextStyle(context).copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.4)),
                    ],
                  ),
                ),
              ),
              // Songs
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = songs[index];
                  return SongTile(
                    song: song,
                    onPlay: () async {
                      mediaProvider.currentPlaylistName = 'Music';
                      final queue = List<MediaItem>.generate(songs.length, (index) {
                        return songs[index].mediaItem;
                      });
                      uiProvider.currentPlayer = CurrentPlayer.music;
                      mediaProvider.playSong(queue, index);
                    }
                  );
                },
              ),
              const SizedBox(height: 16+(kToolbarHeight*1.5)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchEmpty(context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Iconsax.music_square_search, size: 64),
        const SizedBox(height: 8),
        Text(Languages.of(context)!.labelNoSearchResults, style: textStyle(context)),
      ],
    ));
  }

}