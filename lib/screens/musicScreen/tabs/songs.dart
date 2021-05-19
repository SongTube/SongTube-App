import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:songtube/screens/musicScreen/components/songsList.dart';


class MusicScreenSongsTab extends StatelessWidget {
  final List<MediaItem> songs;
  final bool hasDownloadType;
  final String searchQuery;
  MusicScreenSongsTab({
    @required this.songs,
    this.hasDownloadType = false,
    this.searchQuery = ""
  });
  @override
  Widget build(BuildContext context) {
    return SongsListView(songs: songs, searchQuery: searchQuery);
  }
}