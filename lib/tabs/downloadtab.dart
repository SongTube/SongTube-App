import 'package:flutter/material.dart';
import '../internal/songtube_classes.dart';
import '../ui/ui_elements.dart';

class DownloadTab extends StatefulWidget {
  @override
  _DownloadTabState createState() => _DownloadTabState();
}

class _DownloadTabState extends State<DownloadTab> with AutomaticKeepAliveClientMixin<DownloadTab> {

  @override
  bool get wantKeepAlive => true;

  void initState() {
    super.initState();
    downloadListController.stream.listen((onData){
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 4
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: kToolbarHeight,
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).tabBarTheme.labelColor
                      ),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.videocam),
                            onPressed: (){},
                          ),
                          Text("Videos    ")
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.music_note),
                      onPressed: (){},
                    ),
                    IconButton(
                      icon: Icon(Icons.history),
                      onPressed: (){},
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () async {
                        if (downloadList.length >= 2 ) {
                          await showCustomDialog(context);
                        } else {
                          downloadList.forEach((object){
                            if (!object.dataProgress.isClosed) object.dataProgress.close();
                          });
                          setState(() => downloadList = []);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          duration: Duration(milliseconds: 400),
          opacity: downloadList.length == 0 ? 1.0 : 0.0,
          child: downloadList.length == 0
          ? Container(
            padding: EdgeInsets.only(top: 8),
            height: kToolbarHeight,
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
              opacity: downloadList.length > 0 ? 1.0 : 0.0,
              child: downloadList.length > 0 
              ? ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: downloadList.length,
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
                                    downloadList[index].metadata.coverurl,
                                    height: 100,
                                    width: 160,
                                    fit: BoxFit.fill
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
                                          downloadList[index].metadata.title.toString(),
                                          overflow: TextOverflow.clip,
                                          maxLines: 2,
                                          softWrap: true,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          downloadList[index].metadata.artist.toString(),
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
                                              downloadList[index].dataProgress.close();
                                              setState(() => downloadList.removeAt(index));
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
                            child: StreamBuilder<Object>(
                              stream: downloadList[index].downloadProgress.stream,
                              builder: (context, snapshot) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
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
                                StreamBuilder<Object>(
                                  stream: downloadList[index].dataProgress.stream,
                                  builder: (context, snapshot) {
                                    return snapshot.hasData == true
                                    ? Text(
                                      "Size: " + snapshot.data.toString() + "MB",
                                      style: TextStyle(
                                        fontSize: 12
                                      ),
                                    )
                                    : Text(
                                      "Size...",
                                      style: TextStyle(
                                        fontSize: 12
                                      ),
                                    );
                                  }
                                ),
                                Spacer(),
                                StreamBuilder<Object>(
                                  stream: downloadList[index].currentAction.stream,
                                  builder: (context, snapshot) {
                                    return snapshot.hasData == true
                                    ? Text(
                                      snapshot.data.toString(),
                                      style: TextStyle(
                                        fontSize: 12
                                      ),
                                    )
                                    : Text(
                                      "Starting...",
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
                  )
                );
              },
                )
              : Container(),
            ),
          ),
      ],
    );
  }
}