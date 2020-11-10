// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';

// Internal
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/homeScreen/components/youtubeVideoPlayer.dart';
import 'package:songtube/screens/homeScreen/pages/components/playlistPage/pageDetails.dart';
import 'package:songtube/screens/homeScreen/pages/components/playlistPage/videosListview.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// UI
import 'package:songtube/ui/animations/fadeIn.dart';

final dismissKey = GlobalKey();

class PlaylistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return FadeInTransition(
      duration: Duration(milliseconds: 400),
      child: Dismissible(
        key: PageStorageKey('playlistPageKey'),
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

  @override
  void initState() {
    ManagerProvider manager =
      Provider.of<ManagerProvider>(context, listen: false);
    albumController = new TextEditingController();
    artistController = new TextEditingController();
    artistController.text = manager.playlistDetails.title
      .replaceAll("Mix -", "").trim();
    albumController.text = manager.playlistDetails.author ?? "Youtube";
    super.initState();
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
            openPlayer: manager.youtubePlayerController == null
              ? false : true,
            playerController: manager.youtubePlayerController,
            playerThumbnailUrl: manager.playlistDetails.thumbnails.mediumResUrl
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
                          Languages.of(context).labelLoadingVideos,
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
                      onDismiss: (int index) {
                        manager.playlistVideos.removeAt(index);
                        setState(() {});
                      },
                      onVideoTap: (int index) {
                        String url = manager.playlistVideos[index].url;
                        manager.updateYoutubePlayerController(
                          VideoId.parseVideoId(url), true);
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
            language: Languages.of(context),
            currentAppData: Provider.of<AppDataProvider>(context, listen: false),
            listVideos: manager.playlistVideos,
            album: albumController.text,
            artist: artistController.text
              .replaceAll("- Topic", "").trim()
          );
          manager.navigateToScreen(LibraryScreen.Downloads);
        },
        backgroundColor: Theme.of(context).accentColor,
        label: Row(
          children: [
            Icon(EvaIcons.musicOutline, color: Colors.white),
            SizedBox(width: 8),
            Text(Languages.of(context).labelDownloadAll,
              style: TextStyle(color: Colors.white))
          ],
        ) 
      ),
    );
  }
}