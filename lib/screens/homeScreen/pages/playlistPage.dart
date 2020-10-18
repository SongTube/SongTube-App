import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/homeScreen/components/youtubeVideoPlayer.dart';
import 'package:songtube/screens/homeScreen/pages/components/playlistPage/pageDetails.dart';
import 'package:songtube/screens/homeScreen/pages/components/playlistPage/videosListview.dart';
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
          // Youtube Player
          HomeScreenYoutubeVideoPlayer(
            openPlayer: openPlayer,
            playerController: playerController,
            playerThumbnailUrl: manager.playlistDetails.thumbnails.mediumResUrl,
            onPlayPressed: () {
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
          ),
          // Playlist Icon, Title & Author
          PlaylistPageDetails(
            title: playlist.title,
            author: playlist.author,
            albumController: albumController,
          ),
          // List of Playlist Videos
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
                    child: PlaylistVideosListView(
                      playlistVideos: manager.playlistVideos,
                      playerController: playerController,
                      onDismiss: (int index) {
                        if (
                          playerController != null &&
                          playerController.metadata.videoId == manager.playlistVideos[index].id.value
                        ) {
                          openPlayer = false;
                          playerController = null;
                        }
                        manager.playlistVideos.removeAt(index);
                        setState(() {});
                      },
                      onVideoTap: (int index) {
                        String url = manager.playlistVideos[index].url;
                        if (playerController == null)
                          checkPlayer(url);
                        else
                          playerController.load(YoutubePlayer.convertUrlToId(url));
                        setState(() {
                          openPlayer = true;
                        });
                      }
                    )
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