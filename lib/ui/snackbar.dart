// Flutter
import 'package:flutter/material.dart';

AppSnack appSnack;

class AppSnack {

  GlobalKey<ScaffoldState> scaffoldKey;
  BuildContext context;
  AppSnack({
    @required this.scaffoldKey,
    @required this.context
  });

  void unrecognizedEncoding(encoding) {
    final _snack = AppSnack.withEverything(
      context,
      Icons.error,
      "Error",
      "Unrecognized encoding $encoding?",
      Duration(seconds: 2)
    );
    scaffoldKey.currentState.showSnackBar(_snack);
  }

  void pressAgainExit() {
    final _snack = AppSnack.withEverything(
      context,
      Icons.exit_to_app,
      "Exit",
      "Press back again to exit",
      Duration(seconds: 2)
    );
    scaffoldKey.currentState.showSnackBar(_snack);
  }

  void internalError() {
    final _snack = AppSnack.withEverything(
      context,
      Icons.search,
      "Error",
      "An Internal error has occured, send log?",
      Duration(seconds: 2)
    );
    scaffoldKey.currentState.showSnackBar(_snack);
  }

  void internetError() {
    final _snack = AppSnack.withEverything(
      context,
      Icons.error,
      "Error",
      "Check your internet connection...",
      Duration(seconds: 3)
    );
    scaffoldKey.currentState.showSnackBar(_snack);
  }

  void videoIsPremium() {
    final _snack = AppSnack.withEverything(
      context,
      Icons.error,
      "Error",
      "Video requires Youtube Premium",
      Duration(seconds: 3)
    );
    scaffoldKey.currentState.showSnackBar(_snack);
  }

  void gettingLinkInfo() {
    final _snack = AppSnack.withEverything(
      context,
      Icons.search,
      "Searching",
      "Getting link information...",
      Duration(seconds: 2)
    );
    scaffoldKey.currentState.showSnackBar(_snack);
  }

  void invalidID() {
    final _snack = AppSnack.withEverything(
      context,
      Icons.search,
      "Error",
      "Invalid Video or ID",
      Duration(seconds: 2)
    );
    scaffoldKey.currentState.showSnackBar(_snack);
  }

  // Show SnackBar with Icon, Title and Message
  static Widget withEverything(BuildContext context,
    IconData icon, String title, String message, Duration duration) {

    return SnackBar(
      content: Row(
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
      duration: duration,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        )
      ),
      backgroundColor: Theme.of(context).canvasColor
    );
  }

  // Show SnackBar with Icon and Title
  static Widget withIconTitle(BuildContext context,
    IconData icon, String title) {

    return SnackBar(
      content: Row(
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
              SizedBox(height: 4),
            ],
          ),
        ],
      ),
      duration: Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        )
      ),
      backgroundColor: Theme.of(context).canvasColor
    );
  }

}