import 'package:audio_service/audio_service.dart';

class MediaItemAlbum {

  String? albumTitle;
  String? albumAuthor;
  List<MediaItem>? mediaItems;
  
  MediaItemAlbum({
    this.albumAuthor,
    this.albumTitle,
    this.mediaItems
  });

}

class MediaItemArtist {

  String? artistName;
  List<MediaItem>? mediaItems;
  
  MediaItemArtist({
    this.artistName,
    this.mediaItems
  });

}

class MediaItemGenre {

  String? genreName;
  List<MediaItem>? mediaItems;

  MediaItemGenre({
    this.genreName,
    this.mediaItems
  });

}