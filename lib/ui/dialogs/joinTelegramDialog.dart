import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class JoinTelegramDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context, listen: false);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      title: Row(
        children: [
          Icon(MdiIcons.telegram, color: Colors.blue),
          SizedBox(width: 8),
          Text(
            Languages.of(context).labelJoinTelegramChannel,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color
            )
          )
        ],
      ),
      content: Text(
        Languages.of(context).labelJoinTelegramJustification,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color
        ),
      ),
      actions: [
        FlatButton(
          child: Text(Languages.of(context).labelJoin),
          onPressed: () {
            prefs.showJoinTelegramDialog = false;
            launch("https://t.me/songtubechannel");
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(Languages.of(context).labelRemindLater),
          onPressed: () {
            prefs.remindTelegramLater = true;
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(Languages.of(context).labelNo),
          onPressed: () {
            prefs.showJoinTelegramDialog = false;
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}