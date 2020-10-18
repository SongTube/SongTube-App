// Dart
import 'dart:io';

import 'package:intl/intl.dart';

// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/internal/models/metadata.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/provider/downloadsProvider.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/homeScreen/components/roundTile.dart';
import 'package:songtube/screens/homeScreen/pages/components/videoPage/floatingActionButton.dart';
import 'package:songtube/screens/homeScreen/downloadMenu/downloadMenu.dart';

// Packages
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:string_validator/string_validator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// UI
import 'package:songtube/ui/components/textfieldTile.dart';
import 'package:songtube/ui/animations/FadeIn.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  
  // Open Player
  bool openPlayer;

  // Tags Controllers
  TagsControllers tagsControllers;

  @override
  void initState() {
    openPlayer = false;
    tagsControllers = new TagsControllers();
    tagsControllers.updateTextControllers(
      Provider.of<ManagerProvider>
        (context, listen: false).videoDetails
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context);
    return Scaffold(
      body: FadeInTransition(
        duration: Duration(milliseconds: 400),
        child: Dismissible(
          key: GlobalKey(),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            manager.updateHomeScreen(LoadingStatus.Unload);
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
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: openPlayer
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
                            topActions: [
                              PlayPauseButton()
                            ],
                            bottomActions: [
                              CurrentPosition(),
                              ProgressBar(isExpanded: true),
                              RemainingDuration()
                            ],
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
                                  onTap: () => setState(() => openPlayer = true),
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
                  Container(
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
                                  tagsControllers.titleController.text,
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
                                  tagsControllers.artistController.text,
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
                  // Video Duration and Weight
                  Row(
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
                  // ---------------------------------------
                  // Likes, dislikes, Views and Share button
                  // ---------------------------------------
                  Row(
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
                  // --------------
                  // Video Metadata
                  // --------------
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Metadata Text
                        Row(
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
                              onTap: () async {
                                File image = await FilePicker.getFile(type: FileType.image);
                                if (image == null) return;
                                setState(() {
                                  tagsControllers.artworkController = image.path;
                                });
                              },
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
                                              image: isURL(tagsControllers.artworkController)
                                                ? NetworkImage(tagsControllers.artworkController)
                                                : FileImage(File(tagsControllers.artworkController)),
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
                        // Title TextField
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextFieldTile(
                                textController: tagsControllers.titleController,
                                inputType: TextInputType.text,
                                labelText: "Title",
                                icon: EvaIcons.textOutline,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        // Album & Artist TextField Row
                        Row(
                          children: <Widget>[
                            // Album TextField
                            Expanded(
                              child: TextFieldTile(
                                textController: tagsControllers.albumController,
                                inputType: TextInputType.text,
                                labelText: "Album",
                                icon: EvaIcons.bookOpenOutline,
                              ),
                            ),
                            SizedBox(width: 12),
                            // Artist TextField
                            Expanded(
                              child: TextFieldTile(
                                textController: tagsControllers.artistController,
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
                                textController: tagsControllers.genreController,
                                inputType: TextInputType.text,
                                labelText: "Genre",
                                icon: EvaIcons.bookOutline,
                              ),
                            ),
                            SizedBox(width: 12),
                            // Date TextField
                            Expanded(
                              child: TextFieldTile(
                                textController: tagsControllers.dateController,
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
                                textController: tagsControllers.discController,
                                inputType: TextInputType.number,
                                labelText: "Disc",
                                icon: EvaIcons.playCircleOutline
                              ),
                            ),
                            SizedBox(width: 12),
                            // Track TextField
                            Expanded(
                              child: TextFieldTile(
                                textController: tagsControllers.trackController,
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
              SizedBox(height: 8),
            ]
          ),
        ),
      ),
      floatingActionButton: VideoPageFloatingActionButton(
        readyToDownload: manager.streamManifest == null ? false : true,
        onDownload: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          List<dynamic> response = await showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
              ),
            ),
            context: context,
            builder: (context) {
              return DownloadMenu(
                videoList: manager.streamManifest.videoOnly
                  .sortByVideoQuality(),
                audioSize: manager.streamManifest.audioOnly
                  .withHighestBitrate().size.totalMegaBytes,
              );
            }
          );
          if (response == null) return;
          manager.navigateToScreen(LibraryScreen.Downloads);
          downloadsProvider.handleVideoDownload(
            currentAppData: Provider.of<AppDataProvider>(context, listen: false),
            metadata: DownloadMetaData(
              title: tagsControllers.titleController.text,
              album: tagsControllers.albumController.text,
              artist: tagsControllers.artistController.text,
              genre: tagsControllers.genreController.text,
              coverurl: tagsControllers.artworkController,
              date: tagsControllers.dateController.text,
              disc: tagsControllers.discController.text,
              track: tagsControllers.trackController.text
            ),
            manifest: manager.streamManifest,
            videoDetails: manager.videoDetails,
            data: response
          );
        },
      ),
    );
  }
}