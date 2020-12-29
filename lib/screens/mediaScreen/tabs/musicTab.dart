// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/screens/mediaScreen/components/mediaListBase.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:provider/provider.dart';
import 'package:songtube/screens/mediaScreen/components/songsListView.dart';

class MediaMusicTab extends StatelessWidget {
  final String searchQuery;
  MediaMusicTab(this.searchQuery);
  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    List<MediaItem> songs = List<MediaItem>();
    if (searchQuery == "") {
      songs = mediaProvider.listMediaItems;
    } else {
      mediaProvider.listMediaItems.forEach((item) {
        if (item.title.toLowerCase()
          .replaceAll(RegExp("[^0-9a-zA-Z]+"), "")
          .contains(searchQuery.toLowerCase()
          .replaceAll(RegExp("[^0-9a-zA-Z]+"), ""))
        ) {
          songs.add(item);
        }
      });
    }
    return MediaListBase(
      isLoading: mediaProvider.loadingMusic,
      isEmpty: mediaProvider.listMediaItems.isEmpty,
      listType: MediaListBaseType.Any,
      child: SongsListView(
        songs: songs,
        searchQuery: searchQuery,
      ),
    );
  }
}