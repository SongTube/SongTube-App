import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:songtube/ui/components/textfieldTile.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlaylistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return FadeInTransition(
      duration: Duration(milliseconds: 400),
      child: Dismissible(
        key: GlobalKey(),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          manager.updateHomeScreen(LoadingStatus.Unload);
        },
        child: PlayerListBody()
      ),
    );
  }
}

class PlayerListBody extends StatefulWidget {
  @override
  _PlayerListBodyState createState() => _PlayerListBodyState();
}

class _PlayerListBodyState extends State<PlayerListBody> {

  // Text Controllers
  TextEditingController albumController;
  TextEditingController artistController;

  // Player Controller
  YoutubePlayerController playerController;

  // Open WebView Player
  bool openPlayer;

  // Current Video on Player
  String currentVideoUrl;

  @override
  void initState() {
    ManagerProvider manager =
      Provider.of<ManagerProvider>(context, listen: false);
    albumController = new TextEditingController();
    artistController = new TextEditingController();
    artistController.text = manager.playlistDetails.title
      .replaceAll("Mix -", "").trim();
    albumController.text = manager.playlistDetails.author ?? "Youtube"; 
    openPlayer = false;
    super.initState();
  }

  void checkPlayer(String url) {
    playerController = new YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url),
      flags: YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context);
    Playlist playlist = manager.playlistDetails;
    return Scaffold(
      body: Column(
        children: [
          // Mini-Player
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: openPlayer
                ? YoutubePlayer(
                    controller: playerController,
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
                          image: NetworkImage(playlist.thumbnails.mediumResUrl),
                          placeholder: MemoryImage(kTransparentImage),
                          fit: BoxFit.fitWidth,
                        ),
                        Center(
                          child: Icon(MdiIcons.play, size: 60, color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (manager.playlistVideos.isNotEmpty) {
                              String url = manager.playlistVideos[0].url;
                              if (playerController == null)
                                checkPlayer(url);
                              else
                                playerController.load(YoutubePlayer.convertUrlToId(url));
                              setState(() {
                                openPlayer = true;
                              });
                            }
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
          // Playlist Icon, Title & Author
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      margin: EdgeInsets.only(right: 12, left: 12, top: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Theme.of(context).cardColor
                      ),
                      child: Icon(
                        MdiIcons.playlistMusicOutline,
                        color: Theme.of(context).iconTheme.color
                      )
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Video Title
                          Padding(
                            padding: const EdgeInsets.only(right: 16, bottom: 4, top: 12),
                            child: Text(
                              playlist.title,
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).textTheme.bodyText1.color
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          // Video Author
                          Padding(
                            padding: const EdgeInsets.only(right: 16, bottom: 8),
                            child: Text(
                              playlist.author ?? "Youtube",
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6),
                                fontFamily: "Varela",
                                fontSize: 12
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                        child: TextFieldTile(
                        textController: albumController,
                        icon: EvaIcons.bookOpenOutline,
                        inputType: TextInputType.text,
                        labelText: "Album",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: manager.playlistVideos.isEmpty
                ? Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 64),
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Text(
                          "Loading Videos...",
                          style: TextStyle(
                            fontFamily: 'YTSans',
                            fontSize: 16
                          ),
                        ),
                      )
                    ],
                  )
                )
                : Container(
                    padding: EdgeInsets.only(top: 8),
                    color: Colors.transparent,
                    child: ListView.builder(
                      itemCount: manager.playlistVideos.length,
                      physics: BouncingScrollPhysics(),
                      itemExtent: 80,
                      itemBuilder: (context, index) {
                        Video video = manager.playlistVideos[index];
                        return Dismissible(
                          direction: DismissDirection.startToEnd,
                          key: Key(video.id.value),
                          onDismissed: (direction) {
                            if (
                              playerController != null &&
                              playerController.metadata.videoId == manager.playlistVideos[index].id.value
                            )
                              openPlayer = false; playerController = null;
                            manager.playlistVideos.removeAt(index);
                            setState(() {});
                          },
                          background: Container(
                            margin: EdgeInsets.all(16),
                            padding: EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).accentColor
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Remove",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                                )
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              video.title,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                                fontSize: 14
                              ),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                            ),
                            subtitle: Text(
                              video.author,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6),
                                fontSize: 12
                              ),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                            ),
                            leading: Container(
                              height: 80,
                              width: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage(
                                  fadeInDuration: Duration(milliseconds: 200),
                                  placeholder: MemoryImage(kTransparentImage),
                                  image: NetworkImage(video.thumbnails.mediumResUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: () {
                              String url = manager.playlistVideos[index].url;
                              if (playerController == null)
                                checkPlayer(url);
                              else
                                playerController.load(YoutubePlayer.convertUrlToId(url));
                              setState(() {
                                openPlayer = true;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  )
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          downloadsProvider.handlePlaylistDownload(
            currentAppData: Provider.of<AppDataProvider>(context, listen: false),
            listVideos: manager.playlistVideos,
            album: albumController.text,
            artist: artistController.text
          );
        },
        backgroundColor: Theme.of(context).accentColor,
        label: Row(
          children: [
            Icon(EvaIcons.musicOutline, color: Colors.white),
            SizedBox(width: 8),
            Text("Download All")
          ],
        ) 
      ),
    );
  }
}