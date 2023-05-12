import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/ui/tiles/setting_tile.dart';

class DownloadSettings extends StatefulWidget {
  const DownloadSettings({super.key});

  @override
  State<DownloadSettings> createState() => _DownloadSettingsState();
}

class _DownloadSettingsState extends State<DownloadSettings> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      children: [
        // Simultaneous download count
        SettingTileSlider(
          title: 'Simultaneous Downloads',
          subtitle: 'Define how many downloads can happen at the same time',
          leadingIcon: Ionicons.cloud_download_outline,
          value: AppSettings.maxSimultaneousDownloads.roundToDouble(),
          min: 1,
          max: 6,
          valueTrailingString: ' items',
          onChange: (double value) async {
            AppSettings.maxSimultaneousDownloads = value.round();
            setState(() {});
          },
        ),
        const SizedBox(height: 12),
        // Instant Download Format
        SettingTileDropdown(
          title: 'Instant Download Format',
          subtitle: 'Change the audio format for instant downloads',
          leadingIcon: Ionicons.flash_outline,
          currentValue: sharedPreferences.getString('instant_download_format') ?? 'AAC',
          items: const [
            DropdownMenuItem(
              value: "AAC",
              child: Text("AAC"),
            ),
            DropdownMenuItem(
              value: "OGG",
              child: Text("OGG"),
            )
          ],
          onChange: (String? value) async {
            if (value == "AAC") {
              await sharedPreferences.setString('instant_download_format', 'AAC');
              setState(() {});
            } else if (value == "OGG") {
              await sharedPreferences.setString('instant_download_format', 'OGG');
              setState(() {});
            }
          },
        )
      ],
    );
  }
}