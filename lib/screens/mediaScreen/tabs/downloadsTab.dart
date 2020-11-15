// Dart
import 'dart:io';

// Flutter
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/internal/models/videoFile.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/player/service/playerService.dart';
import 'package:songtube/player/videoPlayer.dart';

// Packages
import 'package:songtube/screens/mediaScreen/dialogs/optionsMenuDialog.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:audio_service/audio_service.dart';
import 'package:provider/provider.dart';

// UI
import 'package:songtube/screens/mediaScreen/components/downloads/downloadsEmpty.dart';

class MediaDownloadTab extends StatelessWidget {
  final String searchQuery;
  MediaDownloadTab(this.searchQuery);
  @override
  Widget build(BuildContext context) {
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      child: downloadsProvider.databaseSongs.isEmpty
        ? const MediaDownloadsEmpty()
        : ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: downloadsProvider.databaseSongs.length,
            itemBuilder: (context, index) {
              MediaItem song = downloadsProvider.databaseSongs[index];
              if (searchQuery == "") {
                return downloadTile(context, song, index);
              } else {
                if (song.title.toLowerCase().contains(searchQuery.toLowerCase())) {
                  return downloadTile(context, song, index);
                } else {
                  return Container();
                }
              }
            },
          )
    );
  }

  Widget downloadTile(BuildContext context, MediaItem song, int index) {
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context);
    return ListTile(
      title: Text(
        song.title,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color
        ),
      ),
      subtitle: Text(
        song.artist,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6)
        ),
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black12.withOpacity(0.04)
            ),
            child: Icon(
              song.extras["downloadType"] == "Audio"
                ? EvaIcons.musicOutline
                : EvaIcons.videoOutline,
              color: Theme.of(context).iconTheme.color,
              size: 20,
            ),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                fadeInDuration: Duration(milliseconds: 200),
                placeholder: MemoryImage(kTransparentImage),
                image: FileImage(File(song.extras["artwork"])),
                fit: BoxFit.cover,
              )
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.more_vert),
        iconSize: 18,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => MediaOptionsMenuDialog(
              song: song,
              onDelete: () async {
                Navigator.pop(context);
                if (AudioService.playbackState.playing) {
                  if (AudioService.currentMediaItem.id == song.id) {
                    AudioService.stop();
                  }
                }
                // Get List<MediaItem> from Database Songs
                downloadsProvider.databaseSongs.removeAt(
                  downloadsProvider.databaseSongs.indexWhere((file) => file == song)
                );
                await File(song.id).delete();
                NativeMethod.registerFile(song.id);
              },
            )
          );
        },
      ),
      onTap: () async {
        if (song.extras["downloadType"] == "Audio") {
          if (!AudioService.running) {
            await AudioService.start(
              backgroundTaskEntrypoint: songtubePlayer,
              androidNotificationChannelName: 'SongTube',
              // Enable this if you want the Android service to exit the foreground state on pause.
              //androidStopForegroundOnPause: true,
              androidNotificationColor: 0xFF2196f3,
              androidNotificationIcon: 'drawable/ic_stat_music_note',
              androidEnableQueue: true,
            );
          }
          if (listEquals(downloadsProvider.databaseSongs, AudioService.queue) == false) {
            await AudioService.updateQueue(downloadsProvider.databaseSongs);
          }
          await AudioService.playMediaItem(downloadsProvider.databaseSongs[index]);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => 
              AppVideoPlayer(VideoFile(
                name: song.title,
                path: song.id,
              )))
          );
        }
      },
    );
  }
}