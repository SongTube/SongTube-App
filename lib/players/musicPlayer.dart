// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Internal
import 'package:songtube/players/components/musicPlayer/collapsedPanel.dart';
import 'package:songtube/players/components/musicPlayer/expandedPanel.dart';
import 'package:songtube/players/components/slidablePanel.dart';
import 'package:songtube/provider/mediaProvider.dart';

// Packages
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
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
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

  Widget _buildSlidingPanel(BuildContext context, {
    Color dominantColor, Color textColor, bool useBlurUI
  }) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    return SlidablePanelBase(
      callback: callback,
      controller: mediaProvider.panelController,
      backdropColor: useBlurUI ? dominantColor : Colors.black,
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
      expandedPanel: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ExpandedPlayer(
          controller: mediaProvider.panelController,
        ),
      ),
      collapsedPanel: CollapsedPanel(),
    );
  }
}