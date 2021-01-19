// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/screens/mediaScreen/components/mediaListBase.dart';

// Packages
import 'package:provider/provider.dart';

// UI
import 'package:songtube/screens/mediaScreen/components/songsListView.dart';

class DownloadsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    mediaProvider.getDatabase();
    return MediaListBase(
      isLoading: mediaProvider.loadingDownloads,
      isEmpty: mediaProvider.databaseSongs.isEmpty,
      listType: MediaListBaseType.Downloads,
      child: SongsListView(
        songs: mediaProvider.databaseSongs,
        hasDownloadType: true,
      ),
    );
  }
}