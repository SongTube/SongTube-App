import 'package:animations/animations.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/models/mediaItemSorts.dart';
import 'package:songtube/screens/musicScreen/components/songsList.dart';

class MusicScreenArtistTab extends StatefulWidget {
  final List<MediaItem>? songs;
  final String? searchQuery;
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
  MediaItemArtist? currentArtist;

  // Artists GridView Key
  final artistsGridKey = const PageStorageKey<String>('songsArtistList');

  @override
  void initState() {
    widget.songs!.forEach((song) => songCreateOrAssignToArtist(song));
    super.initState();
  }

  void songCreateOrAssignToArtist(MediaItem song) {
    // Check if Artist exist and create it
    if (_artists.indexWhere((artist) => artist.artistName == (song.artist ?? "unknown")) == -1) {
      // Create Artist and add the song
      _artists.add(
        MediaItemArtist(
          artistName: song.artist ?? "unknown",
          mediaItems: []
        )
      );
    }
    // Add song to Artist
    int indexToArtist = _artists.indexWhere((artist) => artist.artistName == (song.artist ?? "unknown"));
    _artists[indexToArtist].mediaItems!.add(song);
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
      child: currentArtist == null
        ? _gridView()
        : _artistView(context)
    );
  }

  Widget _artistView(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _artistTile(context, currentArtist!, true)),
            IconButton(
              icon: Icon(Icons.clear,
                color: Theme.of(context).iconTheme.color),
              onPressed: () => setState(() => currentArtist = null),
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
            songs: currentArtist!.mediaItems,
            searchQuery: ""
          ),
        )
      ],
    );
  }

  Widget _artistTile(BuildContext context, MediaItemArtist artist, bool shinySongsCount) {
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
                    artist.artistName!,
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
                    "${artist.mediaItems!.length} Songs",
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
        return GestureDetector(
          onTap: () => setState(() => currentArtist = artist),
          child: _artistTile(context, artist, false)
        );
      }
    );
  }

  bool getSearchQueryMatch(MediaItemArtist artist) {
    if (widget.searchQuery != "") {
      if (artist.artistName!.toLowerCase().contains(widget.searchQuery!.toLowerCase())) {
        return true;
      } else if (artist.artistName!.toLowerCase().contains(widget.searchQuery!.toLowerCase())) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}