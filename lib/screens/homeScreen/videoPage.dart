// Dart
import 'package:intl/intl.dart';

// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// UI
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:songtube/screens/homeScreen/roundTile.dart';
import 'package:songtube/ui/reusable/textfieldTile.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return ListView(
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
                      handleColor: Theme.of(context).accentColor,
                    ),
                    progressIndicatorColor: Theme.of(context).accentColor,
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
                      + manager.mediaStream.videoDetails.duration.inSeconds.remainder(60).toString().padLeft(2, '0') + " sec",
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
              // ---------------------------------------
              // Likes, dislikes, Views and Share button
              // ---------------------------------------
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Likes Counter
                    RoundTile(
                      icon: Icon(MdiIcons.thumbUpOutline, color: Theme.of(context).iconTheme.color),
                      text: Text(
                        NumberFormat.compact().format(manager.mediaStream.videoDetails.statistics.likeCount),
                        style: TextStyle(
                          fontFamily: "Varela",
                          fontSize: 10
                        ),
                        ),
                    ),
                    // Dislikes Counter
                    RoundTile(
                      icon: Icon(MdiIcons.thumbDownOutline, color: Theme.of(context).iconTheme.color),
                      text: Text(
                        NumberFormat.compact().format(manager.mediaStream.videoDetails.statistics.dislikeCount),
                        style: TextStyle(
                          fontFamily: "Varela",
                          fontSize: 10
                        ),
                        ),
                    ),
                    //
                    RoundTile(
                      icon: Icon(EvaIcons.eyeOutline, color: Theme.of(context).iconTheme.color),
                      text: Text(
                        NumberFormat.compact().format(manager.mediaStream.videoDetails.statistics.viewCount),
                        style: TextStyle(
                          fontFamily: "Varela",
                          fontSize: 10
                        ),
                      ),
                    ),
                    // Channel Button
                    RoundTile(
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
                    // Share button
                    RoundTile(
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
              // Video Metadata
              // --------------
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
            ],
          ),
        ),
        SizedBox(height: 8),
      ]
    );
  }
}