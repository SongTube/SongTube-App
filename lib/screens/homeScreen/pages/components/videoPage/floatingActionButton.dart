import 'package:flutter/material.dart';

class VideoPageFloatingActionButton extends StatelessWidget {
  final bool readyToDownload;
  final Function onDownload;
  VideoPageFloatingActionButton({
    @required this.readyToDownload,
    @required this.onDownload
  });
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        child: readyToDownload
          ? Icon(Icons.file_download)
          : CircularProgressIndicator(
              backgroundColor: Theme.of(context).accentColor,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
      ),
      backgroundColor: Theme.of(context).accentColor,
      foregroundColor: Colors.white,
      onPressed: () {
        if (readyToDownload) {
          onDownload();
        }
      }
    );
  }
}