import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/ui/internal/snackbar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadMenuHome extends StatelessWidget {
  final Function onBack;
  final Function onAudioTap;
  final Function onVideoTap;
  final List<Video> playlistVideos;
  final scaffoldState;
  DownloadMenuHome({
    @required this.onBack,
    @required this.onAudioTap,
    @required this.onVideoTap,
    @required this.playlistVideos,
    this.scaffoldState
  });
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        // Menu Title
        Container(
          margin: EdgeInsets.all(8),
          child: Row(
            children: [
              IconButton(
                icon: Icon(EvaIcons.arrowBackOutline),
                onPressed: onBack
              ),
              SizedBox(width: 16),
              Text(Languages.of(context).labelDownload, style: TextStyle(
                fontSize: 20,
                fontFamily: "YTSans"
              )),
            ],
          ),
        ),
        // Download Options
        Container(
          margin: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16
          ),
          child: Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  // Audio
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: onAudioTap,
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).iconTheme.color.withOpacity(0.1),
                            width: 1.5,
                          ),
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12,
                              color: Colors.black.withOpacity(0.04)
                            )
                          ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(EvaIcons.musicOutline, size: 35,
                             color: Theme.of(context).accentColor),
                            SizedBox(width: 16),
                            Text(
                              Languages.of(context).labelAudio,
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.9),
                                fontFamily: "YTSans"
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Video
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: onVideoTap,
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).iconTheme.color.withOpacity(0.1),
                            width: 1.5,
                          ),
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12,
                              color: Colors.black.withOpacity(0.04)
                            )
                          ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(EvaIcons.videoOutline, size: 35,
                              color: Theme.of(context).accentColor),
                            SizedBox(width: 16),
                            Text(
                              Languages.of(context).labelVideo,
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.9),
                                fontFamily: "YTSans"
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              if (playlistVideos != null)
              SizedBox(height: 16),
              if (playlistVideos != null)
              Consumer2<DownloadsProvider, ManagerProvider>(
                builder: (context, downloadsProvider, manager, child) {
                  return GestureDetector(
                    onTap: () {
                      downloadsProvider.handlePlaylistDownload(
                        language: Languages.of(context),
                        config: Provider.of<ConfigurationProvider>(context, listen: false),
                        listVideos: playlistVideos,
                        album: manager.mediaInfoSet.mediaTags.albumController.text,
                        artist: manager.mediaInfoSet.mediaTags.artistController.text
                          .replaceAll("- Topic", "").trim()
                      );
                      Navigator.of(context).pop();
                      if (scaffoldState != null) {
                        AppSnack.showSnackBar(
                          icon: EvaIcons.cloudDownloadOutline,
                          title: "Downloading Playlist...",
                          message: "Songs queued",
                          context: context,
                          scaffoldKey: scaffoldState
                        );
                      }
                    },
                    child: child
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).iconTheme.color.withOpacity(0.1),
                      width: 1.5,
                    ),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        color: Colors.black.withOpacity(0.04)
                      )
                    ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(MdiIcons.playlistMusicOutline, size: 35,
                        color: Theme.of(context).accentColor),
                      SizedBox(width: 16),
                      Text(
                        Languages.of(context).labelDownloadAll +
                        " (${Languages.of(context).labelPlaylist})",
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.9),
                          fontFamily: "YTSans"
                        )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}