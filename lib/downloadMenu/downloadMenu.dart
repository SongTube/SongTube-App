// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/screens/homeScreen/downloadMenu/components/homeMenu.dart';

// Internal
import 'package:songtube/screens/homeScreen/downloadMenu/components/videoMenu.dart';
import 'package:songtube/screens/homeScreen/downloadMenu/components/audioMenu.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

enum CurrentDownloadMenu { Home, Audio, Video }

class DownloadMenu extends StatefulWidget {
  final List<VideoStreamInfo> videoList;
  final List<AudioStreamInfo> audioList;
  final double audioSize;
  DownloadMenu({
    @required this.videoList,
    @required this.audioList,
    @required this.audioSize
  });
  @override
  _DownloadMenuState createState() => _DownloadMenuState();
}

class _DownloadMenuState extends State<DownloadMenu> with TickerProviderStateMixin {

  // Current Download Menu Sub-Menu
  CurrentDownloadMenu currentDownloadMenu;

  @override
  void initState() {
    currentDownloadMenu =
      CurrentDownloadMenu.Home;
    super.initState();
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
            audioList: widget.audioList.reversed.toList(),
            onBack: () => setState(() => 
              currentDownloadMenu = CurrentDownloadMenu.Home),
            onDownload: (list) => Navigator.pop(context, list),
          ),
        ); break;
      case CurrentDownloadMenu.Video:
        returnWidget = Container(
          height: MediaQuery.of(context).size.height*0.6,
          child: VideoDownloadMenu(
            videoList: widget.videoList,
            onOptionSelect: (list) => Navigator.pop(context, list),
            audioSize: widget.audioList.withHighestBitrate().size.totalMegaBytes,
            onBack: () => setState(() => 
              currentDownloadMenu = CurrentDownloadMenu.Home),
          ),
        ); break;
    }
    return returnWidget;
  }
}