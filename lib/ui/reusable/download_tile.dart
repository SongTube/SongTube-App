import 'package:flutter/material.dart';
import 'package:songtube/internal/models/metadata.dart';

class DownloadTile extends StatelessWidget {
  final Stream<String> dataProgress;
  final Stream<double> progressBar;
  final Stream<String> currentAction;
  final MediaMetaData metadata;
  final Function onDownloadCancel;
  final Function onTilePlay;
  DownloadTile({
    @required this.dataProgress,
    @required this.progressBar,
    @required this.currentAction,
    @required this.metadata,
    this.onDownloadCancel,
    this.onTilePlay
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).inputDecorationTheme.fillColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget> [
            Row(
              children: <Widget> [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    metadata.coverurl,
                    height: 90,
                    width: 160,
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: <Widget> [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            metadata.title.toString(),
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            metadata.artist.toString(),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.grey[500]
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.play_arrow, size: 18),
                              onPressed: onTilePlay,
                            ),
                            onDownloadCancel != null
                            ? IconButton(
                                icon: Icon(Icons.clear, size: 18),
                                onPressed: onDownloadCancel
                              )
                            : Container()
                          ],
                        ),
                      ]
                    ),
                  ),
                ),
              ]
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: StreamBuilder<double>(
                stream: progressBar,
                builder: (context, snapshot) {
                  return LinearProgressIndicator(
                    value: snapshot.data,
                    backgroundColor: Theme.of(context).cardColor,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                  );
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: <Widget> [
                  StreamBuilder<String>(
                    stream: dataProgress,
                    builder: (context, snapshot) {
                      return snapshot.data == null 
                      ? Container()
                      : Text(
                        "Size: " + snapshot.data + "MB",
                        style: TextStyle(
                          fontSize: 12
                        ),
                      );
                    }
                  ),
                  Spacer(),
                  StreamBuilder<String>(
                    stream: currentAction,
                    builder: (context, snapshot) {
                      return snapshot.data == null 
                      ? Text(
                        "Downloading...",
                        style: TextStyle(
                          fontSize: 12
                        ),
                      )
                      : Text(
                        snapshot.data.toString(),
                        style: TextStyle(
                          fontSize: 12
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}