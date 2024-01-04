import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/download_provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/screens/id3_editor.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/components/common_sheet_widget.dart';
import 'package:songtube/ui/sheets/add_to_playlist.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
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
    DownloadProvider downloadProvider = Provider.of(context);
    MediaProvider mediaProvider = Provider.of(context);
    return CommonSheet(
      useCustomScroll: false,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(12).copyWith(top: 0, bottom: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SongTile(song: song,
                padding: EdgeInsets.zero,
                disablePlayingBackground: true,
                disablePlayingVisualizer: true),
              const SizedBox(height: 6),
              Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 3,
                    child: Divider(endIndent: 12, color: Theme.of(context).dividerColor)),
                  Flexible(
                    flex: 2,
                    child: Text('OPTIONS', style: tinyTextStyle(context, opacity: 0.2).copyWith(letterSpacing: 1, fontWeight: FontWeight.bold, fontSize: 10))),
                  Flexible(
                    flex: 3,
                    child: Divider(indent: 12, color: Theme.of(context).dividerColor)),
                ],
              ),
              _optionTile(context,
                title: 'Add/Remove from Playlists',
                subtitle: 'Add or remove this song from any playlist',
                icon: LineIcons.list,
                onTap: () {
                  Navigator.pop(context);
                  UiUtils.showModal(
                    context: internalNavigatorKey.currentContext!,
                    modal: AddToPlaylistSheet(song: song),
                  );
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
              if (isDownload)
              _optionTile(context,
                title: Languages.of(context)!.labelDeleteSong,
                subtitle: 'This action cannot be undone',
                icon: LineIcons.trash,
                onTap: () async {
                  final result = await UiUtils.showModal(
                    context: internalNavigatorKey.currentContext!,
                    modal: CommonSheet(
                      builder:(context, scrollController) {
                        return CommonSheetWidget(
                          title: Languages.of(context)!.labelDeleteSong,
                          body: Text('Are you sure? This action is irreversible!', style: subtitleTextStyle(context)),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Delete', style: smallTextStyle(context).copyWith(color: Colors.red))),
                            TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel', style: smallTextStyle(context)))
                          ],
                        );
                      },
                    )
                  );
                  if (result ?? false) {
                    mediaProvider.songs.removeWhere((element) => element.id == song.id);
                    mediaProvider.updateState();
                    await downloadProvider.deleteDownload(song);
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
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
              const SizedBox(height: 12)
            ],
          ),
        );
      },
    );
  }

  Widget _optionTile(BuildContext context, {required String title, required String subtitle, required IconData icon, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
        height: kToolbarHeight+4,
        child: Row(
          children: [
            AppAnimatedIcon(icon),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: smallTextStyle(context)),
                  const SizedBox(height: 2),
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