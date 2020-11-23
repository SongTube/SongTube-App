// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Internal
import 'package:songtube/players/service/playerService.dart';
import 'package:songtube/players/components/musicPlayer/collapsedPanel.dart';
import 'package:songtube/players/components/musicPlayer/expandedPanel.dart';
import 'package:songtube/players/service/screenStateStream.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/mediaProvider.dart';

// Packages
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:audio_service/audio_service.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class SlidingPlayerPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    return StreamBuilder<ScreenState>(
      stream: screenStateStream,
      builder: (context, snapshot) {
        final screenState = snapshot.data;
        final state = screenState?.playbackState;
        final processingState =
          state?.processingState ?? AudioProcessingState.none;
        final mediaItem = screenState?.mediaItem;
        AudioService.currentMediaItemStream.listen((newMediaItem) {
          if (newMediaItem != mediaProvider.mediaItem) {
            mediaProvider.mediaItem = newMediaItem;
          }
        });
        if (mediaItem != null) {
          if (mediaProvider.slidingPanelOpen == true) {
            Color dominantColor = config.useBlurBackground
              ? mediaProvider.dominantColor == null ? Colors.white : mediaProvider.dominantColor
              : Theme.of(context).accentColor;
            Color textColor = config.useBlurBackground
              ? dominantColor.computeLuminance() > 0.5 ? Colors.black : Colors.white
              : Theme.of(context).textTheme.bodyText1.color;
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarIconBrightness: textColor == Colors.black? Brightness.dark : Brightness.light,
              ),
            );
          }
          if (mediaProvider.artwork != null) {
            return ShowUpTransition(
              duration: Duration(milliseconds: 400),
              slideSide: SlideFromSlide.BOTTOM,
              forward: processingState != AudioProcessingState.none,
              child: SlidingPlayer(
                snapshot: snapshot,
              ),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      }
    );
  }
}

class SlidingPlayer extends StatelessWidget {
  final AsyncSnapshot<ScreenState> snapshot;
  SlidingPlayer({
    this.snapshot,
  });
  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    Color dominantColor = config.useBlurBackground
      ? mediaProvider.dominantColor == null ? Colors.white : mediaProvider.dominantColor
      : Theme.of(context).accentColor;
    Color textColor = config.useBlurBackground
      ? dominantColor.computeLuminance() > 0.5 ? Colors.black : Colors.white
      : Theme.of(context).textTheme.bodyText1.color;
    return SlidingUpPanel(
      controller: mediaProvider.panelController,
      borderRadius: BorderRadius.circular(10),
      minHeight: kToolbarHeight * 1.15,
      backdropColor: dominantColor,
      backdropEnabled: true,
      backdropBlurStrength: 15,
      enableBottomNavigationBarMargin: true,
      maxHeight: MediaQuery.of(context).size.height,
      onPanelClosed: () => mediaProvider.slidingPanelOpen = false,
      onPanelOpened: () => mediaProvider.slidingPanelOpen = true,
      onPanelSlide: (double position) {
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
        snapshot: snapshot,
      ),
      collapsed: CollapsedPanel(snapshot),
    );
  }
}