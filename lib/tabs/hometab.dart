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
        appdata.unloadStreams();
        await downloader.getInfo(_url);
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
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                // SeachBar & ClipBoardPaste Icon & Seach Icon
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          left: 8,
                          right: 8,
                          bottom: 3,
                        ),
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
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 3,
                        ),
                      child: IconButton(
                        icon: Icon(Icons.content_paste),
                        onPressed: () async {
                          ClipboardData data = await Clipboard.getData('text/plain');
                          _editingController.text = data.text;
                          _editingStream.add(" ");
                        },
                      ),
                    ),
                    // Search Icon
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8,
                          right: 10,
                          bottom: 3,
                        ),
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          appdata.unloadStreams();
                          await downloader.getInfo(_editingController.text);
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
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 3
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: SizedBox(
                          height: 2,
                          child: LinearProgressIndicator(
                            value: snapshot.data,
                            backgroundColor: Theme.of(context).cardColor,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 4,
            ),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
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
                      // Youtube Mini-Player
                      StreamBuilder(
                        stream: appdata.videoId.stream,
                        builder: (context, snapshot) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: snapshot.hasData 
                            ? Padding(
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
                            )
                            : Container(),
                          );
                        }
                      ),
                      // Video Duration & Weight
                      Row(
                        children: <Widget> [
                          StreamBuilder(
                            stream: appdata.audioDuration.stream,
                            builder: (context, snapshot) {
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: snapshot.hasData 
                                ? Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    snapshot.data.inMinutes.remainder(60).toString().padLeft(2, '0')
                                    + " min "
                                    + snapshot.data.inSeconds.remainder(60).toString().padLeft(2, '0')
                                    + " sec",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                                : Container(),
                              );
                            },
                          ),
                          Spacer(),
                          StreamBuilder(
                            stream: appdata.audioSize.stream,
                            builder: (context, snapshot) {
                              double size;
                              if (snapshot.hasData) {
                                size = double.parse(((snapshot.data / 1024) / 1024).toStringAsFixed(3));
                              }
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: snapshot.hasData 
                                ? Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    size.toString() + " KB",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                                : Container(),
                              );
                            },
                          )
                        ]
                      ),
                      // Video Title
                      StreamBuilder(
                        stream: appdata.audioTitle.stream,
                        builder: (context, snapshot) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: snapshot.hasData 
                            ? Padding(
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
                            )
                            : Container(),
                          );
                        },
                      ),
                      // Video Author
                      StreamBuilder(
                        stream: appdata.audioArtist.stream,
                        builder: (context, snapshot) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: snapshot.hasData 
                            ? Padding(
                              padding: const EdgeInsets.only(top: 5.0, bottom: 8, left: 8, right: 8),
                              child: Text(
                                snapshot.data.toString(),
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.body2.color,
                                ),
                              ),
                            )
                            : Container(),
                          );
                        },
                      ),
                      // Metadata TextFields
                      StreamBuilder<Object>(
                        stream: appdata.linkReady.stream,
                        builder: (context, snapshot) {
                          // All Metadata TextFields goes under this
                          if (snapshot.hasData) {
                            appdata.titleController.text = downloader.defaultMetaData.title;
                            appdata.albumController.text = downloader.defaultMetaData.album;
                            appdata.artistController.text = downloader.defaultMetaData.artist;
                            appdata.genreController.text = downloader.defaultMetaData.genre;
                            appdata.dateController.text = downloader.defaultMetaData.date.toString();
                            appdata.diskController.text = downloader.defaultMetaData.disk;
                            appdata.trackController.text = downloader.defaultMetaData.track;
                          }
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: snapshot.hasData
                            ? Column(
                              children: <Widget>[
                                // Title TextField
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    left: 12,
                                    right: 12,
                                    bottom: 8
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    child: TextFormField(
                                      focusNode: appdata.titleFocusNode,
                                      controller: appdata.titleController,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.title,
                                          color: Theme.of(context).iconTheme.color
                                        ),
                                        filled: true,
                                        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                        border: InputBorder.none,
                                        labelText: "Title",
                                      ),
                                      style: TextStyle(
                                        color: Theme.of(context).textTheme.body1.color,
                                        fontSize: 14
                                      ),
                                    ),
                                  ),
                                ),
                                // Album & Artist TextField Row
                                Row(
                                  children: <Widget>[
                                    // Album TextField
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12,
                                          right: 4,
                                          bottom: 8
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          child: TextFormField(
                                            focusNode: appdata.albumFocusNode,
                                            controller: appdata.albumController,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.library_music,
                                                color: Theme.of(context).iconTheme.color
                                              ),
                                              filled: true,
                                              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                              border: InputBorder.none,
                                              labelText: "Album",
                                              focusColor: Colors.redAccent,
                                            ),
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme.body1.color,
                                              fontSize: 14
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Artist TextField
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                          right: 12,
                                          bottom: 8
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          child: TextFormField(
                                            focusNode: appdata.artistFocusNode,
                                            controller: appdata.artistController,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.person,
                                                color: Theme.of(context).iconTheme.color
                                              ),
                                              filled: true,
                                              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                              border: InputBorder.none,
                                              labelText: "Artist",
                                            ),
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme.body1.color,
                                              fontSize: 14
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Gender & Date TextField Row
                                Row(
                                  children: <Widget>[
                                    // Gender TextField
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12,
                                          right: 4,
                                          bottom: 8
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          child: TextFormField(
                                            focusNode: appdata.genreFocusNode,
                                            controller: appdata.genreController,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.book,
                                                color: Theme.of(context).iconTheme.color
                                              ),
                                              filled: true,                                                                                                      
                                              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                              border: InputBorder.none,
                                              labelText: "Genre",
                                            ),
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme.body1.color,
                                              fontSize: 14
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Date TextField
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                          right: 12,
                                          bottom: 8
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          child: TextFormField(
                                            focusNode: appdata.dateFocusNode,
                                            controller: appdata.dateController,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.date_range,
                                                color: Theme.of(context).iconTheme.color
                                              ),
                                              filled: true,
                                              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                              border: InputBorder.none,
                                              labelText: "Date",
                                              focusColor: Colors.redAccent,
                                            ),
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme.body1.color,
                                              fontSize: 14
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Disk & Track TextField Row
                                Row(
                                  children: <Widget>[
                                    // Disk TextField
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12,
                                          right: 4,
                                          bottom: 12
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          child: TextFormField(
                                            focusNode: appdata.diskFocusNode,
                                            controller: appdata.diskController,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.album,
                                                color: Theme.of(context).iconTheme.color
                                              ),
                                              filled: true,                                                                                                      
                                              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                              border: InputBorder.none,
                                              labelText: "Disk",
                                            ),
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme.body1.color,
                                              fontSize: 14
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Track TextField
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                          right: 12,
                                          bottom: 12
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          child: TextFormField(
                                            focusNode: appdata.trackFocusNode,
                                            controller: appdata.trackController,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.music_note,
                                                color: Theme.of(context).iconTheme.color
                                              ),
                                              filled: true,
                                              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                              border: InputBorder.none,
                                              labelText: "Track",
                                              focusColor: Colors.redAccent,
                                            ),
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme.body1.color,
                                              fontSize: 14
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                            : Container(),
                          );
                        }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
