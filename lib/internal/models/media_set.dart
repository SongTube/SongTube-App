import 'package:songtube/internal/models/song_item.dart';

class MediaSet<T extends Object>  {

  MediaSet({
    this.id,
    required this.name,
    this.author,
    this.artwork,
    this.favorite,
    required this.songs,
    this.isArtist = false
  });

  // Id
  final String? id;

  // Set Name
  String name;

  // Author
  final String? author;

  // Favorite
  bool? favorite;

  // Artwork (Uint8List, File, Path)
  dynamic artwork;

  // Set Songs
  final List<SongItem> songs;

  // Is this media set an Artist
  final bool isArtist;

}