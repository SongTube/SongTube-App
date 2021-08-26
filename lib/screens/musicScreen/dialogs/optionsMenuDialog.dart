import 'package:audio_service/audio_service.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';

enum DeleteFrom { downloads, music }

class MediaOptionsMenuDialog extends StatelessWidget {
  final MediaItem song;
  final Function onDelete;
  MediaOptionsMenuDialog({
    required this.song,
    required this.onDelete
  });
  @override
  Widget build(BuildContext context) {
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
              Languages.of(context)!.labelDeleteSong,
              style: TextStyle(
                fontFamily: 'YTSans',
                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)
              ),
            ),
            onTap: onDelete as void Function()?
          ),
        ],
      ),
    );
  }
}