import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/download_provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/screens/id3_editor.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/sheets/add_to_playlist.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/song_tile.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:songtube/ui/ui_utils.dart';

class SongOptionsSheet extends StatelessWidget {
  const SongOptionsSheet({
    required this.song,
    this.isDownload = false,
    Key? key}) : super(key: key);
  final SongItem song;
  final bool isDownload;
  @override
  Widget build(BuildContext context) {
    ContentProvider contentProvider = Provider.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: BottomSheetPhill()),
          SongTile(song: song,
            disablePlayingBackground: true,
            disablePlayingVisualizer: true),
          Divider(indent: 12, endIndent: 12, color: Theme.of(context).dividerColor),
          _optionTile(context,
            title: Languages.of(context)!.labelAddToPlaylist,
            subtitle: Languages.of(context)!.labelAddToPlaylistDescription,
            icon: LineIcons.list,
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(context: internalNavigatorKey.currentContext!, backgroundColor: Colors.transparent, isScrollControlled: true, builder: (context) {
                return AddToPlaylistSheet(song: song);
              });
            }
          ),
          _optionTile(context,
            title: Languages.of(context)!.labelShareSong,
            subtitle: Languages.of(context)!.labelShareSongDescription,
            icon: LineIcons.share,
            onTap: () {
              FlutterShare.shareFile(
                title: song.title,
                text: '${song.title} - ${song.artist}\n\n'
                      'Shared from SongTube\nsongtube.github.io',
                fileType: 'audio/*',
                filePath: song.id
              );
            }
          ),
          _optionTile(context,
            title: Languages.of(context)!.labelEditTags,
            subtitle: Languages.of(context)!.labelEditTagsDescription,
            icon: LineIcons.tags,
            onTap: () {
              Navigator.pop(context);
              // Open ID3 Tags Editor
              UiUtils.pushRouteAsync(internalNavigatorKey.currentContext!, ID3Editor(song: song.mediaItem)).then((value) {
                // Refresh the song
                if (isDownload) {
                  Provider.of<DownloadProvider>(internalNavigatorKey.currentContext!, listen: false).refreshSong(song.id);
                } else {
                  Provider.of<MediaProvider>(internalNavigatorKey.currentContext!, listen: false).refreshSong(song.id);
                }
              });
            }
          ),
          if (song.videoId != null)
          _optionTile(context,
            title: 'Open Video Player',
            subtitle: 'Opens the Youtube video player from where this song was downloaded',
            icon: LineIcons.youtube,
            onTap: () {
              Navigator.pop(context);
              contentProvider.loadVideoPlayer(song.videoId);
            }
          ),
        ],
      ),
    );
  }

  Widget _optionTile(BuildContext context, {required String title, required String subtitle, required IconData icon, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 6),
        height: kToolbarHeight,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Icon(icon, color: icon == LineIcons.trash ? Colors.red : Theme.of(context).primaryColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: smallTextStyle(context).copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: tinyTextStyle(context, opacity: 0.6))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}