import 'package:animations/animations.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/models/mediaItemSorts.dart';
import 'package:songtube/screens/musicScreen/components/songsList.dart';

class MusicScreenGenreTab extends StatefulWidget {
  final List<MediaItem>? songs;
  final String? searchQuery;
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
  MediaItemGenre? currentGenre;

  // Genres GridView Key
  final genresGridKey = const PageStorageKey<String>('songsGenreList');

  @override
  void initState() {
    widget.songs!.forEach((song) => songCreateOrAssignToGenre(song));
    super.initState();
  }

  void songCreateOrAssignToGenre(MediaItem song) {
    // Check if Genre exist and create it
    if (_genres.indexWhere((genre) => genre.genreName == (song.genre ?? "unknown")) == -1) {
      // Create Genre and add the song
      _genres.add(
        MediaItemGenre(
          genreName: song.genre ?? "unknown",
          mediaItems: []
        )
      );
    }
    // Add song to Genre
    int indexToGenre = _genres.indexWhere((genre) {
      return genre.genreName == (song.genre ?? "unknown");
    });
    _genres[indexToGenre].mediaItems!.add(song);
  }

  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      transitionBuilder: (
        Widget child,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return FadeThroughTransition(
          fillColor: Theme.of(context).cardColor,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      duration: Duration(milliseconds: 300),
      child: currentGenre == null
        ? _gridView()
        : _genreView(context)
    );
  }

  Widget _genreView(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _genreTile(context, currentGenre!, true)),
            IconButton(
              icon: Icon(Icons.clear,
                color: Theme.of(context).iconTheme.color),
              onPressed: () => setState(() => currentGenre = null),
            ),
            SizedBox(width: 12)
          ],
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[600]!.withOpacity(0.1),
          indent: 12,
          endIndent: 12
        ),
        Expanded(
          child: SongsListView(
            songs: currentGenre!.mediaItems,
            searchQuery: ""
          ),
        )
      ],
    );
  }

  Widget _genreTile(BuildContext context, MediaItemGenre genre, bool shinySongsCount) {
    return Container(
      padding: EdgeInsets.all(12),
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    genre.genreName ?? "unknown",
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 20
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: shinySongsCount
                      ? Theme.of(context).accentColor
                      : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: shinySongsCount 
                          ? Theme.of(context).accentColor
                              .withOpacity(0.4)
                          : Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 4)
                      )
                    ]
                  ),
                  child: Text(
                    "${genre.mediaItems!.length} Songs",
                    style: TextStyle(
                      color: shinySongsCount
                        ? Colors.white
                        : Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 10,
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w700
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _gridView() {
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
        return GestureDetector(
          onTap: () => setState(() => currentGenre = genre),
          child: _genreTile(context, genre, false)
        );
      }
    );
  }

  bool getSearchQueryMatch(MediaItemGenre genre) {
    if (widget.searchQuery != "") {
      if (genre.genreName!.toLowerCase().contains(widget.searchQuery!.toLowerCase())) {
        return true;
      } else if (genre.genreName!.toLowerCase().contains(widget.searchQuery!.toLowerCase())) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}