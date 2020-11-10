import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/downloadinfoset.dart';
import 'package:songtube/internal/models/metadata.dart';
import 'package:string_validator/string_validator.dart';
import 'package:transparent_image/transparent_image.dart';

class DownloadTile extends StatelessWidget {
  final Stream dataProgress;
  final Stream currentAction;
  final Stream progressBar;
  final DownloadMetaData metadata;
  final DownloadType downloadType;
  final Function onDownloadCancel;
  final Widget cancelDownloadIcon;
  DownloadTile({
    @required this.dataProgress,
    @required this.currentAction,
    @required this.progressBar,
    @required this.metadata,
    @required this.downloadType,
    this.onDownloadCancel,
    this.cancelDownloadIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor
      ),
      // Tile main Body
      child: Column(
        children: [
          // Media Metadata (Artwork, Title & Artist)
          Row(
            children: [
              // Artwork
              Container(
                height: 90,
                width: 160,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        fadeInDuration: Duration(milliseconds: 250),
                        placeholder: MemoryImage(kTransparentImage),
                        image: isURL(metadata.coverurl)
                          ? NetworkImage(metadata.coverurl)
                          : FileImage(File(metadata.coverurl)),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 30,
                        width: 30,
                        margin: EdgeInsets.only(left: 6, top: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor.withOpacity(0.6)
                        ),
                        child: Icon(downloadType == DownloadType.VIDEO
                          ? EvaIcons.videoOutline
                          : EvaIcons.musicOutline,
                          color: Theme.of(context).textTheme.bodyText1.color,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Title & Artist
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "${metadata.title}",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${metadata.artist}",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6),
                          fontSize: 12
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 1,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 250),
                          child: cancelDownloadIcon == null
                            ? Container()
                            : IconButton(
                                icon: cancelDownloadIcon,
                                onPressed: onDownloadCancel
                              )
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          StreamBuilder(
              stream: progressBar,
              builder: (context, snapshot) {
                return Container(
                  padding: EdgeInsets.all(8),
                  height: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: snapshot.data,
                      backgroundColor: Theme.of(context).cardColor,
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
                    ),
                  ),
                );
              }
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
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
                        Languages.of(context).labelDownloading,
                        style: TextStyle(
                          fontSize: 12,
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
        ],
      ),
    );
  }
}