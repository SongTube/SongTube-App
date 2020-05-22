import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal
import 'package:songtube/provider/media_provider.dart';

// UI
import 'package:songtube/ui/ui_elements.dart';

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
                    child: Card(
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
                                  child: Container(
                                    height: 100,
                                    width: 160,
                                    child: Image.network(
                                      mediaProvider.downloadInfoSetList[index].metadata.coverurl,
                                      height: 100,
                                      width: 160,
                                      fit: BoxFit.fill,
                                      filterQuality: FilterQuality.high,
                                    ),
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
                                            mediaProvider.downloadInfoSetList[index].metadata.title.toString(),
                                            overflow: TextOverflow.clip,
                                            maxLines: 2,
                                            softWrap: true,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            mediaProvider.downloadInfoSetList[index].metadata.artist.toString(),
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
                                              onPressed: (){},
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.clear, size: 18),
                                              onPressed: (){
                                                mediaProvider.downloadInfoSetList[index].downloader.dataProgress.close();
                                                mediaProvider.downloadInfoSetList[index].currentAction.close();
                                                mediaProvider.downloadInfoSetList[index].downloader.progressBar.close();
                                                if (mediaProvider.downloadInfoSetList.length == 1) {
                                                  mediaProvider.downloadInfoSetList = [];
                                                } else {
                                                  mediaProvider.removeItemFromDownloadList(index);
                                                }
                                              },
                                            )
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
                                stream: mediaProvider.downloadInfoSetList[index].downloader.progressBar.stream,
                                builder: (context, snapshot) {
                                  if (mediaProvider.downloadInfoSetList[index].downloader.progressBar.isClosed){
                                    return LinearProgressIndicator(
                                      value: 1.0,
                                      backgroundColor: Theme.of(context).cardColor,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                                    );
                                  } else {
                                    return LinearProgressIndicator(
                                      value: snapshot.data,
                                      backgroundColor: Theme.of(context).cardColor,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                                    );
                                  }
                                }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                children: <Widget> [
                                  StreamBuilder<String>(
                                    stream: mediaProvider.downloadInfoSetList[index].downloader.dataProgress.stream,
                                    builder: (context, snapshot) {
                                      if (mediaProvider.downloadInfoSetList[index].downloader.dataProgress.isClosed){
                                        return Text(
                                          "Size: " + mediaProvider.downloadInfoSetList[index].downloader.fileSize.toString() + "MB",
                                          style: TextStyle(
                                            fontSize: 12
                                          ),
                                        );
                                      } else {
                                        return snapshot.data == null 
                                        ? Container()
                                        : Text(
                                          "Size: " + snapshot.data + "MB",
                                          style: TextStyle(
                                            fontSize: 12
                                          ),
                                        );
                                      }
                                    }
                                  ),
                                  Spacer(),
                                  StreamBuilder<String>(
                                    stream: mediaProvider.downloadInfoSetList[index].currentAction.stream,
                                    builder: (context, snapshot) {
                                      if (mediaProvider.downloadInfoSetList[index].currentAction.isClosed){
                                        return Text(
                                          "Done",
                                          style: TextStyle(
                                            fontSize: 12
                                          ),
                                        );
                                      } else {
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
                                    }
                                  ),
                                ],
                              ),
                            ),
                          ]
                        ),
                      ),
                    )
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