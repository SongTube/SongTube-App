import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/ui/tiles/setting_tile.dart';

class VideoPlayerSettings extends StatefulWidget {
  const VideoPlayerSettings({super.key});

  @override
  State<VideoPlayerSettings> createState() => _VideoPlayerSettingsState();
}

class _VideoPlayerSettingsState extends State<VideoPlayerSettings> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: (kToolbarHeight * 1.6)+12),
      children: [
        // Automatic Picture-in-Picture mode
        SettingTileCheckbox(
          leadingIcon: Icons.picture_in_picture_alt_outlined,
          title: Languages.of(context)!.labelPictureInPicture,
          subtitle: Languages.of(context)!.labelPictureInPictureDescription,
          onChange: (value) => setState(() => AppSettings.enableAutoPictureInPictureMode = value),
          value: AppSettings.enableAutoPictureInPictureMode,
        ),
        // Background Playback (Alpha)
        const SizedBox(height: 12),
        SettingTileCheckbox(
          leadingIcon: LineIcons.playCircle,
          title: Languages.of(context)!.labelBackgroundPlaybackAlpha,
          subtitle: Languages.of(context)!.labelBackgroundPlaybackAlphaDescription,
          onChange: (value) => setState(() => AppSettings.enableBackgroundPlayback = value),
          value: AppSettings.enableBackgroundPlayback,
        ),
      ],
    );
  }
}