// Flutter
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Internal
import 'package:songtube/provider/media_provider.dart';
import 'package:songtube/provider/player_provider.dart';
import 'package:songtube/internal/models/downloadinfoset.dart';
import 'package:songtube/internal/models/enums.dart';

// Packages
import 'package:provider/provider.dart';

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
          if (mediaProvider.downloadInfoSetList.isEmpty)
          Expanded(
            child: Center(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 400),
                opacity: mediaProvider.downloadInfoSetList.isEmpty ? 1.0 : 0.0,
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width*0.6,
                  child: Card(
                    color: Theme.of(context).inputDecorationTheme.fillColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(MdiIcons.cloudDownload, size: 100, color: Colors.redAccent),
                          Text(
                            "No downloads yet!",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 4),
                          Text("All your downloads will be shown here", textAlign: TextAlign.center)
                        ],
                      ),
                    )
                  ),
                )
              ),
            ),
          ),
          if (mediaProvider.downloadInfoSetList.isNotEmpty)
          Expanded(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: mediaProvider.downloadInfoSetList.isNotEmpty ? 1.0 : 0.0,
              child: ListView.builder(
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