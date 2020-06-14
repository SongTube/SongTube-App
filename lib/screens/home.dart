// Dart
import 'dart:async';
import 'dart:ui';

// Flutter
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Internal
import 'package:songtube/internal/lifecycle_events.dart';
import 'package:songtube/internal/youtube/downloader.dart';
import 'package:songtube/provider/downloads_manager.dart';
import 'package:songtube/screens/settings.dart';
import 'package:songtube/ui/home_screen/icontile.dart';
import 'package:url_launcher/url_launcher.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

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
    return GestureDetector(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            manager.mediaStreamReady == false
            ? Expanded(
              child: IgnorePointer(
                  ignoring: manager.showEmptyScreenWidget == true ? false : true,
                  child: AnimatedOpacity(
                    opacity: manager.showEmptyScreenWidget == true ? 1.0 : 0.0,
                    duration: (Duration(milliseconds: 200)),
                    child: Center(child: IntroSplash()),
                  )
                ),
            )
            : Expanded(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: manager.mediaStreamReady == true ? 1.0 : 0.0,
                child: new ListView(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  children: <Widget> [
                    // --------------
                    // Video Content
                    // --------------
                    // Mini-Player
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                      child: Column(
                        children: <Widget>[
                          // Mini-Player
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
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
                                        setState(() => manager.openWebviewPlayer = true);
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
                                padding: EdgeInsets.only(left: 16, right: 16, bottom: 6),
                                child: Text(
                                  manager.mediaStream.videoDetails.duration.inMinutes.remainder(60).toString().padLeft(2, '0') + " min "
                                  +  manager.mediaStream.videoDetails.duration.inSeconds.remainder(60).toString().padLeft(2, '0') + " sec",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16, bottom: 6),
                                child: Text(
                                  "Audio: " + (manager.mediaStream.audio.last.size * 0.000001).toStringAsFixed(2).toString() + "MB",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).iconTheme.color,
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
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                              overflow: TextOverflow.fade,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // Video Author
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                            child: Text(
                              manager.artistController.text,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                                fontFamily: "Varela",
                              ),
                            ),
                          ),
                          // Likes, dislikes, Views and Share button
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconTile(
                                  icon: Icon(MdiIcons.thumbUpOutline, color: Theme.of(context).iconTheme.color),
                                  text: Text(
                                    NumberFormat.compact().format(manager.mediaStream.videoDetails.statistics.likeCount),
                                    style: TextStyle(
                                      fontFamily: "Varela",
                                      fontSize: 10
                                    ),
                                    ),
                                ),
                                IconTile(
                                  icon: Icon(MdiIcons.thumbDownOutline, color: Theme.of(context).iconTheme.color),
                                  text: Text(
                                    NumberFormat.compact().format(manager.mediaStream.videoDetails.statistics.dislikeCount),
                                    style: TextStyle(
                                      fontFamily: "Varela",
                                      fontSize: 10
                                    ),
                                    ),
                                ),
                                IconTile(
                                  icon: Icon(EvaIcons.eyeOutline, color: Theme.of(context).iconTheme.color),
                                  text: Text(
                                    NumberFormat.compact().format(manager.mediaStream.videoDetails.statistics.viewCount),
                                    style: TextStyle(
                                      fontFamily: "Varela",
                                      fontSize: 10
                                    ),
                                  ),
                                ),
                                IconTile(
                                  icon: Icon(MdiIcons.youtube, color: Theme.of(context).iconTheme.color),
                                  text: Text(
                                    "Channel",
                                    style: TextStyle(
                                      fontFamily: "Varela",
                                      fontSize: 10
                                    ),
                                  ),
                                  onPressed: () async {
                                    String link = await manager.getChannelLink();
                                    launch(link);
                                  },
                                ),
                                IconTile(
                                  icon: Icon(EvaIcons.shareOutline, color: Theme.of(context).iconTheme.color),
                                  text: Text(
                                    "Share",
                                    style: TextStyle(
                                      fontFamily: "Varela",
                                      fontSize: 10
                                    ),
                                  ),
                                  onPressed: () {
                                    Share.share(manager.urlController.text);
                                  },
                                ),
                              ],
                            ),
                          ),
                          // --------------
                          // Video Content
                          // --------------
                          //
                          // --------------
                          // Metadata
                          // --------------
                          /*Container(
                            padding: EdgeInsets.only(bottom: 4),
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).cardColor
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.redAccent
                                    ),
                                    child: Icon(
                                      MdiIcons.pencilOutline, color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Tags Editor",
                                    style: TextStyle(
                                      fontFamily: "Varela",
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.8)
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ),*/
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                // Title TextField
                                TextFieldTile(
                                  textController: manager.titleController,
                                  inputType: TextInputType.text,
                                  labelText: "Title",
                                  icon: EvaIcons.textOutline,
                                ),
                                SizedBox(height: 12),
                                // Album & Artist TextField Row
                                Row(
                                  children: <Widget>[
                                    // Album TextField
                                    Expanded(
                                      child: TextFieldTile(
                                        textController: manager.albumController,
                                        inputType: TextInputType.text,
                                        labelText: "Album",
                                        icon: EvaIcons.bookOpenOutline,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    // Artist TextField
                                    Expanded(
                                      child: TextFieldTile(
                                        textController: manager.artistController,
                                        inputType: TextInputType.text,
                                        labelText: "Artist",
                                        icon: EvaIcons.personOutline,
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
                                        textController: manager.genreController,
                                        inputType: TextInputType.text,
                                        labelText: "Genre",
                                        icon: EvaIcons.bookOutline,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    // Date TextField
                                    Expanded(
                                      child: TextFieldTile(
                                        textController: manager.dateController,
                                        inputType: TextInputType.datetime,
                                        labelText: "Date",
                                        icon: EvaIcons.calendarOutline,
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
                                        textController: manager.discController,
                                        inputType: TextInputType.number,
                                        labelText: "Disc",
                                        icon: EvaIcons.playCircleOutline
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    // Track TextField
                                    Expanded(
                                      child: TextFieldTile(
                                        textController: manager.trackController,
                                        inputType: TextInputType.number,
                                        labelText: "Track",
                                        icon: EvaIcons.musicOutline,
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
                    SizedBox(height: 8),
                  ]
                ),
              ),
            ),
          SearchBar(
            padding: EdgeInsets.zero,
            textfieldColor: Theme.of(context).inputDecorationTheme.fillColor,
            hintText: "URL",
            controller: manager.urlController,
            containerColor: Theme.of(context).cardColor,
            prefixIcon: Icon(Icons.https),
            indicatorValue: manager.showLoadingBar == true ? null : 0.0,
            onSearchPressed: () {
              manager.getMediaStreamInfo(manager.getIdFromLink());
            },
          )
        ],
        ),
        floatingActionButton: IgnorePointer(
          ignoring: manager.showFloatingActionButtom ? false : true,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: manager.showFloatingActionButtom ? 1.0 : 0.0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
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
      ),
    );
  }
}
