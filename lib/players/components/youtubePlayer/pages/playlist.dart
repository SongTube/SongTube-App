import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/infoSets/mediaInfoSet.dart';
import 'package:songtube/players/components/youtubePlayer/components/playlistPage/pageDetails.dart';
import 'package:songtube/players/components/youtubePlayer/components/playlistPage/videosListview.dart';
import 'package:songtube/players/components/youtubePlayer/components/videoPage/youtubeVideoPlayer.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
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
    return Scaffold(
      body: Column(
        children: [
          // Top StatusBar Padding
          Container(
            color: Colors.black,
            height: MediaQuery.of(context).padding.top,
            width: double.infinity,
          ),
          // Youtube Player
          YoutubeVideoPlayer(
            openPlayer: manager.youtubePlayerController == null
              ? false : true,
            playerController: manager.youtubePlayerController,
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
                    manager.updateYoutubePlayerController(
                      VideoId.parseVideoId(url), true);
                  }
                )
            ),
          ),
        ],
      ),
      floatingActionButton: manager.mediaInfoSet.playlistDetails != null
        ? FloatingActionButton.extended(
            onPressed: () async {
              manager.expandablePlayerPanelController.close();
              await Future.delayed(Duration(milliseconds: 400));
              manager.screenIndex = 1;
              await Future.delayed(Duration(milliseconds: 400));
              downloadsProvider.handlePlaylistDownload(
                language: Languages.of(context),
                config: Provider.of<ConfigurationProvider>(context, listen: false),
                listVideos: manager.mediaInfoSet.playlistVideos,
                album: manager.mediaInfoSet.mediaTags.albumController.text,
                artist: manager.mediaInfoSet.mediaTags.artistController.text
                  .replaceAll("- Topic", "").trim()
              );
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
    );
  }
}