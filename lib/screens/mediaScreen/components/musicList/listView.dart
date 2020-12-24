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
import 'package:songtube/ui/components/popupMenu.dart';

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
            trailing: FlexiblePopupMenu(
              borderRadius: 10,
              items: [
                "Delete Song",
                "Edit Tags",
                "Apply Filters"
              ],
              onItemTap: (String value) async {
                if (AudioService.playbackState.playing) {
                  if (AudioService.currentMediaItem.id == song.id) {
                    AudioService.stop();
                  }
                }
                switch (value) {
                  case "Delete Song":
                    mediaProvider.listMediaItems.removeAt(index);
                    await File(song.id).delete();
                    NativeMethod.registerFile(song.id);
                    break;
                  case "Edit Tags":
                    // TODO: Show Tags editor Page
                    break;
                  case "Apply Filters":
                    // TODO: Allow Audio Filters application
                    break;
                }
                mediaProvider.setState();
              },
              child: Icon(Icons.more_vert, size: 18)
            ),
            onTap: () => onSongPlay(song)
          );
        } else {return Container();}
      },
    );
  }
}