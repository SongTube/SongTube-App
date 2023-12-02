import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:songtube/languages/languages.dart';
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
      
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: (kToolbarHeight * 1.6)+12),
      children: [
        // Simultaneous download count
        SettingTileSlider(
          title: Languages.of(context)!.labelSimultaneousDownloads,
          subtitle: Languages.of(context)!.labelSimultaneousDownloadsDescription,
          leadingIcon: Ionicons.cloud_download_outline,
          value: AppSettings.maxSimultaneousDownloads.roundToDouble(),
          min: 1,
          max: 6,
          valueTrailingString: ' ${Languages.of(context)!.labelItems}',
          onChange: (double value) async {
            AppSettings.maxSimultaneousDownloads = value.round();
            setState(() {});
          },
        ),
        const SizedBox(height: 12),
        // Instant Download Format
        SettingTileDropdown(
          title: Languages.of(context)!.labelInstantDownloadFormat,
          subtitle: Languages.of(context)!.labelInstantDownloadFormatDescription,
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
        ),
        // Download Audio Path
        SettingTile(
          title: Languages.of(context)!.labelAudioFolder,
          subtitle: '${Languages.of(context)!.labelCurrent}: ${AppSettings.musicDirectory.path}',
          leadingIcon: Iconsax.folder,
          onTap: () async {
            final result = await FilePicker.platform.getDirectoryPath();
            if (result != null && result != '/') {
              AppSettings.musicDirectory = Directory(result);
              setState(() {});
            }
          }
        ),
        // Download Video Path
        SettingTile(
          title: Languages.of(context)!.labelVideoFolder,
          subtitle: '${Languages.of(context)!.labelCurrent}: ${AppSettings.videoDirectory.path}',
          leadingIcon: Iconsax.folder,
          onTap: () async {
            final result = await FilePicker.platform.getDirectoryPath();
            if (result != null && result != '/') {
              AppSettings.videoDirectory = Directory(result);
              setState(() {});
            }
          }
        ),
      ],
    );
  }
}