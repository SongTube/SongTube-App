// Flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/downloadMenu/components/homeMenu.dart';

// Internal
import 'package:songtube/downloadMenu/components/videoMenu.dart';
import 'package:songtube/downloadMenu/components/audioMenu.dart';
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

enum CurrentDownloadMenu { Home, Audio, Video, Loading }

class DownloadMenu extends StatefulWidget {
  final StreamManifest streamManifest;
  final String videoUrl;
  DownloadMenu({
    this.streamManifest,
    this.videoUrl
  });
  @override
  _DownloadMenuState createState() => _DownloadMenuState();
}

class _DownloadMenuState extends State<DownloadMenu> with TickerProviderStateMixin {

  // Current Download Menu Sub-Menu
  CurrentDownloadMenu currentDownloadMenu;

  // Download Menu StreamManifest
  StreamManifest manifest;

  @override
  void initState() {
    currentDownloadMenu =
      CurrentDownloadMenu.Loading;
    super.initState();
    if (widget.streamManifest == null) {
      Provider.of<ManagerProvider>(context, listen: false)
        .youtubeExtractor.getStreamManifest(
          VideoId(VideoId.parseVideoId(widget.videoUrl))
        ).then((value) {
          manifest = value;
          setState(() => currentDownloadMenu = CurrentDownloadMenu.Home);
        });
    } else {
      manifest = widget.streamManifest;
      setState(() => currentDownloadMenu = CurrentDownloadMenu.Home);
    }
    
  }

  @override
  void dispose() {
    Provider.of<ManagerProvider>(context, listen: false)
      .youtubeExtractor.killIsolates();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
      child: _currentDownloadMenuWidget(),
    );
  }

  // Current Menu Widget
  Widget _currentDownloadMenuWidget() {
    Widget returnWidget;
    switch (currentDownloadMenu) {
      case CurrentDownloadMenu.Home:
        returnWidget = DownloadMenuHome(
          onBack: () => Navigator.pop(context),
          onAudioTap: () => setState(() => 
            currentDownloadMenu = CurrentDownloadMenu.Audio),
          onVideoTap: () => setState(() => 
            currentDownloadMenu = CurrentDownloadMenu.Video),
        ); break;
      case CurrentDownloadMenu.Audio:
        returnWidget = Container(
          child: AudioDownloadMenu(
            audioList: manifest.audioOnly
              .sortByBitrate()
              .reversed.toList(),
            onBack: () => setState(() => 
              currentDownloadMenu = CurrentDownloadMenu.Home),
            onDownload: (list) => Navigator.pop(context, list),
          ),
        ); break;
      case CurrentDownloadMenu.Video:
        returnWidget = Container(
          height: MediaQuery.of(context).size.height*0.6,
          child: VideoDownloadMenu(
            videoList: manifest.videoOnly
              .sortByVideoQuality(),
            onOptionSelect: (list) => Navigator.pop(context, list),
            audioSize: manifest.audioOnly
              .withHighestBitrate()
              .size.totalMegaBytes,
            onBack: () => setState(() => 
              currentDownloadMenu = CurrentDownloadMenu.Home),
          ),
        ); break;
      case CurrentDownloadMenu.Loading:
        returnWidget = Container(
          height: MediaQuery.of(context).size.height*0.6,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
            ),
          ),
        ); break;
    }
    return returnWidget;
  }
}