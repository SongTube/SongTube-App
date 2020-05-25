// Dart
import 'dart:async';
import 'dart:ui';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Internal
import 'package:songtube/internal/focusnodes.dart';
import 'package:songtube/internal/lifecycle_events.dart';
import 'package:songtube/internal/models/downloadinfoset.dart';
import 'package:songtube/internal/models/enums.dart';
import 'package:songtube/internal/models/metadata.dart';
import 'package:songtube/internal/native.dart';
import 'package:songtube/internal/textcontrollers.dart';
import 'package:songtube/internal/youtube/infoparser.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/provider/media_provider.dart';
import 'package:songtube/ui/bottom_download_menu.dart';
import 'package:songtube/ui/searchbar.dart';
import 'package:songtube/ui/snackbar.dart';
import 'package:songtube/internal/download_manager.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

StreamController<String> videoUrl = new StreamController.broadcast();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  // Variables
  Key _playerKey;
  MediaMetaData _metadata;
  youtube.MediaStreamInfoSet _mediaStream;
  String _videoId;
  Image cachedImage;
  bool _moveSearchProgress;
  bool _linkReady;
  bool _showFAB;
  bool _openPlayer;
  bool _showTooltip = false;

  // Controllers
  FocusNodes _focusNodes;
  TextControllers _textControllers;

  @override
  void initState() {
    _linkReady = false;
    _showFAB = false;
    _openPlayer = false;
    videoUrl.stream.listen((newUrl) {
      if (_textControllers.titleController.text != newUrl) {
        _textControllers.urlController.text = newUrl;
        getVideoInfo();
      }
    });
    super.initState();
    WidgetsBinding.instance.addObserver(
      new LifecycleEventHandler(resumeCallBack: () => handleIntent())
    );
    Future.delayed((Duration(milliseconds: 200)), () {
      setState(() => _showTooltip = true);
    });
  }

  Future<void> handleIntent() async {
    String _url; String _id;
    await NativeMethod.handleIntent().then((resultText) => _url = resultText);
    if (_url == null) return;
    _id = YoutubeInfo.getLinkID(_url);
    if (_id == null) return;
    setState(() {
      _linkReady = false;
      _showFAB = false;
      _moveSearchProgress = true;
      _showTooltip = false;
    });
    youtube.MediaStreamInfoSet result = await YoutubeInfo.getVideoInfo(_id);
    if (result == null) {
      setState(() => _moveSearchProgress = false);
      return;
    }
    setState(() {
      _videoId = _id;
      _mediaStream = result;
    });
    updateInfo();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _moveSearchProgress = false;
        _showFAB = true;
        _linkReady = true;
      });
    });
  }

  void getVideoInfo([context]) async {
    setState(() {
      _linkReady = false;
      _showFAB = false;
      _moveSearchProgress = true;
      _openPlayer = false;
      _showTooltip = false;
    });
    if (context != null) FocusScope.of(context).unfocus();
    appSnack.gettingLinkInfo();
    String _id = YoutubeInfo.getLinkID(_textControllers.urlController.text);
    if (_id == null) {
      setState(() => _moveSearchProgress = false);
      appSnack.invalidID();
      return;
    }
    youtube.MediaStreamInfoSet result = await YoutubeInfo.getVideoInfo(_id);
    if (result == null) {
      setState(() => _moveSearchProgress = false);
      return;
    }
    setState(() {
      _videoId = _id;
      _mediaStream = result;
    });
    updateInfo();
    setState(() {
      _moveSearchProgress = false;
      _linkReady = true;
      _showFAB = true;
    });
  }

  void updateInfo() {
    _metadata = MediaMetaData(
      _mediaStream.videoDetails.title, "Youtube",
      _mediaStream.videoDetails.author, "Any",
      _mediaStream.videoDetails.thumbnailSet.mediumResUrl,
      _mediaStream.videoDetails.uploadDate.toString(),
      "Any", "Any"
    );
    _textControllers.titleController.text = _metadata.title;
    _textControllers.albumController.text = _metadata.album;
    _textControllers.artistController.text = _metadata.artist;
    _textControllers.genreController.text = _metadata.genre;
    _textControllers.dateController.text = _metadata.date;
    _textControllers.diskController.text = _metadata.disk;
    _textControllers.trackController.text = _metadata.track;
    _metadata.coverurl = _metadata.coverurl;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _focusNodes = Provider.of<FocusNodes>(context);
    _textControllers = Provider.of<TextControllers>(context);
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SearchBar(
            indicatorValue: _moveSearchProgress == true ? null : 0.0,
            focusNode: _focusNodes.urlFocusNode,
            controller: _textControllers.urlController,
            containerColor: Theme.of(context).cardColor,
            textfieldColor: Theme.of(context).inputDecorationTheme.fillColor,
            onSearchPressed: () => getVideoInfo(context),
          ),
          _linkReady == false
          ? Expanded(
            child: IgnorePointer(
                ignoring: _showTooltip == true ? false : true,
                child: AnimatedOpacity(
                  opacity: _showTooltip == true ? 1.0 : 0.0,
                  duration: (Duration(milliseconds: 200)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AnimatedOpacity(
                              opacity: _showTooltip == true ? 1.0 : 0.0,
                              duration: (Duration(milliseconds: 300)),
                              child: Icon(
                                MdiIcons.rocketLaunchOutline,
                                size: 150,
                                color: Colors.redAccent
                              ),
                            ),
                            SizedBox(height: 4),
                            AnimatedOpacity(
                              opacity: _showTooltip == true ? 1.0 : 0.0,
                              duration: (Duration(milliseconds: 400)),
                              child: Text(
                                "Nothing here yet!",
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.body1.color,
                                  fontWeight: FontWeight.w600
                                )
                              ),
                            ),
                            SizedBox(height: 4),
                            AnimatedOpacity(
                              opacity: _showTooltip == true ? 1.0 : 0.0,
                              duration: (Duration(milliseconds: 500)),
                              child: Text(
                                "Paste a link into the app or search for videos on Youtube!",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () {
                                appData.screenIndex = 2;
                              },
                              child: AnimatedOpacity(
                                opacity: _showTooltip == true ? 1.0 : 0.0,
                                duration: (Duration(milliseconds: 600)),
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(MdiIcons.youtube, color: Colors.white),
                                      Text(
                                        "Explore Youtube",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 50)
                    ],
                  ),
                )
              ),
          )
          : Container(),
          _mediaStream != null
          ? Expanded(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _linkReady == true ? 1.0 : 0.0,
              child: new ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget> [
                  // --------------
                  // Video Content
                  // --------------
                  // Mini-Player
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: <Widget>[
                          // Mini-Player
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              child: _openPlayer ? new YoutubePlayer(
                                key: _playerKey,
                                controller: YoutubePlayerController(
                                  initialVideoId: _videoId,
                                  flags: YoutubePlayerFlags(
                                    autoPlay: true,
                                  ),
                                ),
                                progressColors: ProgressBarColors(
                                  playedColor: Colors.red,
                                  bufferedColor: Colors.white70,
                                  backgroundColor: Colors.transparent,
                                  handleColor: Colors.redAccent,
                                ),
                                progressIndicatorColor: Colors.redAccent,
                              )
                              : Container(
                                width: MediaQuery.of(context).size.width,
                                height: 208,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    FadeInImage(
                                      fadeInDuration: Duration(milliseconds: 300),
                                      image: NetworkImage(_mediaStream.videoDetails.thumbnailSet.highResUrl),
                                      placeholder: MemoryImage(kTransparentImage),
                                      fit: BoxFit.fitWidth,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _openPlayer = true;
                                        });
                                      },
                                      child: Center(
                                        child: Icon(Icons.play_arrow, size: 90, color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                              ),
                            ),
                          ),
                          // Video Duration and Weight
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                child: Text(
                                  _mediaStream.videoDetails.duration.inMinutes.remainder(60).toString().padLeft(2, '0') + " min "
                                  +  _mediaStream.videoDetails.duration.inSeconds.remainder(60).toString().padLeft(2, '0') + " sec",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).iconTheme.color
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                child: Text(
                                  "Audio: " + (_mediaStream.audio.last.size * 0.000001).toStringAsFixed(2).toString() + "MB",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).iconTheme.color
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Video Title
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 5),
                            child: Text(
                              _metadata.title.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).textTheme.body1.color
                              ),
                              overflow: TextOverflow.fade,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // Video Author
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                            child: Text(
                              _metadata.artist.toString(),
                              style: TextStyle(
                                color: Theme.of(context).textTheme.body1.color
                              ),
                            ),
                          ),
                          // --------------
                          // Video Content
                          // --------------
                          //
                          // --------------
                          // Metadata
                          // --------------
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                // Title TextField
                                TextFormField(
                                  cursorColor: Colors.redAccent,
                                  focusNode: _focusNodes.titleFocusNode,
                                  controller: _textControllers.titleController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.title,
                                      color: Theme.of(context).iconTheme.color
                                    ),
                                    filled: true,
                                    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                    border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        width: 0, 
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    labelText: "Title",
                                  ),
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.body1.color,
                                    fontSize: 14
                                  ),
                                ),
                                SizedBox(height: 12),
                                // Album & Artist TextField Row
                                Row(
                                  children: <Widget>[
                                    // Album TextField
                                    Flexible(
                                      child: TextFormField(
                                        cursorColor: Colors.redAccent,
                                        focusNode: _focusNodes.albumFocusNode,
                                        controller: _textControllers.albumController,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.library_music,
                                            color: Theme.of(context).iconTheme.color
                                          ),
                                          filled: true,
                                          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                          border: UnderlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              width: 0, 
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          labelText: "Album",
                                          focusColor: Colors.redAccent,
                                        ),
                                        style: TextStyle(
                                          color: Theme.of(context).textTheme.body1.color,
                                          fontSize: 14
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    // Artist TextField
                                    Flexible(
                                      child: TextFormField(
                                        cursorColor: Colors.redAccent,
                                        focusNode: _focusNodes.artistFocusNode,
                                        controller: _textControllers.artistController,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person,
                                            color: Theme.of(context).iconTheme.color
                                          ),
                                          filled: true,
                                          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                          border: UnderlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              width: 0, 
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          labelText: "Artist",
                                        ),
                                        style: TextStyle(
                                          color: Theme.of(context).textTheme.body1.color,
                                          fontSize: 14
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                // Gender & Date TextField Row
                                Row(
                                  children: <Widget>[
                                    // Gender TextField
                                    Flexible(
                                      child: TextFormField(
                                        cursorColor: Colors.redAccent,
                                        focusNode: _focusNodes.genreFocusNode,
                                        controller: _textControllers.genreController,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.book,
                                            color: Theme.of(context).iconTheme.color
                                          ),
                                          filled: true,                                                                                                      
                                          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                          border: UnderlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              width: 0, 
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          labelText: "Genre",
                                        ),
                                        style: TextStyle(
                                          color: Theme.of(context).textTheme.body1.color,
                                          fontSize: 14
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    // Date TextField
                                    Flexible(
                                      child: TextFormField(
                                        cursorColor: Colors.redAccent,
                                        focusNode: _focusNodes.dateFocusNode,
                                        controller: _textControllers.dateController,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.date_range,
                                            color: Theme.of(context).iconTheme.color
                                          ),
                                          filled: true,
                                          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                          border: UnderlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              width: 0, 
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          labelText: "Date",
                                          focusColor: Colors.redAccent,
                                        ),
                                        style: TextStyle(
                                          color: Theme.of(context).textTheme.body1.color,
                                          fontSize: 14
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                // Disk & Track TextField Row
                                Row(
                                  children: <Widget>[
                                    // Disk TextField
                                    Flexible(
                                      child: TextFormField(
                                        cursorColor: Colors.redAccent,
                                        focusNode: _focusNodes.diskFocusNode,
                                        controller: _textControllers.diskController,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.album,
                                            color: Theme.of(context).iconTheme.color
                                          ),
                                          filled: true,                                                                                                      
                                          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                          border: UnderlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              width: 0, 
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          labelText: "Disk",
                                        ),
                                        style: TextStyle(
                                          color: Theme.of(context).textTheme.body1.color,
                                          fontSize: 14
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    // Track TextField
                                    Flexible(
                                      child: TextFormField(
                                        cursorColor: Colors.redAccent,
                                        focusNode: _focusNodes.trackFocusNode,
                                        controller: _textControllers.trackController,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.music_note,
                                            color: Theme.of(context).iconTheme.color
                                          ),
                                          filled: true,
                                          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                          border: UnderlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              width: 0, 
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          labelText: "Track",
                                          focusColor: Colors.redAccent,
                                        ),
                                        style: TextStyle(
                                          color: Theme.of(context).textTheme.body1.color,
                                          fontSize: 14
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                          // --------------
                          // Metadata
                          // --------------
                        ],
                      ),
                    ),
                  ),
                ]
              ),
            ),
          )
        : Container(),
      ],
      ),
      floatingActionButton: IgnorePointer(
        ignoring: _showFAB == false ? true : false,
        child: AnimatedOpacity( 
          duration: Duration(milliseconds: 300),
          opacity: _showFAB == true ? 1.0 : 0.0,
          child: FloatingActionButton(
            child: Icon(Icons.file_download),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            onPressed: () async {
              _focusNodes.unfocusAll();
              List<String> response = await showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
                context: context,
                builder: (context) {
                  return CustomDownloadMenu(
                    mediaStream: _mediaStream,
                  );
                }
              );
              if (response == null) return;
              MediaMetaData metadata = new MediaMetaData(
                _textControllers.titleController.text,
                _textControllers.albumController.text,
                _textControllers.artistController.text,
                _textControllers.genreController.text,
                _mediaStream.videoDetails.thumbnailSet.highResUrl,
                _textControllers.dateController.text,
                _textControllers.diskController.text,
                _textControllers.trackController.text,
              );
              DownloadType downloadType;
              int videoIndex;
              bool enableConvertion;
              switch (response[0]) {
                case "Audio":
                  downloadType = DownloadType.audio;
                  enableConvertion = true;
                  break;
                case "Video":
                  downloadType = DownloadType.video;
                  videoIndex = int.parse(response[1]);
                  enableConvertion = false;
                  break;
              }
              StreamController<String> currentAction = new StreamController.broadcast();
              DownloadInfoSet infoset = new DownloadInfoSet(
                currentAction: currentAction,
                mediaStream: _mediaStream,
                metadata: metadata,
                downloadType: downloadType,
                videoIndex: videoIndex
              );
              DownloadManager _manager = new DownloadManager(
                enableConvertion: enableConvertion,
                infoset: infoset
              );
              mediaProvider.addItemToDownloadList(infoset);
              appData.screenIndex = 1;
              _manager.handleDownload();
            }
          ),
        ),
      ),
    );
  }
}
