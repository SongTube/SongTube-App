// Flutter
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/player/service/playerService.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/screens/mediaScreen/components/loadingListWidget.dart';
import 'package:songtube/screens/mediaScreen/components/mediaListBase.dart';
import 'package:songtube/screens/mediaScreen/components/musicList/listView.dart';
import 'package:songtube/screens/mediaScreen/components/noPermissionWidget.dart';

// Packages
import 'package:permission_handler/permission_handler.dart';
import 'package:audio_service/audio_service.dart';
import 'package:provider/provider.dart';

class MediaMusicTab extends StatelessWidget {
  final String searchQuery;
  MediaMusicTab(this.searchQuery);
  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    List<MediaItem> songs = List<MediaItem>();
    if (searchQuery == "") {
      songs = mediaProvider.listMediaItems;
    } else {
      mediaProvider.listMediaItems.forEach((item) {
        if (item.title.toLowerCase()
          .replaceAll(RegExp("[^0-9a-zA-Z]+"), "")
          .contains(searchQuery.toLowerCase()
          .replaceAll(RegExp("[^0-9a-zA-Z]+"), ""))
        ) {
          songs.add(item);
        }
      });
    }
    return MediaListBase(
      baseWidget: MusicListView(
        listSongs: songs,
        onSongPlay: (MediaItem song) async {
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
          if (listEquals(mediaProvider.listMediaItems, AudioService.queue) == false) {
            await AudioService.updateQueue(mediaProvider.listMediaItems);
          }
          await AudioService.playMediaItem(mediaProvider.listMediaItems[
            mediaProvider.listMediaItems.indexWhere((element) => element == song)
          ]);
        },
      ),
      loadingWidget: MediaLoadingWidget(),
      noPermissionWidget: NoPermissionWidget(
        onPermissionRequest: () {
          Permission.storage.request().then((value) {
            if (value == PermissionStatus.granted) {
              mediaProvider.storagePermission = true;
              mediaProvider.loadSongList();
            }
          });
        }
      ),
      permissionStatus: mediaProvider.storagePermission,
      listStatus: mediaProvider.listMediaItems.isNotEmpty,
    );
  }
}