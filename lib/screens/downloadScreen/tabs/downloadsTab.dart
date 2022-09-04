// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/screens/musicScreen/components/mediaListBase.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:songtube/screens/musicScreen/components/songsList.dart';

// UI
import 'package:songtube/screens/musicScreen/tabs/songs.dart';

class DownloadsTab extends StatefulWidget {
  @override
  _DownloadsTabState createState() => _DownloadsTabState();
}

class _DownloadsTabState extends State<DownloadsTab> {

  @override
  void initState() {
    Provider.of<MediaProvider>(context, listen: false).getDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
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