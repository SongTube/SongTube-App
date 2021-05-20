import 'dart:io';

import 'package:animations/animations.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:path/path.dart';
import 'package:songtube/internal/ffmpeg/extractor.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/mediaItemSorts.dart';
import 'package:songtube/screens/musicScreen/components/songsList.dart';
import 'package:transparent_image/transparent_image.dart';

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
      child: currentAlbum == null
        ? _gridView()
        : _albumView(context)
    );
  }

  Widget _albumView(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4)
                    )
                  ]
                ),
                child: _highResArtwork(currentAlbum)
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        currentAlbum.albumTitle,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontFamily: 'Product Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 20
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        currentAlbum.albumAuthor,
                        maxLines: 1,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color
                            .withOpacity(0.7),
                          fontFamily: 'Product Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 8),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).accentColor
                              .withOpacity(0.4),
                            blurRadius: 8,
                            offset: Offset(0, 4)
                          )
                        ]
                      ),
                      child: Text(
                        "${currentAlbum.mediaItems.length} Songs",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Product Sans',
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.clear,
                  color: Theme.of(context).iconTheme.color),
                onPressed: () => setState(() => currentAlbum = null),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[600].withOpacity(0.1),
          indent: 12,
          endIndent: 12
        ),
        Expanded(
          child: SongsListView(
            songs: currentAlbum.mediaItems,
            searchQuery: widget.searchQuery
          ),
        )
      ],
    );
  }

  Widget _gridView() {
    List<MediaItemAlbum> albums = [];
    for (int i = 0; i < _albums.length; i++) {
      if (widget.searchQuery == "" || getSearchQueryMatch(_albums[i]))
        albums.add(_albums[i]);
    }
    return GridView.builder(
      key: albumsGridKey,
      itemCount: albums.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      itemBuilder: (context, index) {
        MediaItemAlbum album = albums[index];
        return Padding(
          padding: index.isEven
            ? EdgeInsets.only(bottom: 12, right: 6)
            : EdgeInsets.only(bottom: 12, left: 6),
          child: GestureDetector(
            onTap: () => setState(() => currentAlbum = album),
            child: Stack(
              fit: StackFit.expand,
              children: [
                _highResArtwork(album),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8)
                      ],
                      begin: const Alignment(0.0, -0.05),
                      end: const Alignment(0.0, 1),
                      tileMode: TileMode.clamp
                    ),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          album.albumTitle,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Product Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 16
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          album.albumAuthor,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontFamily: 'Product Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12
                          ),
                        ),
                      ),
                      SizedBox(height: 8)
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _highResArtwork(MediaItemAlbum album) {
    return FutureBuilder(
      future: FFmpegExtractor.getAudioArtwork(
        audioFile: album.mediaItems[0].id,
        audioId: album.mediaItems[0].extras['albumId'],
      ),
      builder: (context, snapshot) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: FadeInImage(
            fadeInDuration: Duration(milliseconds: 300),
            placeholder: MemoryImage(kTransparentImage),
            image: FileImage(File(
              snapshot.hasData
                ? snapshot.data.path
                : album.mediaItems[0].extras['artwork']
            )),
            fit: BoxFit.cover,
          ),
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