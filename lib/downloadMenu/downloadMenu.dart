// Flutter
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:provider/provider.dart';
import 'package:songtube/downloadMenu/components/homeMenu.dart';
import 'package:songtube/downloadMenu/components/loadingMenu.dart';
import 'package:songtube/downloadMenu/components/playlistMenu.dart';

// Internal
import 'package:songtube/downloadMenu/components/videoMenu.dart';
import 'package:songtube/downloadMenu/components/audioMenu.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/download/downloadItem.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/ui/internal/snackbar.dart';

enum CurrentDownloadMenu { Home, Audio, Video, Playlist, Loading }

class DownloadMenu extends StatefulWidget {
  final YoutubeVideo video;
  final TagsControllers tags;
  final String videoUrl;
  final List<StreamInfoItem> relatedVideos;
  final scaffoldState;
  DownloadMenu({
    this.video,
    this.tags,
    this.videoUrl,
    this.scaffoldState,
    this.relatedVideos
  });
  @override
  _DownloadMenuState createState() => _DownloadMenuState();
}

class _DownloadMenuState extends State<DownloadMenu> with TickerProviderStateMixin {

  // Current Download Menu Sub-Menu
  CurrentDownloadMenu currentDownloadMenu;

  // Download Menu StreamManifest
  YoutubeVideo video;
  TagsControllers tags;

  @override
  void initState() {
    currentDownloadMenu =
      CurrentDownloadMenu.Loading;
    super.initState();
    if (widget.video == null) {
      getVideo();
    } else {
      video = widget.video;
      tags = widget.tags;
      setState(() => currentDownloadMenu = CurrentDownloadMenu.Home);
    }
    
  }

  void getVideo() async {
    video = await VideoExtractor.getStream(widget.videoUrl);
    tags = TagsControllers();
    tags.updateTextControllers(video);
    setState(() => currentDownloadMenu = CurrentDownloadMenu.Home);
  }

  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
      child: Container(
        margin: EdgeInsets.only(top: 50),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)
          )
        ),
        child: Material(
          color: Colors.transparent,
          child: _currentDownloadMenuWidget()
        ),
      ),
    );
  }

  // Current Menu Widget
  Widget _currentDownloadMenuWidget() {
    Widget returnWidget;
    switch (currentDownloadMenu) {
      case CurrentDownloadMenu.Home:
        returnWidget = DownloadMenuHome(
          playlistVideos: widget.relatedVideos,
          onBack: () => Navigator.pop(context),
          onAudioTap: () => setState(() => 
            currentDownloadMenu = CurrentDownloadMenu.Audio),
          onVideoTap: () => setState(() => 
            currentDownloadMenu = CurrentDownloadMenu.Video),
          onPlaylistTap: () => setState(() =>
            currentDownloadMenu = CurrentDownloadMenu.Playlist),
        ); break;
      case CurrentDownloadMenu.Audio:
        returnWidget = Container(
          child: AudioDownloadMenu(
            tags: tags,
            video: video,
            onBack: () => setState(() => 
              currentDownloadMenu = CurrentDownloadMenu.Home),
            onDownload: (item) => _initializeDownload([item]),
          ),
        ); break;
      case CurrentDownloadMenu.Video:
        returnWidget = Container(
          height: MediaQuery.of(context).size.height*0.6,
          child: VideoDownloadMenu(
            video: video,
            onOptionSelect: (item) => _initializeDownload([item]),
            audioStream: video.audioWithBestAacQuality,
            onBack: () => setState(() => 
              currentDownloadMenu = CurrentDownloadMenu.Home),
          ),
        ); break;
      case CurrentDownloadMenu.Playlist:
        returnWidget = Container(
          height: MediaQuery.of(context).size.height*0.6,
          child: PlaylistDownloadMenu(
            playlistStreams: widget.relatedVideos,
            onDownload: (items) => _initializeDownload(items),
            onBack: () => setState(() => 
              currentDownloadMenu = CurrentDownloadMenu.Home),
          ),
        ); break;
      case CurrentDownloadMenu.Loading:
        returnWidget = Container(
          margin: EdgeInsets.only(top: 12, bottom: 12),
          child: LoadingDownloadMenu(),
        ); break;
    }
    return returnWidget;
  }

  void _initializeDownload(List<DownloadItem> items) async {
    if (items.length > 1) {
      Provider.of<DownloadsProvider>(context, listen: false)
        .handleDownloadItems(language: Languages.of(context), items: items);
    } else {
      Provider.of<DownloadsProvider>(context, listen: false)
        .handleDownloadItem(
          language: Languages.of(context),
          item: items[0]
        );
    }
    Navigator.of(context).pop();
    if (widget.scaffoldState != null) {
      String message;
      if (items.length == 1) {
        message = "${video.videoInfo.name}";
      } else {
        message = "${items[0].tags.title}, ${items[1].tags.title}, ${items[2].tags.title}...";
      }
      AppSnack.showSnackBar(
        icon: EvaIcons.cloudDownloadOutline,
        title: "Download started...",
        message: message,
        context: context,
        scaffoldKey: widget.scaffoldState
      );
    }
  }

  

}