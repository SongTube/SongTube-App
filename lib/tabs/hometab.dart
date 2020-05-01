import 'dart:async';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../internal/songtube_classes.dart';
import '../internal/native.dart';
import '../internal/downloader.dart';

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
        await NativeMethod.handleIntent().then((resultText) {
          _url = resultText;
        });
        if (_url == null) return;
        appdata.unloadStreams();
        await Downloader.getInfo(_url);
        setState(() => appdata.linkReady = true);
        break;
      default:
        break;
    }
  }

  @override
  bool get wantKeepAlive => true;

  TextEditingController _editingController;
  MediaMetaData metadata;
  YoutubePlayerController _playerController;

  @override
  void initState() {
    _editingController = TextEditingController();
    appdata.unloadStreams();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose(){
    this.dispose();
    appdata.dispose();
    _playerController.dispose();
  }

  void _unloadData() {
    appdata.linkReady = false;
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
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
            elevation: 0,
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
                          child: TextFormField(
                                focusNode: appdata.urlFocusNode,
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
                                  suffixIcon: AnimatedOpacity (
                                    duration: Duration(milliseconds: 200),
                                    opacity: _editingController.text == "" ? 0.0 : 1.0,
                                    child: IconButton(
                                      icon: Icon(Icons.clear,
                                      color: Theme.of(context).iconTheme.color),
                                      onPressed: () {
                                        Future.delayed(
                                          Duration(milliseconds: 50),
                                          ).then((_) {
                                            setState(() => _editingController.clear());
                                          },
                                        );
                                      }
                                    )
                                  ),
                                ),
                                onChanged: (String actualText) {
                                  setState(() => _editingController.text);
                                },
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.body1.color,
                                ),
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
                          setState(() => _editingController.text = data.text);
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
                          setState(() => _unloadData());
                          FocusScope.of(context).unfocus();
                          appdata.unloadStreams();
                          MediaMetaData result = await Downloader.getInfo(_editingController.text);
                          if (result == null) return;
                          metadata = result;
                          appdata.titleController.text = metadata.title;
                          appdata.albumController.text = metadata.album;
                          appdata.artistController.text = metadata.artist;
                          appdata.genreController.text = metadata.genre;
                          appdata.dateController.text = metadata.date;
                          appdata.diskController.text = metadata.disk;
                          appdata.trackController.text = metadata.track;
                          appdata.coverUrl = metadata.coverurl;
                          appdata.showFAB.add(true);
                          _playerController = new YoutubePlayerController(
                            initialVideoId: appdata.videoId,
                            flags: YoutubePlayerFlags(
                              autoPlay: false,
                            ),
                          );
                          _playerController.load(appdata.videoId);
                          setState(() => appdata.linkReady = true);
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
              elevation: 0,
              child: ListView(
                key: PageStorageKey("hometab"),
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  // Main Column of ListView
                  Column(
                    children: <Widget>[
                      // Youtube Mini-Player
                      AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: appdata.linkReady == true
                            ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                child: new YoutubePlayer(
                                  controller: _playerController,
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
                      ),
                      // Video Duration & Weight
                      Row(
                        children: <Widget> [
                          AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: appdata.linkReady == true
                                ? Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    appdata.audioDuration.inMinutes.remainder(60).toString().padLeft(2, '0')
                                    + " min "
                                    + appdata.audioDuration.inSeconds.remainder(60).toString().padLeft(2, '0')
                                    + " sec",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                                : Container(),                          
                          ),
                          Spacer(),
                          AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: appdata.linkReady == true
                                ? Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    "Audio: " + appdata.audioSize.toString() + "MB",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                                : Container(),
                          )
                        ]
                      ),
                      // Video Title
                      AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: appdata.linkReady == true
                            ? Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                              child: Text(
                                appdata.audioTitle.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                overflow: TextOverflow.fade,
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            )
                            : Container(),
                      ),
                      // Video Author
                      AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: appdata.linkReady == true 
                            ? Padding(
                              padding: const EdgeInsets.only(top: 5.0, bottom: 8, left: 8, right: 8),
                              child: Text(
                                appdata.audioArtist.toString(),
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.body2.color,
                                ),
                              ),
                            )
                            : Container(),
                      ),
                      // Metadata TextFields
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 200),
                        opacity: appdata.linkReady == true ? 1.0 : 0.0,
                        child: Column(
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
