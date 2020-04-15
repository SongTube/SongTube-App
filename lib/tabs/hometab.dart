import 'dart:async';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../internal/songtube_classes.dart';
import '../internal/native.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin<HomeTab>, WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state){
      case AppLifecycleState.resumed:
        String _url;
        await method.handleIntent().then((resultText) {
          _url = resultText;
        });
        if (_url == null) return;
        setState(() { _showLoading = true; } );
        appdata.unloadStreams();
        await downloader.getInfo(_url);
        setState(() { _showLoading = false; } );
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  bool get wantKeepAlive => true;

  TextEditingController _editingController;
  StreamController _editingStream;
  bool _showLoading = false;

  @override
  void initState() {
    _editingController = TextEditingController();
    _editingStream = StreamController();
    _editingStream.add("");
    appdata.unloadStreams();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose(){
    this.dispose();
    appdata.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView(
          key: PageStorageKey("hometab"),
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            // Main Column of ListView
            Column(
              children: <Widget>[
                // SeachBar & ClipBoardPaste Icon & Seach Icon
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: StreamBuilder<Object>(
                            stream: _editingStream.stream,
                            builder: (context, snapshot) {
                              // Seach Bar
                              return TextFormField(
                                controller: _editingController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 15),
                                  prefixIcon: Icon(Icons.https,
                                    color: Theme.of(context).iconTheme.color
                                  ),
                                  filled: true,
                                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                  border: InputBorder.none,
                                  hintText: "URL",
                                  suffixIcon: snapshot.data == ""
                                  ? null
                                  : IconButton(
                                      icon: Icon(Icons.clear,
                                      color: Theme.of(context).iconTheme.color),
                                      onPressed: () {
                                        _editingController.text = "";
                                      }
                                    )
                                ),
                                onChanged: (value) {
                                  _editingStream.add(value);
                                },
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.body1.color,
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                    ),
                    // ClipBoardPaste Icon
                    IconButton(
                      icon: Icon(Icons.content_paste),
                      onPressed: () async {
                        ClipboardData data = await Clipboard.getData('text/plain');
                        _editingController.text = data.text;
                        _editingStream.add(" ");
                      },
                    ),
                    // Search Icon
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          appdata.unloadStreams();
                          setState(() {
                            _showLoading = true;
                          });
                          await downloader.getInfo(_editingController.text);
                          setState(() {
                            _showLoading = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                // Progress Bar
                StreamBuilder<Object>(
                  stream: appdata.progressController.stream,
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: LinearProgressIndicator(
                          value: snapshot.data,
                          backgroundColor: Theme.of(context).inputDecorationTheme.fillColor,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                        ),
                      ),
                    );
                  }
                ),
                // Video Duration & Is loading indicator & Weight
                Row(
                  children: <Widget> [
                    StreamBuilder(
                      stream: appdata.audioDuration.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // Video Duration
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              snapshot.data.inMinutes.remainder(60).toString().padLeft(2, '0')
                              + " min "
                              + snapshot.data.inSeconds.remainder(60).toString().padLeft(2, '0')
                              + " sec",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    Spacer(),
                    // Is loading indicator
                    _showLoading == true ? Text("Loading link...") : Container(),
                    Spacer(),
                    StreamBuilder(
                      stream: appdata.audioSize.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          double size = double.parse(((snapshot.data / 1024) / 1024).toStringAsFixed(3));
                          // Video Weight
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              size.toString() + " KB",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ]
                ),
                // Youtube Mini-Player
                StreamBuilder(
                  stream: appdata.videoId.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: YoutubePlayer(
                            controller: YoutubePlayerController(
                              initialVideoId: snapshot.data,
                              flags: YoutubePlayerFlags(
                                autoPlay: false,
                              ),
                            ),
                            progressColors: ProgressBarColors(
                              playedColor: Colors.red,
                              bufferedColor: Colors.white70,
                              backgroundColor: Colors.transparent,
                              handleColor: Colors.redAccent,
                            ),
                            progressIndicatorColor: Colors.redAccent,
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }
                ),
                // Video Title
                StreamBuilder(
                  stream: appdata.audioTitle.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                        child: Text(
                          snapshot.data.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                // Video Author
                StreamBuilder(
                  stream: appdata.audioArtist.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 8, left: 8, right: 8),
                        child: Text(
                          snapshot.data.toString(),
                          style: TextStyle(
                            color: Theme.of(context).inputDecorationTheme.fillColor,
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
