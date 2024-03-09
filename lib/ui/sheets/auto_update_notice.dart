import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/ui/components/common_sheet_widget.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/setting_tile.dart';

class AutoUpdateNoticeSheet extends StatefulWidget {
  const AutoUpdateNoticeSheet({super.key});

  @override
  State<AutoUpdateNoticeSheet> createState() => _AutoUpdateNoticeSheetState();
}

class _AutoUpdateNoticeSheetState extends State<AutoUpdateNoticeSheet> {
  @override
  Widget build(BuildContext context) {
    return CommonSheet(
      useCustomScroll: false,
      builder: (context, _) {
        return CommonSheetWidget(
          title: 'In-App Updates',
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  style: subtitleTextStyle(context, opacity: 0.6),
                  children: [
                    const TextSpan(
                      text: 'SongTube performs an update check every time the app is opened, and its made from it\'s GitHub repo '
                    ),
                    TextSpan(
                      text: 'https://github.com/SongTube/SongTube-App',
                      style: subtitleTextStyle(context).copyWith(
                        color: Theme.of(context).primaryColor.withOpacity(0.8)
                      ),
                    ),
                    const TextSpan(
                      text: '. This allow us to inform you of the newest '
                        'version as soon as its out, allowing you to download and install it in-app.\n\n'
                        'This feature is enabled by default, but you can opt-out from this using the switch bellow.',
                    ),
                  ]
                ),
              ),
              AnimatedContainer(
                duration: kAnimationDuration,
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(AppSettings.enableInAppUpdates ? 0.1 : 0),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: SettingTileCheckbox(
                  value: AppSettings.enableInAppUpdates,
                  title: 'In-App Updates',
                  subtitle: 'Allow songtube to check for updates in the background',
                  leadingIcon: LineIcons.checkCircle,
                  onChange: (value) {
                    setState(() {
                      AppSettings.enableInAppUpdates = value;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}