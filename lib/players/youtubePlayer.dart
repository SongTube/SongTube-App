import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/infoItems/playlist.dart';
import 'package:provider/provider.dart';
import 'package:songtube/players/components/slidablePanel.dart';
import 'package:songtube/players/components/youtubePlayer/expandedPanel.dart';
import 'package:songtube/players/components/youtubePlayer/collapsedPanel.dart';
import 'package:songtube/provider/videoPageProvider.dart';

typedef FloatingWidgetCallback = void Function(double position);

class SlidableVideoPage extends StatefulWidget {
  final FloatingWidgetCallback callback;
  SlidableVideoPage({
    @required this.callback,
  });

  @override
  _SlidableVideoPageState createState() => _SlidableVideoPageState();
}

class _SlidableVideoPageState extends State<SlidableVideoPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<VideoPageProvider>(context, listen: false)
        .panelController.open();
    });
  }

  @override
  Widget build(BuildContext context) {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    return SlidablePanelBase(
      openOnInitState: true,
      callback: widget.callback,
      controller: pageProvider.panelController,
      backdropColor: Colors.black,
      onPanelSlide: (double position) {
        widget.callback(position);
      },
      expandedPanel: YoutubePlayerVideoPage(),
      collapsedPanel: VideoPageCollapsed(),
    );
  }
}