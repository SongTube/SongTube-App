import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/media_item_models.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/screens/playlist.dart';
import 'package:songtube/ui/animations/animated_text.dart';
import 'package:songtube/ui/components/custom_inkwell.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/album_card_tile.dart';
import 'package:songtube/ui/tiles/song_card_tile.dart';
import 'package:songtube/ui/tiles/song_tile.dart';
import 'package:songtube/ui/ui_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.onSwitchIndex,
    Key? key }) : super(key: key);
  final Function(int) onSwitchIndex;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    MediaProvider mediaProvider = Provider.of(context);
    UiProvider uiProvider = Provider.of(context);
    final mostPlayed = (List.from(mediaProvider.songs)..sort(((a, b) => b.playCount.compareTo(a.playCount)))).take(20).toList();
    final sortedSongs = List<SongItem>.from(mediaProvider.songs)
      ..sort((a, b) => b.lastModified.compareTo(a.lastModified));
    return Builder(
      builder: (context) {
        if (sortedSongs.isNotEmpty) {
          return CustomScrollView(
            slivers: [
              // Recent Songs Cards
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 180,
                  child: ListView.builder(
                    clipBehavior: Clip.none,
                    padding: const EdgeInsets.only(left: 4),
                    scrollDirection: Axis.horizontal,
                    itemCount: sortedSongs.length.clamp(0, 10),
                    itemBuilder: (context, index) {
                      final song = sortedSongs[index];
                      return SongCardTile(
                        song: song,
                        onPlay: () {
                          mediaProvider.currentPlaylistName = 'Recently Added';
                          final queue = List<MediaItem>.generate(sortedSongs.length, (index) {
                            return sortedSongs[index].mediaItem;
                          });
                          uiProvider.currentPlayer = CurrentPlayer.music;
                          mediaProvider.playSong(queue.take(10).toList(), index);
                        },
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Text(Languages.of(context)!.labelEditorAlbum, style: headerTextStyle(context).copyWith(letterSpacing: 0.2)),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CustomInkWell(
                            onTap: () {
                              // Switch to Albums tab
                              widget.onSwitchIndex(3);
                            },
                            child: AnimatedText('  •  ${Languages.of(context)!.labelSeeMore}', style: tinyTextStyle(context).copyWith(fontWeight: FontWeight.normal), auto: true)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 160,
                  child: Builder(
                    builder: (context) {
                      final albums = MediaItemAlbum.fetchAlbums(mediaProvider.songs);
                      return ListView.builder(
                        clipBehavior: Clip.none,
                        
                        padding: const EdgeInsets.only(left: 4),
                        scrollDirection: Axis.horizontal,
                        itemCount: albums.length.clamp(0, 10),
                        itemBuilder: (context, index) {
                          final album = albums[index];
                          return AlbumCardTile(
                            album: album,
                            onTap: (album) {
                              UiUtils.pushRouteAsync(context, PlaylistScreen(mediaSet: album.toMediaSet()));
                            },
                          );
                        },
                      );
                    }
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4, top: 2),
                    child: Row(
                      children: [
                        Text(Languages.of(context)!.labelMostPlayed, style: headerTextStyle(context).copyWith(letterSpacing: 0.2)),
                        AnimatedText('  •  ${Languages.of(context)!.labelSeeMore}', style: tinyTextStyle(context).copyWith(fontWeight: FontWeight.normal), auto: true)
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(((context, index) {
                  final song = mostPlayed[index];
                  return SongTile(
                    song: song,
                    onPlay: () async {
                      mediaProvider.currentPlaylistName = 'Most Played';
                      final queue = List<MediaItem>.generate(mostPlayed.length, (index) {
                        return mostPlayed[index].mediaItem;
                      });
                      uiProvider.currentPlayer = CurrentPlayer.music;
                      mediaProvider.playSong(queue, index);
                    }
                  );
                }), childCount: mostPlayed.length)
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16+(kToolbarHeight*1.5))),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}