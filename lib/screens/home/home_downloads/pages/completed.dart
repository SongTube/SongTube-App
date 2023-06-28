import 'package:audio_service/audio_service.dart';
import 'package:external_video_player_launcher/external_video_player_launcher.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/download_provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/song_tile.dart';

class DownloadsCompletedPage extends StatefulWidget {
  const DownloadsCompletedPage({
    required this.searchQuery,
    super.key});
  final String searchQuery;
  @override
  State<DownloadsCompletedPage> createState() => _DownloadsCompletedPageState();
}

class _DownloadsCompletedPageState extends State<DownloadsCompletedPage> {
  @override
  Widget build(BuildContext context) {
    DownloadProvider downloadProvider = Provider.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: downloadProvider.downloadedSongs.isEmpty
        ? Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Ionicons.cloud_download_outline, size: 64),
              const SizedBox(height: 8),
              Text(Languages.of(context)!.labelNoDownloadsYet, style: textStyle(context)),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Text(Languages.of(context)!.labelNoDownloadsYetDescription, style: subtitleTextStyle(context, opacity: 0.6), textAlign: TextAlign.center,),
              ),
            ],
          ))
        : _body(),
    );
  }

  Widget _body() {
    DownloadProvider downloadProvider = Provider.of<DownloadProvider>(context);
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    UiProvider uiProvider = Provider.of(context);
    List<SongItem> downloads = downloadProvider.downloadedSongs;
    if (widget.searchQuery.isNotEmpty) {
      downloads = downloadProvider.downloadedSongs.where((element) => element.title.toLowerCase().contains(widget.searchQuery.trim().toLowerCase())).toList();
    }
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8).copyWith(bottom: (kToolbarHeight*1.5)+16),
      physics: const BouncingScrollPhysics(),
      itemCount: downloads.length,
      itemBuilder: (context, index) {
        final song = downloads[index];
        return SongTile(
          song: song,
          isDownload: true,
          onPlay: () async {
            if (song.isVideo) {
              // Open video player
              ExternalVideoPlayerLauncher.launchOtherPlayer(song.id, MIME.applicationMpeg, null);
            } else {
              mediaProvider.currentPlaylistName = 'Downloads';
              final queue = List<MediaItem>.generate(downloads.length, (index) {
                return downloads[index].mediaItem;
              });
              uiProvider.currentPlayer = CurrentPlayer.music;
              mediaProvider.playSong(queue, index);
            }
          }
        );
      }
    );
  }
}