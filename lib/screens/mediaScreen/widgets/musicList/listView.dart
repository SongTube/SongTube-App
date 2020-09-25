import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:songtube/internal/models/songFile.dart';
import 'package:songtube/screens/mediaScreen/dialogs/confirmDialog.dart';
import 'package:transparent_image/transparent_image.dart';

class MusicListView extends StatelessWidget {
  final List<SongFile> listSongs;
  final Function(int) onSongDelete;
  final Function(int) onSongPlay;
  MusicListView({
    @required this.listSongs,
    @required this.onSongDelete,
    @required this.onSongPlay
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: listSongs.length,
      itemBuilder: (context, index) { 
        SongFile song = listSongs[index];
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
            song.author,
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6)
            ),
          ),
          leading: Container(
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
                image: FileImage(File(song.coverPath)),
                fit: BoxFit.cover,
              )
            ),
          ),
          trailing: PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            icon: Icon(MdiIcons.dotsVertical, size: 18),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "Delete",
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                  ),
                )
              ];
            },
            onSelected: (String value) {
              switch (value) {
                case "Delete":
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmDialog(
                        onConfirm: () async {
                          Navigator.pop(context);
                          onSongDelete(index);
                        },
                        onCancel: () {
                          Navigator.pop(context);
                          return null;
                        },
                      );
                    }
                  );
                  break;
                default:
                  break;
              }
            },
          ),
          onTap: () => onSongPlay(index)
        );
      },
    );
  }
}