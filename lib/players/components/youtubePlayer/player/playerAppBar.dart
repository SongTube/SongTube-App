import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:newpipeextractor_dart/models/streams/videoOnlyStream.dart';
import 'package:songtube/ui/internal/popupMenu.dart';

class PlayerAppBar extends StatelessWidget {
  final List<VideoOnlyStream> streams;
  final String videoTitle;
  final Function(String) onStreamSelect;
  PlayerAppBar({
    @required this.streams,
    @required this.videoTitle,
    @required this.onStreamSelect
  });
  @override
  Widget build(BuildContext context) {
    List<String> qualities = [];
    streams.forEach((stream) {
      qualities.add(stream.formatSuffix + " • " + stream.resolution);
    });
    return Container(
      margin: EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(width: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(MdiIcons.circle, color: Colors.white, size: 16),
              Icon(MdiIcons.youtube, color: Colors.red, size: 32),
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "$videoTitle",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Product Sans',
                fontWeight: FontWeight.w600
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
          ),
          SizedBox(width: 16),
          FlexiblePopupMenu(
            borderRadius: 10,
            child: Container(
              padding: EdgeInsets.all(4),
              color: Colors.transparent,
              child: Icon(
                MdiIcons.dotsVertical,
                color: Colors.white,
              ),
            ),
            items: List<FlexiblePopupItem>.generate(qualities.length, (index) {
              return FlexiblePopupItem(
                title: qualities[index],
                value: qualities[index]
              );
            }),
            onItemTap: (String value) {
              if (value == null) return;
              int index = streams.indexWhere((element) =>
                element.formatSuffix + " • " + element.resolution == value);
              onStreamSelect(streams[index].url);
            }
          ),
          SizedBox(width: 8)
        ],
      ),
    );
  }
}