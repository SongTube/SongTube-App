import 'package:flutter/material.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:url_launcher/url_launcher_string.dart';

class JoinTelegramSheet extends StatelessWidget {
  const JoinTelegramSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSheet(
      title: 'Join Telegram Channel!',
      body: Text(
        // ignore: prefer_interpolation_to_compose_strings
        "Do you like SongTube? Please join the Telegram Channel! You will find " +
        "Updates, Information, Development, Group Link and other Social links." +
        "\n\n" +
        "In case you have an issue or a great recommentation in your mind, " +
        "please join the Group from the Channel and write it down! But take in mind " +
        "you can only speak in English, thanks!",
        style: subtitleTextStyle(context),
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(100)
          ),
          child: TextButton(
            onPressed: () async {
              launchUrlString("https://t.me/songtubechannel");
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text('Join!', style: smallTextStyle(context).copyWith(color: Colors.white)),
            )
          ),
        )
      ],
    );
  }
}