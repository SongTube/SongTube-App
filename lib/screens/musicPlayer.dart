// Flutter
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/internal/playerService.dart';
import 'package:songtube/screens/musicPlayer/collapsed.dart';
import 'package:songtube/screens/musicPlayer/expanded.dart';
import 'package:songtube/screens/musicPlayer/screenStateStream.dart';

// Packages
import 'package:sliding_up_panel/sliding_up_panel.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class SlidingPlayerPanel extends StatefulWidget {
  @override
  _SlidingPlayerPanelState createState() => _SlidingPlayerPanelState();
}

class _SlidingPlayerPanelState extends State<SlidingPlayerPanel> {


  double _percent = 1;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ScreenState>(
      stream: screenStateStream,
      builder: (context, snapshot) {
        final screenState = snapshot.data;
        final state = screenState?.playbackState;
        final processingState =
          state?.processingState ?? AudioProcessingState.none;
        return ShowUpTransition(
          duration: Duration(milliseconds: 400),
          slideSide: SlideFromSlide.BOTTOM,
          forward: processingState != AudioProcessingState.none,
          child: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return SlidingUpPanel(
                borderRadius: BorderRadius.circular(10),
                margin: EdgeInsets.only(
                  bottom: kBottomNavigationBarHeight * _percent,
                ),
                minHeight: kToolbarHeight * 1.15,
                maxHeight: MediaQuery.of(context).size.height,
                onPanelSlide: (position) {
                  _percent = 1 - ((position*1000).toInt())/1000;
                  setState(() {});
                },
                boxShadow: [BoxShadow(
                  blurRadius: 5,
                  offset: Offset(0,-5),
                  color: Colors.black.withOpacity(0.05)
                )],
                color: Theme.of(context).cardColor,
                panel: ExpandedPlayer(),
                collapsed: CollapsedPanel(),
              );
            }
          ),
        );
      }
    );
  }
}