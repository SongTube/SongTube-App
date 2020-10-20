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
import 'package:songtube/ui/animations/fadeSizeTransition.dart';

// Packages
import 'package:transparent_image/transparent_image.dart';

class MusicListView extends StatefulWidget {
  final List<MediaItem> listSongs;
  final Function(MediaItem) onSongPlay;
  MusicListView({
    @required this.listSongs,
    @required this.onSongPlay
  });

  @override
  _MusicListViewState createState() => _MusicListViewState();
}

class _MusicListViewState extends State<MusicListView> {

  // Key
  GlobalKey<AnimatedListState> listState;

  @override
  void initState() {
    listState = new GlobalKey<AnimatedListState>();
    super.initState();
  }

  void onDelete(int index, MediaItem removedItem) {
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return songTile(animation, removedItem, index);
    };
    listState.currentState.removeItem(index, builder);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      physics: AlwaysScrollableScrollPhysics(),
      initialItemCount: widget.listSongs.length,
      key: listState,
      itemBuilder: (context, index, animator) {
        if (index+1 <= widget.listSongs.length) {
          MediaItem song = widget.listSongs[index];
          return songTile(animator, song, index);
        } else {return Container();}
      },
    );
  }

  Widget songTile(Animation<double> animator, MediaItem song, int index) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    return FadeSizeTransition(
      animator: animator,
      child: ListTile(
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
                  listState.currentState.removeItem(index,
                    (context, animation) => Container());
                  await File(song.id).delete();
                  NativeMethod.registerFile(song.id);
                  onDelete(index, song);
                },
              )
            );
          },
        ),
        onTap: () => widget.onSongPlay(song)
      ),
    );
  }

}