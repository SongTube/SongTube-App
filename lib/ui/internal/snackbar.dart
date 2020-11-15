// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/player/service/playerService.dart';
import 'package:songtube/player/service/screenStateStream.dart';

// Packages
import 'package:audio_service/audio_service.dart';

class AppSnack {

  GlobalKey<ScaffoldState> scaffoldKey;
  BuildContext context;
  bool addPadding;
  AppSnack({
    @required this.scaffoldKey,
    @required this.context,
    this.addPadding = true,
  });

  // Show SnackBar with Icon, Title and Message
  void showSnackBar({
    @required IconData icon,
    @required String title,
    String message,
    Duration duration
  }) {
    scaffoldKey.currentState.removeCurrentSnackBar();
    final snack = SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                color: Theme.of(context).iconTheme.color,
              ),
              SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.bodyText1.color
                    )
                  ),
                  if (message != null)
                  Text(
                    message,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color
                    )
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ],
          ),
          if (addPadding)
          StreamBuilder<ScreenState>(
            stream: screenStateStream,
            builder: (context, snapshot) {
              final screenState = snapshot.data;
              final state = screenState?.playbackState;
              final processingState =
                state?.processingState ?? AudioProcessingState.none;
              return Container(
                height: processingState != AudioProcessingState.none
                  ? kToolbarHeight * 1.15
                  : 0
              );
            }
          ),
        ],
      ),
      duration: duration == null ? 3 : duration,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        )
      ),
      backgroundColor: Theme.of(context).canvasColor
    );
    scaffoldKey.currentState.showSnackBar(snack);
  }
}