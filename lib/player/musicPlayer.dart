// Dart
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Internal
import 'package:songtube/internal/services/playerService.dart';
import 'package:songtube/player/widgets/musicPlayer/collapsedPanel.dart';
import 'package:songtube/player/widgets/musicPlayer/expandedPanel.dart';
import 'package:songtube/internal/screenStateStream.dart';
import 'package:songtube/provider/app_provider.dart';
import 'internal/artworkGenerator.dart';

// Packages
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:audio_service/audio_service.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class SlidingPlayerPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ScreenState>(
      stream: screenStateStream,
      builder: (context, snapshot) {
        final screenState = snapshot.data;
        final state = screenState?.playbackState;
        final processingState =
          state?.processingState ?? AudioProcessingState.none;
        final mediaItem = screenState?.mediaItem;
        if (mediaItem != null) {
          return FutureBuilder(
            future: ArtworkGenerator.generateArtwork(
              File(mediaItem.id),
              mediaItem.extras["albumId"]
            ),
            builder: (context, AsyncSnapshot<List<dynamic>> list) {
              Color dominantColor = list.data[1] == null ? Colors.white : list.data[1];
              Color textColor = dominantColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle(
                  statusBarIconBrightness: textColor == Colors.black ? Brightness.dark : Brightness.light,
                ),
              );
              return ShowUpTransition(
                duration: Duration(milliseconds: 400),
                slideSide: SlideFromSlide.BOTTOM,
                forward: processingState != AudioProcessingState.none,
                child: SlidingPlayer(
                  snapshot: snapshot,
                  uiElements: list
                ),
              );
            }
          );
        } else {
          return Container();
        }
      }
    );
  }
}

class SlidingPlayer extends StatefulWidget {
  final AsyncSnapshot<ScreenState> snapshot;
  final AsyncSnapshot<List<dynamic>> uiElements;
  SlidingPlayer({
    this.snapshot,
    this.uiElements
  });
  @override
  _SlidingPlayerState createState() => _SlidingPlayerState();
}

class _SlidingPlayerState extends State<SlidingPlayer> {

  double _percent = 1;

  // Panel Controller
  PanelController controller;

  @override
  void initState() {
    controller = new PanelController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: controller,
      borderRadius: BorderRadius.circular(10),
      margin: EdgeInsets.only(
        bottom: kBottomNavigationBarHeight * _percent,
      ),
      minHeight: kToolbarHeight * 1.15,
      maxHeight: MediaQuery.of(context).size.height,
      onPanelSlide: (double position) {
        _percent = 1 - ((position*1000).toInt())/1000;
        Color dominantColor = widget.uiElements.data[1] == null ? Colors.white : widget.uiElements.data[1];
        Color textColor = dominantColor.computeLuminance() > 0.6 ? Colors.black : Colors.white;
        if (position > 0.95) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarIconBrightness: textColor == Colors.black ? Brightness.dark : Brightness.light,
            ),
          );
        } else {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarIconBrightness: Provider.of<AppDataProvider>(context, listen: false)
                .darkThemeEnabled ? Brightness.light : Brightness.dark,
            ),
          );
        }
        setState(() {});
      },
      boxShadow: [
        BoxShadow(
          blurRadius: 5,
          offset: Offset(0,-5),
          color: Colors.black.withOpacity(0.05)
        )
      ],
      color: Theme.of(context).cardColor,
      panel: ExpandedPlayer(
        controller: controller,
        snapshot: widget.snapshot,
        uiElements: widget.uiElements.data,
      ),
      collapsed: CollapsedPanel(widget.snapshot),
    );
  }
}