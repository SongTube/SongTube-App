import 'package:songtube/internal/models/media_set.dart';
import 'package:songtube/internal/models/song_item.dart';

class MediaItemAlbum {

  String albumTitle;
  String albumAuthor;
  List<SongItem> mediaItems;
  
  MediaItemAlbum({
    required this.albumAuthor,
    required this.albumTitle,
    required this.mediaItems
  });

  MediaSet toMediaSet() {
    return MediaSet(
      artwork: mediaItems.first.artworkPath,
      name: albumTitle,
      author: albumAuthor,
      songs: mediaItems
    );
  }

  // Retrieve a list of MediaItemAlbum from a List of MediaItem
  static List<MediaItemAlbum> fetchAlbums(List<SongItem> songs) {
    List<MediaItemAlbum> albums = [];
    for (final song in songs) {
      // Check if album exist and create it
      if (albums.indexWhere((album) => album.albumTitle == song.album) == -1) {
        // Create album and add the song
        albums.add(
          MediaItemAlbum(
            albumTitle: song.album ?? 'Unknown',
            albumAuthor: song.artist ?? 'Unknown',
            mediaItems: []
          )
        );
      }
      // Add song to Album
      int indexToAlbum = albums.indexWhere((album) => album.albumTitle == song.album);
      albums[indexToAlbum].mediaItems.add(song);
    }
    return albums;
  }

}

class MediaItemArtist {

  String artistName;
  List<SongItem> mediaItems;
  
  MediaItemArtist({
    required this.artistName,
    required this.mediaItems
  });

  MediaSet toMediaSet({bool? isArtist}) {
    return MediaSet(
      artwork: mediaItems.first.artworkPath,
      name: artistName,
      songs: mediaItems,
      isArtist: isArtist ?? false
    );
  }

  static List<MediaItemArtist> fetchArtists(List<SongItem> songs) {
    List<MediaItemArtist> _artists = [];
    for (final song in songs) {
      // Check if Artist exist and create it
      if (_artists.indexWhere((artist) => artist.artistName == (song.artist ?? "Unknown")) == -1) {
        // Create Artist and add the song
        _artists.add(
          MediaItemArtist(
            artistName: song.artist ?? "Unknown",
            mediaItems: []
          )
        );
      }
      // Add song to Artist
      int indexToArtist = _artists.indexWhere((artist) => artist.artistName == (song.artist ?? "Unknown"));
      _artists[indexToArtist].mediaItems.add(song);
    }
    return _artists;
  }

}

class MediaItemGenre {

  String genreName;
  List<SongItem> mediaItems;

  MediaSet toMediaSet() {
    return MediaSet(
      artwork: mediaItems.first.artworkPath,
      name: genreName,
      songs: mediaItems
    );
  }

  MediaItemGenre({
    required this.genreName,
    required this.mediaItems
  });

  static List<MediaItemGenre> fetchGenres(List<SongItem> songs) {
    List<MediaItemGenre> _genres = [];
    for (final song in songs) {
      // Check if Genre exist and create it
      if (_genres.indexWhere((genre) => genre.genreName == (song.genre ?? "Unknown")) == -1) {
        // Create Genre and add the song
        _genres.add(
          MediaItemGenre(
            genreName: song.genre ?? "Unknown",
            mediaItems: []
          )
        );
      }
      // Add song to Genre
      int indexToGenre = _genres.indexWhere((genre) {
        return genre.genreName == (song.genre ?? "Unknown");
      });
      _genres[indexToGenre].mediaItems.add(song);
    }
    return _genres;
  }

}