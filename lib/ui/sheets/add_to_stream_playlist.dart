import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/ui/animations/animated_text.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/sheets/new_stream_playlist.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/stream_playlist_tile.dart';
import 'package:songtube/ui/tiles/stream_tile.dart';
import 'package:songtube/ui/ui_utils.dart';
class AddToStreamPlaylist extends StatelessWidget {
  const AddToStreamPlaylist({
    required this.stream,
    Key? key}) : super(key: key);
  final StreamInfoItem stream;
  @override
  Widget build(BuildContext context) {
    ContentProvider contentProvider = Provider.of(context);
    final playlists = contentProvider.streamPlaylists;
    return CommonSheet(
      useCustomScroll: false,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.all(12).copyWith(top: 0),
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(Languages.of(context)!.labelAddVideoToPlaylist, style: textStyle(context))),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(top: 4),
                child: StreamTileCollapsed(stream: stream, isEditable: false),
              ),
              const SizedBox(height: 8),
              Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 2,
                    child: Divider(endIndent: 12, color: Theme.of(context).dividerColor)),
                  Flexible(
                    flex: 3,
                    child: Text('VIDEO PLAYLISTS', style: tinyTextStyle(context, opacity: 0.2).copyWith(letterSpacing: 1, fontWeight: FontWeight.bold, fontSize: 10))),
                  Flexible(
                    flex: 2,
                    child: Divider(indent: 12, color: Theme.of(context).dividerColor)),
                ],
              ),
              const SizedBox(height: 8),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];
                    final containsStream = playlist.streams!.any((element) => element.id == stream.id);
                    return Padding(
                      padding: const EdgeInsets.all(8.0).copyWith(top: 12, bottom: 12),
                      child: GestureDetector(
                        onTap: () {
                          if (containsStream) {
                            contentProvider.streamPlaylistRemoveStream(playlist.name!, stream);
                          } else {
                            contentProvider.streamPlaylistsInsertStream(playlist.name!, stream);
                          }
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Expanded(child: IgnorePointer(ignoring: true, child: PlaylistTileCollapsed(playlist: playlist.toPlaylistInfoItem(), isEditable: false))),
                              Padding(
                                padding: const EdgeInsets.only(right: 18, left: 12),
                                child: Transform.scale(
                                  scale: 0.6,
                                  child: RoundCheckBox(
                                    animationDuration: const Duration(milliseconds: 250),
                                    isChecked: containsStream,
                                    onTap: (_) {
                                      if (containsStream) {
                                        contentProvider.streamPlaylistRemoveStream(playlist.name!, stream);
                                      } else {
                                        contentProvider.streamPlaylistsInsertStream(playlist.name!, stream);
                                      }
                                    },
                                    borderColor: Theme.of(context).dividerColor,
                                    checkedColor: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                    modal: NewStreamPlaylist(fallbackStream: stream),
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