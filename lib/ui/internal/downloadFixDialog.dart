import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/provider/app_provider.dart';

class DownloadFixDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      title: Text(
        "Android 10 or 11 Detected",
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
      content: Text(
        "To ensure the correct functioning of this app Downloads, on Android 10 and 11, " +
        "access to all Files permission might be needed, this will be temporal and not required " +
        "on future updates. You can also apply this fix in Settings.",
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            "Allow",
            style: TextStyle(
              color: Theme.of(context).accentColor
            ),
          ),
          onPressed: () {
            NativeMethod.requestAllFilesPermission();
            Provider.of<AppDataProvider>(context, listen: false).showDownloadFixDialog = false;
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(
            "Not Now",
            style: TextStyle(
              color: Theme.of(context).accentColor
            ),
          ),
          onPressed: () => Navigator.pop(context)
        )
      ],
    );
  }
}