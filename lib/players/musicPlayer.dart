// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Internal
import 'package:songtube/players/components/musicPlayer/collapsedPanel.dart';
import 'package:songtube/players/components/musicPlayer/expandedPanel.dart';
import 'package:songtube/players/service/screenStateStream.dart';
import 'package:songtube/provider/mediaProvider.dart';

// Packages
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:audio_service/audio_service.dart';
import 'package:songtube/provider/preferencesProvider.dart';

typedef FloatingWidgetCallback = void Function(double position);

class SlidingPlayerPanel extends StatelessWidget {
  final FloatingWidgetCallback callback;
  SlidingPlayerPanel({
    this.callback
  });
  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context, listen: false);
    return StreamBuilder(
      stream: screenStateStream,
      builder: (context, snapshot) {
        AudioService.currentMediaItemStream.listen((newMediaItem) {
          if (newMediaItem != mediaProvider.mediaItem) {
            mediaProvider.mediaItem = newMediaItem;
          }
        });
        if (mediaProvider.slidingPanelOpen == true) {
          Color dominantColor = prefs.enablePlayerBlurBackground
            ? mediaProvider.dominantColor == null ? Colors.white : mediaProvider.dominantColor
            : Theme.of(context).accentColor;
          Color textColor = prefs.enablePlayerBlurBackground
            ? dominantColor.computeLuminance() > 0.5 ? Colors.black : Colors.white
            : Theme.of(context).textTheme.bodyText1.color;
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarIconBrightness: textColor == Colors.black? Brightness.dark : Brightness.light,
            ),
          );
        }
        Color dominantColor = prefs.enablePlayerBlurBackground
          ? mediaProvider.dominantColor == null ? Colors.white : mediaProvider.dominantColor
          : Theme.of(context).accentColor;
        Color textColor = prefs.enablePlayerBlurBackground
          ? dominantColor.computeLuminance() > 0.5 ? Colors.black : Colors.white
          : Theme.of(context).textTheme.bodyText1.color;
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: AudioService?.currentMediaItem != null
            ? _buildSlidingPanel(
                context,
                textColor: textColor,
                dominantColor: dominantColor,
                useBlurUI: prefs.enableBlurUI
              )
            : Container()
        );
      }
    );
  }

  Widget _buildSlidingPanel(BuildContext context, {
    Color dominantColor, Color textColor, bool useBlurUI
  }) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context, listen: false);
    var borderRadius = 20.0;
    return SlidingUpPanel(
      controller: mediaProvider.panelController,
      minHeight: kToolbarHeight * 1.15,
      maxHeight: MediaQuery.of(context).size.height,
      isPanelVisible: true,
      margin: EdgeInsets.only(
        left: 12, right: 12,
        bottom: 12
      ),
      backdropColor: useBlurUI ? dominantColor : Colors.black,
      backdropEnabled: true,
      borderRadius: borderRadius,
      backdropBlurStrength: useBlurUI ? 15 : 0,
      onPanelClosed: () => mediaProvider.slidingPanelOpen = false,
      onPanelOpened: () => mediaProvider.slidingPanelOpen = true,
      onPanelSlide: (double position) {
        callback(position);
        if (position > 0.95) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarIconBrightness: textColor == Colors.black ? Brightness.dark : Brightness.light,
            ),
          );
        } else if (position < 0.95) {
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
      ),
      collapsed: GestureDetector(
        onTap: () {
          mediaProvider.panelController.open();
        },
        child: CollapsedPanel(
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}