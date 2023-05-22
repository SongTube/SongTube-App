import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/ui/components/circular_check_box.dart';
import 'package:songtube/ui/tiles/setting_tile.dart';

import '../../ui/text_styles.dart';

class GeneralSettings extends StatefulWidget {
  const GeneralSettings({super.key});

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  
  UiProvider get uiProvider => Provider.of(context, listen: false);

  void updateThemeMode({bool system = false}) {
    if (system) {
      if (uiProvider.themeMode != ThemeMode.system) {
        uiProvider.updateThemeMode(ThemeMode.system);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Theme.of(context).brightness
        ));
      } else {
        uiProvider.updateThemeMode(ThemeMode.light);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Theme.of(context).brightness
        ));
      }
    } else {
      if (uiProvider.themeMode == ThemeMode.dark) {
        uiProvider.updateThemeMode(ThemeMode.light);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Theme.of(context).brightness
        ));
      } else {
        uiProvider.updateThemeMode(ThemeMode.dark);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarColor: Colors.transparent
        ));
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: (kToolbarHeight * 1.6)+12),
      children: [
        // Use System Theme
        SettingTileCheckbox(
          leadingIcon: LineIcons.brush,
          title: Languages.of(context)!.labelUseSystemTheme,
          subtitle: Languages.of(context)!.labelUseSystemThemeJustification,
          onChange: (_) => updateThemeMode(system: true),
          value: uiProvider.themeMode == ThemeMode.system,
        ),
        const SizedBox(height: 12),
        // Dark mode
        SettingTileCheckbox(
          leadingIcon: LineIcons.moon,
          title: Languages.of(context)!.labelEnableDarkTheme,
          subtitle: Languages.of(context)!.labelEnableDarkThemeJustification,
          onChange: (_) => updateThemeMode(),
          value: uiProvider.themeMode == ThemeMode.dark,
          enabled: uiProvider.themeMode != ThemeMode.system,
        ),
        const SizedBox(height: 12),
        // Enable/Disable Watch History
        SettingTileCheckbox(
          leadingIcon: Iconsax.video_play,
          title: Languages.of(context)!.labelPauseWatchHistory,
          subtitle: Languages.of(context)!.labelPauseWatchHistoryDescription,
          onChange: (_) {
            AppSettings.enableWatchHistory = !AppSettings.enableWatchHistory;
            setState(() {});
          },
          value: !AppSettings.enableWatchHistory,
        ),
        // Lock Navigation Bar so it doesnt hide
        const SizedBox(height: 12),
        SettingTileCheckbox(
          title: Languages.of(context)!.labelLockNavigationBar,
          subtitle: Languages.of(context)!.labelLockNavigationBarDescription,
          leadingIcon: LineIcons.lock,
          value: AppSettings.lockNavigationBar,
          onChange: (value) {
            AppSettings.lockNavigationBar = value;
            setState(() {});
          }
        ),
        // Automatic Picture-in-Picture mode
        const SizedBox(height: 12),
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