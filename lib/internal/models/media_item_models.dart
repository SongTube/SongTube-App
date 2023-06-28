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
    List<MediaItemArtist> artists = [];
    for (final song in songs) {
      // Check if Artist exist and create it
      if (artists.indexWhere((artist) => artist.artistName == (song.artist ?? "Unknown")) == -1) {
        // Create Artist and add the song
        artists.add(
          MediaItemArtist(
            artistName: song.artist ?? "Unknown",
            mediaItems: []
          )
        );
      }
      // Add song to Artist
      int indexToArtist = artists.indexWhere((artist) => artist.artistName == (song.artist ?? "Unknown"));
      artists[indexToArtist].mediaItems.add(song);
    }
    return artists;
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
    List<MediaItemGenre> genres = [];
    for (final song in songs) {
      // Check if Genre exist and create it
      if (genres.indexWhere((genre) => genre.genreName == (song.genre ?? "Unknown")) == -1) {
        // Create Genre and add the song
        genres.add(
          MediaItemGenre(
            genreName: song.genre ?? "Unknown",
            mediaItems: []
          )
        );
      }
      // Add song to Genre
      int indexToGenre = genres.indexWhere((genre) {
        return genre.genreName == (song.genre ?? "Unknown");
      });
      genres[indexToGenre].mediaItems.add(song);
    }
    return genres;
  }

}