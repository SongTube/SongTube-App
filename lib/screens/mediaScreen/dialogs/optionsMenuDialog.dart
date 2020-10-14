import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/provider/managerProvider.dart';

class MediaOptionsMenuDialog extends StatelessWidget {
  final int songIndex;
  final String songPath;
  MediaOptionsMenuDialog({
    @required this.songIndex,
    @required this.songPath
  });
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
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
                if (AudioService.currentMediaItem.id == songPath) {
                  AudioService.stop();
                }
              }
              manager.songFileList.removeAt(songIndex);
              await File(songPath).delete();
              NativeMethod.registerFile(songPath);
            },
          ),
        ],
      ),
    );
  }
}