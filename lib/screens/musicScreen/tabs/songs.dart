import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/screens/musicScreen/components/songsList.dart';


class MusicScreenSongsTab extends StatefulWidget {
  final List<MediaItem> songs;
  final bool hasDownloadType;
  final String searchQuery;
  MusicScreenSongsTab({
    @required this.songs,
    this.hasDownloadType = false,
    this.searchQuery = ""
  });

  @override
  State<MusicScreenSongsTab> createState() => _MusicScreenSongsTabState();
}

class _MusicScreenSongsTabState extends State<MusicScreenSongsTab> {
  
  // Scroll Controller
  ScrollController controller;

  @override
  void initState() {
    controller = ScrollController(initialScrollOffset:
      Provider.of<MediaProvider>(context, listen: false).musicScrollPosition);
    controller.addListener(() {
      Provider.of<MediaProvider>(context, listen: false)
        .musicScrollPosition = controller.position.pixels;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SongsListView(
      scrollController: controller,
      songs: widget.songs, searchQuery: widget.searchQuery);
  }
}