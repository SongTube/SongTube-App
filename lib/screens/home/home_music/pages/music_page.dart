import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/ui/components/custom_scrollbar.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/song_tile.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({
    Key? key }) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {

  // ScrollController
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of(context);
    UiProvider uiProvider = Provider.of(context);
    return CustomScrollbar(
      scrollController: controller,
      labelTextBuilder: (double offset) {
        final index = (offset/72).round();
        final letter = mediaProvider.songs[index.clamp(0, mediaProvider.songs.length-1)].title.characters.first.toUpperCase();
        return Text(
          letter,
          style: textStyle(context, bold: true).copyWith(color: mediaProvider.currentColors.text),
        );
      },
      list: ListView.builder(
        key: const PageStorageKey('homeMusicPage'),
        itemExtent: 72,
        controller: controller,
        padding: const EdgeInsets.only(
          bottom: 16+(kToolbarHeight*1.5),
          top: 0
        ),
        itemCount: mediaProvider.songs.length,
        itemBuilder: (context, index) {
          final song = mediaProvider.songs[index];
          return SongTile(
            song: song,
            onPlay: () async {
              mediaProvider.currentPlaylistName = 'Music';
              final queue = List<MediaItem>.generate(mediaProvider.songs.length, (index) {
                return mediaProvider.songs[index].mediaItem;
              });
              uiProvider.currentPlayer = CurrentPlayer.music;
              mediaProvider.playSong(queue, index);
            }
          );
        },
      ),
    );
  }
}