import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:songtube/internal/languages.dart';

class DownloadMenuHome extends StatelessWidget {
  final Function onBack;
  final Function onAudioTap;
  final Function onVideoTap;
  final Function onPlaylistTap;
  final List<StreamInfoItem> playlistVideos;
  final scaffoldState;
  DownloadMenuHome({
    @required this.onBack,
    @required this.onAudioTap,
    @required this.onVideoTap,
    @required this.onPlaylistTap,
    @required this.playlistVideos,
    this.scaffoldState
  });
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        // Menu Title
        Container(
          margin: EdgeInsets.all(8).copyWith(
            bottom: 16,
            top: 16
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: onBack
              ),
              SizedBox(width: 4),
              Text(Languages.of(context).labelDownload, style: TextStyle(
                fontSize: 24,
                fontFamily: "Product Sans",
                fontWeight: FontWeight.w600
              )),
            ],
          ),
        ),
        // Download Options
        Container(
          margin: EdgeInsets.only(
            left: 16,
            top: 16,
            right: 16,
            bottom: 16
          ),
          child: Column(
            children: [
              // Audio
              GestureDetector(
                onTap: onAudioTap,
                child: ListTile(
                  leading: Icon(EvaIcons.musicOutline, size: 35,
                    color: Theme.of(context).accentColor),
                  title: Text(
                    Languages.of(context).labelMusic,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.9),
                      fontFamily: "Product Sans",
                      fontWeight: FontWeight.w600
                    )
                  ),
                  subtitle: Text(
                    'Select quality, convert and download audio only',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Video
              GestureDetector(
                onTap: onVideoTap,
                child: ListTile(
                  leading: Icon(EvaIcons.videoOutline, size: 35,
                    color: Theme.of(context).accentColor),
                  title: Text(
                    Languages.of(context).labelVideo,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.9),
                      fontFamily: "Product Sans",
                      fontWeight: FontWeight.w600
                    )
                  ),
                  subtitle: Text(
                    'Choose a Video quality from the list and download it',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              //Playlist
              if (playlistVideos != null)
              GestureDetector(
                onTap: onPlaylistTap,
                child: ListTile(
                  leading: Icon(MdiIcons.playlistMusicOutline, size: 35,
                    color: Theme.of(context).accentColor),
                  title: Text(
                    Languages.of(context).labelPlaylist,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.9),
                      fontFamily: "Product Sans",
                      fontWeight: FontWeight.w600
                    )
                  ),
                  subtitle: Text(
                    'Download everything as video or audio',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        )
      ],
    );
  }
}