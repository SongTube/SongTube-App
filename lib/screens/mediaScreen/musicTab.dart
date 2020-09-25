// Dart
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/internal/services/playerService.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/screens/mediaScreen/widgets/loadingListWidget.dart';
import 'package:songtube/screens/mediaScreen/widgets/mediaListBase.dart';
import 'package:songtube/screens/mediaScreen/widgets/musicList/listView.dart';
import 'package:songtube/screens/mediaScreen/widgets/noPermissionWidget.dart';

// Packages
import 'package:permission_handler/permission_handler.dart';
import 'package:audio_service/audio_service.dart';
import 'package:provider/provider.dart';

class MediaMusicTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    return MediaListBase(
      baseWidget: MusicListView(
        listSongs: mediaProvider.listSongs,
        onSongDelete: (int index) async {
          if (AudioService.playbackState.playing) {
            if (AudioService.currentMediaItem.id == mediaProvider.listSongs[index].path) {
              AudioService.stop();
            }
          }
          mediaProvider.listSongs.removeAt(index);
          mediaProvider.listMediaItems.removeAt(index);
          await File(mediaProvider.listSongs[index].path).delete();
          NativeMethod.registerFile(mediaProvider.listSongs[index].path);
        },
        onSongPlay: (int index) async {
          if (!AudioService.running) {
            await AudioService.start(
              backgroundTaskEntrypoint: audioPlayerTaskEntrypoint,
              androidNotificationChannelName: 'SongTube',
              // Enable this if you want the Android service to exit the foreground state on pause.
              //androidStopForegroundOnPause: true,
              androidNotificationColor: 0xFF2196f3,
              androidNotificationIcon: 'drawable/ic_stat_music_note',
              androidEnableQueue: true,
            );
          }
          await AudioService.updateQueue(mediaProvider.listMediaItems);
          await AudioService.playFromMediaId(index.toString());
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
      listStatus: mediaProvider.listSongs.isNotEmpty,
    );
  }
}