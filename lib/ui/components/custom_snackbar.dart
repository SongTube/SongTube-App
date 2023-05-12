// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:songtube/ui/text_styles.dart';

class CustomSnackbar {

  // Show SnackBar with Icon, Title and Message
  static void showSnackBar({
    required IconData icon,
    required String title,
    String? message,
    Duration duration = const Duration(seconds: 2),
    @required context,
    scaffoldKey
  }) {
    if (scaffoldKey == null) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    } else {
      scaffoldKey.removeCurrentSnackBar();
    }
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
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: textStyle(context),
                    ),
                    if (message != null)
                    Text(
                      message,
                      style: subtitleTextStyle(context),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      duration: duration,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        )
      ),
      backgroundColor: Theme.of(context).canvasColor
    );
    if (scaffoldKey == null) {
      ScaffoldMessenger.of(context).showSnackBar(snack);
    } else {
      scaffoldKey.showSnackBar(snack);
    }
  }
}