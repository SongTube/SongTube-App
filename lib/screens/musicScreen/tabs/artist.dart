import 'package:animations/animations.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/models/mediaItemSorts.dart';
import 'package:songtube/screens/musicScreen/components/music_type_expandable.dart';
import 'package:songtube/screens/musicScreen/components/songsList.dart';

class MusicScreenArtistTab extends StatefulWidget {
  final List<MediaItem> songs;
  final String searchQuery;
  MusicScreenArtistTab({
    this.songs,
    this.searchQuery
  });
  @override
  _MusicScreenArtistTabState createState() => _MusicScreenArtistTabState();
}

class _MusicScreenArtistTabState extends State<MusicScreenArtistTab> {

  // Artists
  List<MediaItemArtist> _artists = [];

  // Current Artist
  MediaItemArtist currentArtist;

  // Artists GridView Key
  final artistsGridKey = const PageStorageKey<String>('songsArtistList');

  @override
  void initState() {
    widget.songs.forEach((song) => songCreateOrAssignToArtist(song));
    super.initState();
  }

  void songCreateOrAssignToArtist(MediaItem song) {
    // Check if Artist exist and create it
    if (_artists.indexWhere((artist) => artist.artistName == (song?.artist ?? "unknown")) == -1) {
      // Create Artist and add the song
      _artists.add(
        MediaItemArtist(
          artistName: song?.artist ?? "unknown",
          mediaItems: []
        )
      );
    }
    // Add song to Artist
    int indexToArtist = _artists.indexWhere((artist) => artist.artistName == (song?.artist ?? "unknown"));
    _artists[indexToArtist].mediaItems.add(song);
  }

  Widget build(BuildContext context) {
    List<MediaItemArtist> artists = [];
    for (int i = 0; i < _artists.length; i++) {
      if (widget.searchQuery == "" || getSearchQueryMatch(_artists[i]))
        artists.add(_artists[i]);
    }
    return ListView.builder(
      key: artistsGridKey,
      itemCount: artists.length,
      itemBuilder: (context, index) {
        MediaItemArtist artist = artists[index];
        return MusicScreenTypeExpandable(
          title: artist.artistName,
          songs: artist.mediaItems,
        );
      }
    );
  }

  bool getSearchQueryMatch(MediaItemArtist artist) {
    if (widget.searchQuery != "") {
      if (artist.artistName.toLowerCase().contains(widget.searchQuery.toLowerCase())) {
        return true;
      } else if (artist.artistName.toLowerCase().contains(widget.searchQuery.toLowerCase())) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}