// Dart
import 'dart:io';

// Flutter
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/screens/mediaScreen/dialogs/optionsMenuDialog.dart';

// Packages
import 'package:transparent_image/transparent_image.dart';

class MusicListView extends StatelessWidget {
  final List<MediaItem> listSongs;
  final Function(MediaItem) onSongPlay;
  MusicListView({
    @required this.listSongs,
    @required this.onSongPlay
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listSongs.length,
      itemExtent: 70,
      key: PageStorageKey('musicList'),
      itemBuilder: (context, index) { 
        MediaItem song = listSongs[index];
        return ListTile(
          title: Text(
            song.title,
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
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
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                fadeInDuration: Duration(milliseconds: 250),
                placeholder: MemoryImage(kTransparentImage),
                image: FileImage(File(song.artUri.replaceAll("file://", ""))),
                fit: BoxFit.cover,
              )
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.more_vert),
            iconSize: 18,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => MediaOptionsMenuDialog(
                  song: song,
                  deleteFrom: DeleteFrom.music,
                )
              );
            },
          ),
          onTap: () => onSongPlay(song)
        );
      },
    );
  }
}