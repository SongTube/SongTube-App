import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/mediaProvider.dart';

enum DeleteFrom { downloads, music }

class MediaOptionsMenuDialog extends StatelessWidget {
  final MediaItem song;
  final DeleteFrom deleteFrom;
  MediaOptionsMenuDialog({
    @required this.song,
    @required this.deleteFrom
  });
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(EvaIcons.trashOutline, color: Theme.of(context).accentColor),
            title: Text(
              "Delete Song",
              style: TextStyle(
                fontFamily: 'YTSans',
                color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6)
              ),
            ),
            onTap: () async {
              Navigator.pop(context);
              if (AudioService.playbackState.playing) {
                if (AudioService.currentMediaItem.id == song.id) {
                  AudioService.stop();
                }
              }
              if (deleteFrom == DeleteFrom.downloads) {
                manager.getCurrentMediaItemList().removeAt(
                  manager.getCurrentMediaItemList().indexWhere((file) => file == song)
                );
              } else if (deleteFrom == DeleteFrom.music) {
                mediaProvider.listMediaItems.removeAt(
                  mediaProvider.listMediaItems.indexWhere((file) => file == song)
                );
              }
              await File(song.id).delete();
              NativeMethod.registerFile(song.id);
            },
          ),
        ],
      ),
    );
  }
}