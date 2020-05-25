// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/media_provider.dart';
import 'package:songtube/provider/player_provider.dart';
import 'package:songtube/internal/models/downloadinfoset.dart';
import 'package:songtube/internal/models/enums.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// UI
import 'package:songtube/ui/reusable/download_tile.dart';

class DownloadTab extends StatefulWidget {
  _DownloadTabState createState() => _DownloadTabState();
}

class _DownloadTabState extends State<DownloadTab> {

  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context, listen: true);
    Player audioPlayer = Provider.of<Player>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: mediaProvider.downloadInfoSetList.length == 0 ? 1.0 : 0.0,
            child: mediaProvider.downloadInfoSetList.length == 0
            ? Container(
              padding: EdgeInsets.only(top: 8),
              height: kToolbarHeight*1.1,
              child: Card(
                color: Theme.of(context).inputDecorationTheme.fillColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.file_download),
                        Text(
                        "    No downloads!  ",
                      ),
                    ],
                  ),
                )
              ),
            )
            : Container(),
          ),
          Expanded(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: mediaProvider.downloadInfoSetList.length > 0 ? 1.0 : 0.0,
              child: mediaProvider.downloadInfoSetList.length > 0 
              ? ListView.builder(
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                itemCount: mediaProvider.downloadInfoSetList.length,
                itemBuilder: (context, index) {
                  DownloadInfoSet infoset = mediaProvider.downloadInfoSetList[index];
                  return Padding(
                    padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                    child: DownloadTile(
                      dataProgress: infoset.downloader.dataProgress.stream,
                      progressBar: infoset.downloader.progressBar.stream,
                      currentAction: infoset.currentAction.stream,
                      metadata: infoset.metadata,
                      onDownloadCancel: infoset.downloader.downloadFinished == false
                      ? () {
                        setState(() => infoset.downloader.downloadFinished = true);
                      } : null,
                      onTilePlay: () {
                        if (infoset.downloadPath != null && infoset.downloadType == DownloadType.audio) {
                          audioPlayer.play(infoset.downloadPath);
                        }
                      }
                    ),
                  );
                },
              )
              : Container(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear_all),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          if (mediaProvider.downloadInfoSetList.any((element) => element.downloader.downloadFinished == false)) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Warning", style: TextStyle(
                    color: Theme.of(context).textTheme.body1.color
                  )),
                  content: Text("There are still downloads in progress, are you sure you wanna clear the downloads list?", style: TextStyle(
                    color: Theme.of(context).textTheme.body1.color
                  )),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("OK", style: TextStyle(
                        color: Theme.of(context).textTheme.body1.color
                      )),
                      onPressed: () {
                        mediaProvider.downloadInfoSetList.forEach((element) {
                          if (element.downloader.downloadFinished == false)
                            element.downloader.downloadFinished = true;
                        });
                        mediaProvider.downloadInfoSetList = [];
                        Navigator.pop(context);
                      }
                    ),
                    FlatButton(
                      child: Text("Cancel", style: TextStyle(
                        color: Theme.of(context).textTheme.body1.color
                      )),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ), 
                );
              },
            );
          } else {
            mediaProvider.downloadInfoSetList = [];
          }
        }
      ),
    );
  }
}