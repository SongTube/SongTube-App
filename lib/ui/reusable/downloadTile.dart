import 'dart:io';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class DownloadTile extends StatelessWidget {
  final Stream dataProgress;
  final Stream currentAction;
  final Stream progressBar;
  final String title;
  final String author;
  final String coverUrl;
  final Function onDownloadCancel;
  final Function onPauseDownload;
  final Widget cancelDownloadIcon;
  final Widget pauseDownloadIcon;
  DownloadTile({
    @required this.dataProgress,
    @required this.currentAction,
    @required this.progressBar,
    @required this.title,
    @required this.author,
    @required this.coverUrl,
    this.onDownloadCancel,
    this.cancelDownloadIcon,
    this.onPauseDownload,
    this.pauseDownloadIcon
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget> [
            Row(
              children: <Widget> [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
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
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            pauseDownloadIcon != null
                              ? Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        IconButton(
                                          icon: AnimatedSwitcher(
                                            duration: Duration(milliseconds: 200),
                                            child: pauseDownloadIcon,
                                          ),
                                          onPressed: onPauseDownload
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                            cancelDownloadIcon != null
                              ? Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        IconButton(
                                          icon: AnimatedSwitcher(
                                            duration: Duration(milliseconds: 200),
                                            child: cancelDownloadIcon,
                                          ),
                                          onPressed: onDownloadCancel
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container()
                          ],
                        )
                      ]
                    ),
                  ),
                ),
              ]
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: progressBar,
                builder: (context, snapshot) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: snapshot.data,
                      backgroundColor: Theme.of(context).cardColor,
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
                    ),
                  );
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: <Widget> [
                  StreamBuilder<Object>(
                    stream: dataProgress,
                    builder: (context, snapshot) {
                      return snapshot.data == null 
                      ? Container()
                      : Text(
                        snapshot.data,
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
  final String coverPath;
  final Function onTilePlay;
  final Function onTileRemove;
  DownloadTileWithoutStream({
    @required this.title,
    @required this.author,
    @required this.coverPath,
    this.onTilePlay,
    this.onTileRemove
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: <Widget> [
            Row(
              children: <Widget> [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.file(
                    File(coverPath),
                    height: 90,
                    width: 90,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 8),
                    child: Column(
                      children: <Widget> [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            title.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
            SizedBox(height: 8),
            SizedBox(height: 8),
          ]
        ),
      ),
    );
  }
}