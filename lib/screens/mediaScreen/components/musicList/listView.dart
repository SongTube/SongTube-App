// Dart
import 'dart:io';

// Flutter
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/provider/mediaProvider.dart';

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
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: listSongs.length,
      itemBuilder: (context, index) {
        if (index+1 <= listSongs.length) {
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
                  image: FileImage(File(song.extras["artwork"])),
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
                    onDelete: () async {
                      Navigator.pop(context);
                      if (AudioService.playbackState.playing) {
                        if (AudioService.currentMediaItem.id == song.id) {
                          AudioService.stop();
                        }
                      }
                      mediaProvider.listMediaItems.removeAt(index);
                      await File(song.id).delete();
                      NativeMethod.registerFile(song.id);
                    },
                  )
                );
              },
            ),
            onTap: () => onSongPlay(song)
          );
        } else {return Container();}
      },
    );
  }
}