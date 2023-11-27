import 'package:flutter/material.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/ui/components/common_sheet_widget.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class JoinTelegramSheet extends StatelessWidget {
  const JoinTelegramSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSheet(
      useCustomScroll: false,
      builder: (context, scrollController) {
        return CommonSheetWidget(
          title: 'Telegram Channel',
          body: Text(
            // ignore: prefer_interpolation_to_compose_strings
            "Step into the pulse of our app and join our vibrant Telegram community! " +
            "Get the latest app updates, sneak peeks into future features, and get the " +
            "inside scoop on all things app-related. Plus, we're always eager to hear your feedback and suggestions - so don't be shy!",
            style: subtitleTextStyle(context, opacity: 0.6),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                Languages.of(context)!.labelLater,
                style: subtitleTextStyle(context).copyWith(fontSize: 14)
              )),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15)
              ),
              child: TextButton(
                onPressed: () async {
                  launchUrl(Uri.parse("https://t.me/songtubechannel"), mode: LaunchMode.externalApplication);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Text('Preview Channel', style: subtitleTextStyle(context).copyWith(color: Colors.white, fontSize: 14)),
                )
              ),
            )
          ],
        );
      },
    );
  }
}