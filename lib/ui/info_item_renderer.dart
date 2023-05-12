import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/infoItems/channel.dart';
import 'package:newpipeextractor_dart/models/infoItems/playlist.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:songtube/ui/tiles/channel_tile.dart';
import 'package:songtube/ui/tiles/stream_playlist_tile.dart';
import 'package:songtube/ui/tiles/stream_tile.dart';

class InfoItemRenderer extends StatelessWidget {
  const InfoItemRenderer({
    required this.infoItem,
    this.expandItem = false,
    this.editable = true,
    this.onDelete,
    super.key});
  final dynamic infoItem;
  final bool expandItem;
  final bool editable;
  final Function()? onDelete;
  @override
  Widget build(BuildContext context) {
    if (infoItem is ChannelInfoItem) {
      return ChannelTile(channel: infoItem, size: ChannelTileSize.big);
    } else if (infoItem is StreamInfoItem) {
      if (expandItem) {
        return StreamTileExpanded(stream: infoItem, onDelete: onDelete);
      } else {
        return StreamTileCollapsed(stream: infoItem, onDelete: onDelete);
      }
    } else if (infoItem is PlaylistInfoItem) {
      if (expandItem) {
        return PlaylistTileExpanded(playlist: infoItem);
      } else {
        return PlaylistTileCollapsed(playlist: infoItem, isEditable: editable);
      }
    } else {
      return const SizedBox();
    }
  }
}