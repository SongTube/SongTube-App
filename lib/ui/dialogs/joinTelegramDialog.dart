import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
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
            "Join Telegram Channel!",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color
            )
          )
        ],
      ),
      content: Text(
        "Do you like SongTube? Please join the Telegram Channel! You will find " +
        "Updates, Information, Development, Group Link and other Social links." +
        "\n\nIn case you have an issue or a great recommentation in your mind, " +
        "please join the Group from the Channel and write it down! I will be " +
        "happy to listen to anything you have to say.",
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color
        ),
      ),
      actions: [
        FlatButton(
          child: Text("Join"),
          onPressed: () {
            prefs.showJoinTelegramDialog = false;
            launch("https://t.me/songtubechannel");
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text("Remind Later"),
          onPressed: () {
            prefs.remindTelegramLater = true;
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text("No"),
          onPressed: () {
            prefs.showJoinTelegramDialog = false;
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}