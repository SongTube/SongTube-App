import 'package:flutter/material.dart';
import 'package:songtube/internal/models/metadata.dart';
import 'package:transparent_image/transparent_image.dart';

class DownloadTile extends StatelessWidget {
  final Stream<String> dataProgress;
  final Stream<double> progressBar;
  final Stream<String> currentAction;
  final String title;
  final String author;
  final String coverUrl;
  final Function onDownloadCancel;
  DownloadTile({
    @required this.dataProgress,
    @required this.progressBar,
    @required this.currentAction,
    @required this.title,
    @required this.author,
    @required this.coverUrl,
    this.onDownloadCancel,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget> [
            Row(
              children: <Widget> [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: FadeInImage(
                    image: NetworkImage(coverUrl),
                    placeholder: MemoryImage(kTransparentImage),
                    height: 90,
                    width: 160,
                    fit: BoxFit.fitWidth,
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
                            title.toString(),
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            author.toString(),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.grey[500]
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.clear, size: 18),
                                  onPressed: onDownloadCancel
                                )
                              ],
                            ),
                          ),
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
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: snapshot.data,
                      backgroundColor: Theme.of(context).cardColor,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                    ),
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

class DownloadTileWithoutStream extends StatelessWidget {
  final String title;
  final String author;
  final String coverUrl;
  final Function onTilePlay;
  final Function onTileRemove;
  DownloadTileWithoutStream({
    @required this.title,
    @required this.author,
    @required this.coverUrl,
    this.onTilePlay,
    this.onTileRemove
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget> [
            Row(
              children: <Widget> [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: FadeInImage(
                    image: NetworkImage(coverUrl),
                    placeholder: MemoryImage(kTransparentImage),
                    height: 90,
                    width: 160,
                    fit: BoxFit.fitWidth,
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
                            title.toString(),
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            author.toString(),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.grey[500]
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.play_arrow, size: 18),
                                onPressed: onTilePlay,
                              ),
                              IconButton(
                                icon: Icon(Icons.clear, size: 18),
                                onPressed: onTileRemove,
                              )
                            ],
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
              ]
            ),
          ]
        ),
      ),
    );
  }
}