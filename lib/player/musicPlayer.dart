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
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/player/internal/artworkGenerator.dart';

// Packages
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:audio_service/audio_service.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class SlidingPlayerPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
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
              if (mediaProvider.slidingPanelOpen == true) {
                Color dominantColor = appData.useBlurBackground
                  ? list.data[1] == null ? Colors.white : list.data[1]
                  : Theme.of(context).accentColor;
                Color textColor = appData.useBlurBackground
                  ? dominantColor.computeLuminance() > 0.5 ? Colors.black : Colors.white
                  : Theme.of(context).textTheme.bodyText1.color;
                SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle(
                    statusBarIconBrightness: textColor == Colors.black? Brightness.dark : Brightness.light,
                  ),
                );
              }
              if (list.data != null) {
                return ShowUpTransition(
                  duration: Duration(milliseconds: 400),
                  slideSide: SlideFromSlide.BOTTOM,
                  forward: processingState != AudioProcessingState.none,
                  child: SlidingPlayer(
                    snapshot: snapshot,
                    uiElements: list
                  ),
                );
              } else {
                return Container();
              }
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

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    Color dominantColor = appData.useBlurBackground
      ? widget.uiElements.data[1] == null ? Colors.white : widget.uiElements.data[1]
      : Theme.of(context).accentColor;
    Color textColor = appData.useBlurBackground
      ? dominantColor.computeLuminance() > 0.5 ? Colors.black : Colors.white
      : Theme.of(context).textTheme.bodyText1.color;
    return SlidingUpPanel(
      controller: mediaProvider.panelController,
      borderRadius: BorderRadius.circular(10),
      margin: EdgeInsets.only(
        bottom: kBottomNavigationBarHeight * _percent,
      ),
      minHeight: kToolbarHeight * 1.15,
      maxHeight: MediaQuery.of(context).size.height,
      onPanelClosed: () => mediaProvider.slidingPanelOpen = false,
      onPanelOpened: () => mediaProvider.slidingPanelOpen = true,
      onPanelSlide: (double position) {
        _percent = 1 - ((position*1000).toInt())/1000;
        if (position > 0.95) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarIconBrightness: textColor == Colors.black ? Brightness.dark : Brightness.light,
            ),
          );
        } else {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarIconBrightness:
                Theme.of(context).brightness == Brightness.dark ?  Brightness.light : Brightness.dark,
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
        controller: mediaProvider.panelController,
        snapshot: widget.snapshot,
        uiElements: widget.uiElements.data,
      ),
      collapsed: CollapsedPanel(widget.snapshot),
    );
  }
}