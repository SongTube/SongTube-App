// Flutter
import 'package:flutter/material.dart';

class AppSnack {

  GlobalKey<ScaffoldState> scaffoldKey;
  BuildContext context;
  AppSnack({
    @required this.scaffoldKey,
    @required this.context
  });

  // Show SnackBar with Icon, Title and Message
  void showSnackBar({
    @required IconData icon,
    @required String title,
    String message,
    Duration duration
  }) {
    final snack = SnackBar(
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
      duration: duration == null ? 3 : duration,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        )
      ),
      backgroundColor: Theme.of(context).canvasColor
    );
    scaffoldKey.currentState.showSnackBar(snack);
  }
}