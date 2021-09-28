import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/ffmpeg/extractor.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/playlist.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/screens/musicScreen/components/music_type_expandable.dart';
import 'package:songtube/screens/musicScreen/components/playlistEmpty.dart';
import 'package:songtube/ui/dialogs/alertDialog.dart';

class MusicScreenPlaylistTab extends StatefulWidget {
  const MusicScreenPlaylistTab({
    Key key }) : super(key: key);

  @override
  _MusicScreenPlaylistTabState createState() => _MusicScreenPlaylistTabState();
}

class _MusicScreenPlaylistTabState extends State<MusicScreenPlaylistTab> {

  // Albums GridView Key
  final playlistsGridKey = const PageStorageKey<String>('albumsGrid');

  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    List<LocalPlaylist> playlists = prefs.localPlaylists;
    return Builder(
      builder: (context) {
        if (playlists.isNotEmpty) {
          return ListView.builder(
            key: playlistsGridKey,
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              LocalPlaylist playlist = playlists[index];
              return FutureBuilder(
                future: FFmpegExtractor.getAudioArtwork(
                  audioFile: playlist.songs.isNotEmpty
                    ? playlist.songs[0].id
                    : null,
                  audioId: playlist.songs.isNotEmpty
                    ? playlist.songs[0].extras['albumId']
                    : null,
                  forceExtraction: true
                ),
                builder: (context, future) {
                  return MusicScreenTypeExpandable(
                    id: playlist.id,
                    title: playlist.name,
                    lowResThumbnail: future.hasData ? future.data.path : null,
                    songs: playlist.songs,
                    onDeletePlaylist: () async {
                      final result = await showDialog<bool>(context: context, builder: (context) {
                        return CustomAlert(
                          leadingIcon: Icon(Icons.warning_rounded, color: Theme.of(context).accentColor),
                          title: playlist.name,
                          content: 'Are you sure? This Playlist will be permanently deleted!',
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: Text(Languages.of(context).labelCancel)
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text(Languages.of(context).labelRemove)
                            ),
                          ]
                        );
                      });
                      if (result) {
                        prefs.deleteLocalPlaylist(playlist.id);
                      }
                    },
                  );
                }
              );
            }
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: PlaylistEmptyWidget()),
            ],
          );
        }
      }
    );
  }

  

}