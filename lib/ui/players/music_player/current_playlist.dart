import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/song_item.dart';

class CurrentPlaylist extends StatelessWidget {
  const CurrentPlaylist({ Key? key }) : super(key: key);

  // Current Queue
  List<SongItem> get queue => List<SongItem>.generate(audioHandler.queue.value.length, (index) {
    return SongItem.fromMediaItem(audioHandler.queue.value[index]);
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}