// Dart
import 'dart:async';
import 'dart:ui';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// Internal
import 'package:songtube/internal/lifecycle_events.dart';
import 'package:songtube/internal/youtube/downloader.dart';
import 'package:songtube/provider/downloads_manager.dart';
import 'package:songtube/screens/settings.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

// UI
import 'package:songtube/ui/bottom_download_menu.dart';
import 'package:songtube/ui/home_screen/intro_splash.dart';
import 'package:songtube/ui/reusable/textfield_tile.dart';
import 'package:songtube/ui/reusable/searchbar.dart';

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
  Image cachedImage;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    WidgetsBinding.instance.addObserver(
      new LifecycleEventHandler(resumeCallBack: () => manager.handleIntent())
    );
    Future.delayed((Duration(milliseconds: 200)), () {
      manager.showEmptyScreenWidget = true;
    });
    return GestureDetector(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SearchBar(
              prefixIcon: Icon(Icons.https,
                color: Theme.of(context).iconTheme.color
              ),
              hintText: "URL",
              indicatorValue: manager.showLoadingBar == true ? null : 0.0,
              focusNode: manager.urlNode,
              controller: manager.urlController,
              containerColor: Theme.of(context).cardColor,
              textfieldColor: Theme.of(context).inputDecorationTheme.fillColor,
              onSearchPressed: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                manager.getMediaStreamInfo(manager.getIdFromLink());
              }
            ),
            manager.mediaStreamReady == false
            ? Expanded(
              child: IgnorePointer(
                  ignoring: manager.showEmptyScreenWidget == true ? false : true,
                  child: AnimatedOpacity(
                    opacity: manager.showEmptyScreenWidget == true ? 1.0 : 0.0,
                    duration: (Duration(milliseconds: 200)),
                    child: IntroSplash(),
                  )
                ),
            )
            : Container(),
            manager.mediaStream != null
            ? Expanded(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: manager.mediaStreamReady == true ? 1.0 : 0.0,
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
                                child: manager.openWebviewPlayer ? new YoutubePlayer(
                                  key: _playerKey,
                                  controller: YoutubePlayerController(
                                    initialVideoId: manager.getIdFromLink(),
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
                                        image: NetworkImage(manager.mediaStream.videoDetails.thumbnailSet.highResUrl),
                                        placeholder: MemoryImage(kTransparentImage),
                                        fit: BoxFit.fitWidth,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          manager.openWebviewPlayer = true;
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
                                    manager.mediaStream.videoDetails.duration.inMinutes.remainder(60).toString().padLeft(2, '0') + " min "
                                    +  manager.mediaStream.videoDetails.duration.inSeconds.remainder(60).toString().padLeft(2, '0') + " sec",
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
                                    "Audio: " + (manager.mediaStream.audio.last.size * 0.000001).toStringAsFixed(2).toString() + "MB",
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
                                manager.titleController.text,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).textTheme.bodyText1.color
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
                                manager.artistController.text,
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyText1.color
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
                                  TextFieldTile(
                                    focusNode: manager.titleNode,
                                    textController: manager.titleController,
                                    inputType: TextInputType.text,
                                    labelText: "Title",
                                    icon: Icons.title,
                                  ),
                                  SizedBox(height: 12),
                                  // Album & Artist TextField Row
                                  Row(
                                    children: <Widget>[
                                      // Album TextField
                                      Expanded(
                                        child: TextFieldTile(
                                          focusNode: manager.albumNode,
                                          textController: manager.albumController,
                                          inputType: TextInputType.text,
                                          labelText: "Album",
                                          icon: Icons.library_music,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      // Artist TextField
                                      Expanded(
                                        child: TextFieldTile(
                                          focusNode: manager.artistNode,
                                          textController: manager.artistController,
                                          inputType: TextInputType.text,
                                          labelText: "Artist",
                                          icon: Icons.person,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  // Gender & Date TextField Row
                                  Row(
                                    children: <Widget>[
                                      // Gender TextField
                                      Expanded(
                                        child: TextFieldTile(
                                          focusNode: manager.genreNode,
                                          textController: manager.genreController,
                                          inputType: TextInputType.text,
                                          labelText: "Genre",
                                          icon: Icons.book,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      // Date TextField
                                      Expanded(
                                        child: TextFieldTile(
                                          focusNode: manager.dateNode,
                                          textController: manager.dateController,
                                          inputType: TextInputType.datetime,
                                          labelText: "Date",
                                          icon: Icons.date_range,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  // Disk & Track TextField Row
                                  Row(
                                    children: <Widget>[
                                      // Disk TextField
                                      Expanded(
                                        child: TextFieldTile(
                                          focusNode: manager.discNode,
                                          textController: manager.discController,
                                          inputType: TextInputType.number,
                                          labelText: "Disc",
                                          icon: Icons.album,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      // Track TextField
                                      Expanded(
                                        child: TextFieldTile(
                                          focusNode: manager.trackNode,
                                          textController: manager.trackController,
                                          inputType: TextInputType.number,
                                          labelText: "Track",
                                          icon: Icons.music_note,
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
          ignoring: manager.showFloatingActionButtom ? false : true,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: manager.showFloatingActionButtom ? 1.0 : 0.0,
            child: FloatingActionButton(
              child: Icon(Icons.file_download),
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              onPressed: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                List<youtube.VideoStreamInfo> videoList = Downloader.extractVideoStreams(manager.mediaStream);
                List<String> response = await showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),
                  context: context,
                  builder: (context) {
                    return CustomDownloadMenu(
                      videoList: videoList,
                      onSettingsPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Theme.of(context).canvasColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SettingsTab(),
                              )
                            );
                          }
                        );
                      },
                    );
                  }
                );
                if (response == null) return;
                manager.handleDownload(context, response);
              }
            ),
          ),
        ),
      ),
    );
  }
}
