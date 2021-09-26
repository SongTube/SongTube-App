import 'package:animations/animations.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/models/mediaItemSorts.dart';
import 'package:songtube/screens/musicScreen/components/music_type_expandable.dart';
import 'package:songtube/screens/musicScreen/components/songsList.dart';

class MusicScreenGenreTab extends StatefulWidget {
  final List<MediaItem> songs;
  final String searchQuery;
  MusicScreenGenreTab({
    this.songs,
    this.searchQuery
  });
  @override
  _MusicScreenGenreTabState createState() => _MusicScreenGenreTabState();
}

class _MusicScreenGenreTabState extends State<MusicScreenGenreTab> {
  // Genres
  List<MediaItemGenre> _genres = [];

  // Current Genre
  MediaItemGenre currentGenre;

  // Genres GridView Key
  final genresGridKey = const PageStorageKey<String>('songsGenreList');

  @override
  void initState() {
    widget.songs.forEach((song) => songCreateOrAssignToGenre(song));
    super.initState();
  }

  void songCreateOrAssignToGenre(MediaItem song) {
    // Check if Genre exist and create it
    if (_genres.indexWhere((genre) => genre.genreName == (song?.genre ?? "unknown")) == -1) {
      // Create Genre and add the song
      _genres.add(
        MediaItemGenre(
          genreName: song?.genre ?? "unknown",
          mediaItems: []
        )
      );
    }
    // Add song to Genre
    int indexToGenre = _genres.indexWhere((genre) {
      return genre.genreName == (song?.genre ?? "unknown");
    });
    _genres[indexToGenre].mediaItems.add(song);
  }

  Widget build(BuildContext context) {
    List<MediaItemGenre> genres = [];
    for (int i = 0; i < _genres.length; i++) {
      if (widget.searchQuery == "" || getSearchQueryMatch(_genres[i]))
        genres.add(_genres[i]);
    }
    return ListView.builder(
      key: genresGridKey,
      itemCount: genres.length,
      itemBuilder: (context, index) {
        MediaItemGenre genre = genres[index];
        return MusicScreenTypeExpandable(
          title: genre.genreName,
          songs: genre.mediaItems,
        );
      }
    );
  }

  bool getSearchQueryMatch(MediaItemGenre genre) {
    if (widget.searchQuery != "") {
      if (genre.genreName.toLowerCase().contains(widget.searchQuery.toLowerCase())) {
        return true;
      } else if (genre.genreName.toLowerCase().contains(widget.searchQuery.toLowerCase())) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}