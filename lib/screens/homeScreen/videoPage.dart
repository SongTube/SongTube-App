// Dart
import 'dart:io';

import 'package:intl/intl.dart';

// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:string_validator/string_validator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// UI
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:songtube/screens/homeScreen/roundTile.dart';
import 'package:songtube/ui/reusable/textfieldTile.dart';
import 'package:songtube/ui/animations/showUp.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {

  GlobalKey key;

  @override
  void initState() {
    key = new GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return Dismissible(
      key: key,
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        manager.loadHome(LoadingStatus.Failed);
      },
      child: ListView(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        children: <Widget> [
          // --------------
          // Video Content
          // --------------
          // Mini-Player
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Mini-Player
              ShowUpTransition(
                forward: true,
                duration: Duration(milliseconds: 300),
                slideSide: SlideFromSlide.TOP,
                child: Container(
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: manager.openWebviewPlayer
                      ? YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: YoutubePlayer.convertUrlToId(manager.videoDetails.url),
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
                      : AspectRatio(
                        aspectRatio: 16/9,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              FadeInImage(
                                fadeInDuration: Duration(milliseconds: 300),
                                image: NetworkImage(manager.videoDetails.thumbnails.highResUrl),
                                placeholder: MemoryImage(kTransparentImage),
                                fit: BoxFit.fitWidth,
                              ),
                              Center(
                                child: Icon(MdiIcons.play, size: 60, color: Colors.white),
                              ),
                              GestureDetector(
                                onTap: () {
                                  manager.openWebviewPlayer = true;
                                },
                                child: Center(
                                  child: Icon(MdiIcons.youtube, size: 80, color: Colors.red),
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                  ),
                ),
              ),
              ShowUpTransition(
                forward: true,
                duration: Duration(milliseconds: 400),
                slideSide: SlideFromSlide.LEFT,
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        margin: EdgeInsets.only(right: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: FadeInImage(
                            fadeInDuration: Duration(milliseconds: 400),
                            placeholder: MemoryImage(kTransparentImage),
                            image: manager.channelDetails != null
                              ? NetworkImage(manager.channelDetails.logoUrl)
                              : MemoryImage(kTransparentImage)
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Video Title
                            Padding(
                              padding: const EdgeInsets.only(right: 16, bottom: 4),
                              child: Text(
                                manager.titleController.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).textTheme.bodyText1.color,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            // Video Author
                            Padding(
                              padding: const EdgeInsets.only(right: 16, bottom: 8),
                              child: Text(
                                manager.artistController.text,
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyText1.color,
                                  fontFamily: "Varela",
                                  fontSize: 12
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Video Duration and Weight
              ShowUpTransition(
                forward: true,
                duration: Duration(milliseconds: 500),
                slideSide: SlideFromSlide.BOTTOM,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: Text(
                        manager.videoDetails.duration.inMinutes.remainder(60).toString().padLeft(2, '0') + " min "
                        + manager.videoDetails.duration.inSeconds.remainder(60).toString().padLeft(2, '0') + " sec",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        "${manager.videoDetails.uploadDate.year}/" +
                        "${manager.videoDetails.uploadDate.month}/" +
                        "${manager.videoDetails.uploadDate.day}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ---------------------------------------
              // Likes, dislikes, Views and Share button
              // ---------------------------------------
              ShowUpTransition(
                forward: true,
                duration: Duration(milliseconds: 600),
                slideSide: SlideFromSlide.BOTTOM,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Likes Counter
                    RoundTile(
                      icon: Icon(MdiIcons.thumbUp, color: Theme.of(context).iconTheme.color),
                      text: Text(
                        NumberFormat.compact().format(manager.videoDetails.engagement.likeCount),
                        style: TextStyle(
                          fontFamily: "Varela",
                          fontSize: 10
                        ),
                        ),
                    ),
                    // Dislikes Counter
                    RoundTile(
                      icon: Icon(MdiIcons.thumbDown, color: Theme.of(context).iconTheme.color),
                      text: Text(
                        NumberFormat.compact().format(manager.videoDetails.engagement.dislikeCount),
                        style: TextStyle(
                          fontFamily: "Varela",
                          fontSize: 10
                        ),
                        ),
                    ),
                    //
                    RoundTile(
                      icon: Icon(EvaIcons.eye, color: Theme.of(context).iconTheme.color),
                      text: Text(
                        NumberFormat.compact().format(manager.videoDetails.engagement.viewCount),
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
                        String link = (await manager.getChannel()).url;
                        launch(link);
                      },
                    ),
                    // Share button
                    RoundTile(
                      icon: Icon(EvaIcons.share, color: Theme.of(context).iconTheme.color),
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
              Divider(indent: 8, endIndent: 8),
              // --------------
              // Video Metadata
              // --------------
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Metadata Text
                    ShowUpTransition(
                      forward: true,
                      duration: Duration(milliseconds: 700),
                      slideSide: SlideFromSlide.BOTTOM,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(10)
                              ),
                              color: Theme.of(context).cardColor
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    border: Border.all(color: Theme.of(context).cardColor, width: 4)
                                  ),
                                  child: Center(
                                    child: Icon(EvaIcons.musicOutline),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text(
                                    "Tags\nEditor",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.only(left: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(25)
                                ),
                                color: Theme.of(context).cardColor
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 50,
                                    margin: EdgeInsets.only(right: 8),
                                    child: Text(
                                      "Edit\nArtwork",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12
                                      ),
                                    ),
                                  ),
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: FadeInImage(
                                            fadeInDuration: Duration(milliseconds: 300),
                                            placeholder: MemoryImage(kTransparentImage),
                                            image: isURL(manager.artworkController)
                                              ? NetworkImage(manager.artworkController)
                                              : FileImage(File(manager.artworkController)),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ),
                                      Container(
                                        height: 20,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(25)),
                                          color: Theme.of(context).cardColor.withOpacity(0.4)
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 2),
                                        child: Icon(EvaIcons.editOutline, size: 18, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Title TextField
                    ShowUpTransition(
                      forward: true,
                      duration: Duration(milliseconds: 800),
                      slideSide: SlideFromSlide.BOTTOM,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFieldTile(
                              textController: manager.titleController,
                              inputType: TextInputType.text,
                              labelText: "Title",
                              icon: EvaIcons.textOutline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    // Album & Artist TextField Row
                    ShowUpTransition(
                      forward: true,
                      duration: Duration(milliseconds: 900),
                      slideSide: SlideFromSlide.BOTTOM,
                      child: Row(
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
                    ),
                    SizedBox(height: 12),
                    // Gender & Date TextField Row
                    ShowUpTransition(
                      forward: true,
                      duration: Duration(milliseconds: 1000),
                      slideSide: SlideFromSlide.BOTTOM,
                      child: Row(
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
                    ),
                    SizedBox(height: 12),
                    // Disk & Track TextField Row
                    ShowUpTransition(
                      forward: true,
                      duration: Duration(milliseconds: 1100),
                      slideSide: SlideFromSlide.BOTTOM,
                      child: Row(
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
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 8),
        ]
      ),
    );
  }
}