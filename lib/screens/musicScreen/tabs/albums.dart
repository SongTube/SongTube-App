import 'dart:io';

import 'package:animations/animations.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:songtube/internal/ffmpeg/extractor.dart';
import 'package:songtube/internal/models/mediaItemSorts.dart';
import 'package:songtube/screens/musicScreen/components/music_type_expandable.dart';
import 'package:songtube/screens/musicScreen/components/songsList.dart';

class MusicScreenAlbumsTab extends StatefulWidget {
  final List<MediaItem> songs;
  final String searchQuery;
  MusicScreenAlbumsTab({
    this.songs,
    this.searchQuery
  });
  @override
  _MusicScreenAlbumsTabState createState() => _MusicScreenAlbumsTabState();
}

class _MusicScreenAlbumsTabState extends State<MusicScreenAlbumsTab> {

  // Albums
  List<MediaItemAlbum> _albums = [];

  // Current album
  MediaItemAlbum currentAlbum;

  // Albums GridView Key
  final albumsGridKey = const PageStorageKey<String>('albumsGrid');

  @override
  void initState() {
    widget.songs.forEach((song) => songCreateOrAssignToAlbum(song));
    super.initState();
  }

  void songCreateOrAssignToAlbum(MediaItem song) {
    // Check if album exist and create it
    if (_albums.indexWhere((album) => album.albumTitle == song.album) == -1) {
      // Create album and add the song
      _albums.add(
        MediaItemAlbum(
          albumTitle: song.album,
          albumAuthor: song.artist,
          mediaItems: []
        )
      );
    }
    // Add song to Album
    int indexToAlbum = _albums.indexWhere((album) => album.albumTitle == song.album);
    _albums[indexToAlbum].mediaItems.add(song);
  }

  @override
  Widget build(BuildContext context) {
    List<MediaItemAlbum> albums = [];
    for (int i = 0; i < _albums.length; i++) {
      if (widget.searchQuery == "" || getSearchQueryMatch(_albums[i]))
        albums.add(_albums[i]);
    }
    return ListView.builder(
      key: albumsGridKey,
      itemCount: albums.length,
      itemBuilder: (context, index) {
        MediaItemAlbum album = albums[index];
        return FutureBuilder(
          future: FFmpegExtractor.getAudioArtwork(
            audioFile: album.mediaItems[0].id,
            audioId: album.mediaItems[0].extras['albumId'],
          ),
          builder: (context, future) {
            return MusicScreenTypeExpandable(
              title: album.albumTitle,
              description: album.albumAuthor,
              lowResThumbnail: album.mediaItems[0].extras['artwork'],
              thumbnail: future.hasData ? future.data.path : null,
              songs: album.mediaItems,
            );
          }
        );
      }
    );
  }

  bool getSearchQueryMatch(MediaItemAlbum album) {
    if (widget.searchQuery != "") {
      if (album.albumTitle.toLowerCase().contains(widget.searchQuery.toLowerCase())) {
        return true;
      } else if (album.albumTitle.toLowerCase().contains(widget.searchQuery.toLowerCase())) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

}