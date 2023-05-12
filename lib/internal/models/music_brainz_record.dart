
import 'package:songtube/internal/music_brainz.dart';

class MusicBrainzRecord {

  final String id;
  final String title;
  final String artist;
  final String album;
  final String date;
  final String genre;
  final String disc;
  final String track;
  String? artwork;

  MusicBrainzRecord({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.date,
    required this.genre,
    required this.disc,
    required this.track,
    this.artwork,
  });

  static MusicBrainzRecord fromMap(Map<String, dynamic> map) {
    return MusicBrainzRecord(
      id: map.containsKey('releases')
        ? map['releases'].isNotEmpty ? map['releases'][0]['id'] : null : map['id'],
      title: MusicBrainzAPI.getTitle(map),
      artist: MusicBrainzAPI.getArtist(map),
      album: MusicBrainzAPI.getAlbum(map),
      date: MusicBrainzAPI.getDate(map),
      genre: MusicBrainzAPI.getGenre(map),
      disc: MusicBrainzAPI.getDiscNumber(map),
      track: MusicBrainzAPI.getTrackNumber(map),
    );
  }

}