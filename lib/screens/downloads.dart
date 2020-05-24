import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal
import 'package:songtube/provider/media_provider.dart';
import 'package:songtube/ui/reusable/download_tile.dart';

class DownloadTab extends StatefulWidget {
  _DownloadTabState createState() => _DownloadTabState();
}

class _DownloadTabState extends State<DownloadTab> {

  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context, listen: true);
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
                  return Padding(
                    padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                    child: DownloadTile(
                      dataProgress: mediaProvider.downloadInfoSetList[index].downloader.dataProgress.stream,
                      progressBar: mediaProvider.downloadInfoSetList[index].downloader.progressBar.stream,
                      currentAction: mediaProvider.downloadInfoSetList[index].currentAction.stream,
                      metadata: mediaProvider.downloadInfoSetList[index].metadata,
                    ),
                  );
                },
              )
              : Container(),
            ),
          ),
        ],
      ),
    );
  }
}