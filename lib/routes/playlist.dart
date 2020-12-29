import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/players/youtubePlayer.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/routes/components/playlist/pageDetails.dart';
import 'package:songtube/routes/components/playlist/videosListview.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubePlayerPlaylistPage extends StatefulWidget {
  @override
  _YoutubePlayerPlaylistPageState createState() => _YoutubePlayerPlaylistPageState();
}

class _YoutubePlayerPlaylistPageState extends State<YoutubePlayerPlaylistPage> {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return WillPopScope(
      onWillPop: () {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarIconBrightness:
              Theme.of(context).brightness ==
                Brightness.dark ?  Brightness.light : Brightness.dark,
          ),
        );
        return Future.value(true);
      },
      child: Scaffold(
        body: Column(
          children: [
            // Top StatusBar Padding
            Container(
              color: Colors.black,
              height: MediaQuery.of(context).padding.top,
              width: double.infinity,
            ),
            // Youtube Player
            Container(
              color: Colors.black,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: manager.mediaInfoSet.playlistVideos.isNotEmpty
                  ? AspectRatio(
                      aspectRatio: 16/9,
                      child: StreamManifestPlayer(
                        manifest: manager.playerStream
                      ),
                    )
                  : AspectRatio(
                      aspectRatio: 16/9,
                      child: Container(color: Colors.black)
                    )
              ),
            ),
            // Playlist Icon, Title & Author
            PlaylistPageDetails(
              title: manager.mediaInfoSet.playlistFromSearch.playlistTitle,
              author: manager.mediaInfoSet.playlistDetails != null
                ? manager.mediaInfoSet.playlistDetails.author
                : "",
              albumController: manager.mediaInfoSet.mediaTags.albumController,
            ),
            // List of Playlist Videos
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: manager.mediaInfoSet.playlistVideos.isEmpty
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
                  : PlaylistVideosListView(
                      playlistVideos: manager.mediaInfoSet.playlistVideos,
                      onDismiss: (int index) {
                        manager.mediaInfoSet.playlistVideos.removeAt(index);
                        setState(() {});
                      },
                    onVideoTap: (int index) {
                      String url = manager.mediaInfoSet.playlistVideos[index].url;
                      manager.updateStreamManifestPlayer(VideoId.fromString(url));
                    }
                  )
              ),
            ),
          ],
        ),
        floatingActionButton: manager.mediaInfoSet.playlistDetails != null
          ? FloatingActionButton.extended(
              onPressed: () async {
                downloadsProvider.handlePlaylistDownload(
                  language: Languages.of(context),
                  config: Provider.of<ConfigurationProvider>(context, listen: false),
                  listVideos: manager.mediaInfoSet.playlistVideos,
                  album: manager.mediaInfoSet.mediaTags.albumController.text,
                  artist: manager.mediaInfoSet.mediaTags.artistController.text
                    .replaceAll("- Topic", "").trim()
                );
                Navigator.of(context).pop();
                await Future.delayed(Duration(milliseconds: 400));
                manager.screenIndex = 1;
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
            )
          : Container()
      ),
    );
  }
}