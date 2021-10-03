import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/ui/layout/streamsListTile.dart';

class WatchHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    List<StreamInfoItem> history = prefs.watchHistory;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text(
          "Watch History",
          style: TextStyle(
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyText1.color
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color),
      ),
      body: Column(
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[600].withOpacity(0.1),
            indent: 12,
            endIndent: 12
          ),
          Expanded(
            child: history.isNotEmpty
              ? StreamsListTileView(
                  streams: history,
                  onTap: (stream, index) {
                    Navigator.of(context).pop();
                    pageProvider.infoItem = stream;
                  },
                  onDelete: (item) => prefs.deleteFromWatchHistory(item as StreamInfoItem)
                ) 
              : Center(
                  child: Text(
                    "History is Empty!",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                    ),
                  ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).padding.bottom,
            color: Theme.of(context).cardColor
          )
        ],
      )
    );
  }
}