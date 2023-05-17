import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:songtube/internal/artwork_manager.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/ui/components/circular_check_box.dart';
import 'package:songtube/ui/sheets/snack_bar.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/setting_tile.dart';

class MusicPlayerSettings extends StatefulWidget {
  const MusicPlayerSettings({super.key});

  @override
  State<MusicPlayerSettings> createState() => _MusicPlayerSettingsState();
}

class _MusicPlayerSettingsState extends State<MusicPlayerSettings> {

  @override
  Widget build(BuildContext context) {
    AppSettings appSettings = Provider.of(context);
    return ListView(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      children: [
        // Music Player blur background
        SettingTileCheckbox(
          title: 'Blur Background',
          subtitle: 'Add blurred artwork background',
          value: appSettings.enableMusicPlayerBlur,
          onChange: (value) {
            appSettings.enableMusicPlayerBlur = value;
          },
          leadingIcon: Icons.blur_on,
        ),
        const SizedBox(height: 12),
        // Music Player blur background intensity
        SettingTileSlider(
          title: 'Blur intensity',
          subtitle: 'Change the blur intensity of the artwork background',
          leadingIcon: Icons.blur_linear,
          value: appSettings.musicPlayerBlurStrenght,
          min: 0.00001,
          max: 100,
          valueTrailingString: '%',
          onChange: (value) {
            appSettings.musicPlayerBlurStrenght = value;
          }
        ),
        const SizedBox(height: 12),
        // Music Player blur background intensity
        SettingTileSlider(
          title: 'Backdrop opacity',
          subtitle: 'Change the colored backdrop opacity',
          leadingIcon: Icons.opacity_rounded,
          value: appSettings.musicPlayerBackdropOpacity*100,
          min: 0,
          max: 100,
          valueTrailingString: '%',
          onChange: (value) {
            appSettings.musicPlayerBackdropOpacity = value/100;
          }
        ),
        const SizedBox(height: 12),
        // Music Player Artwork Zoom
        SettingTileSlider(
          title: 'Artwork Scaling',
          subtitle: 'Scale out the music player artwork & background images',
          leadingIcon: Icons.zoom_out_map,
          value: appSettings.musicPlayerArtworkZoom*100,
          min: 100,
          max: 150,
          valueTrailingString: '%',
          onChange: (value) {
            appSettings.musicPlayerArtworkZoom = value/100;
          }
        ),
        const SizedBox(height: 12),
        // Music Player Background Parallax effect
        SettingTileCheckbox(
          title: 'Background Parallax',
          subtitle: 'Enable/Disable background image parallax effect',
          leadingIcon: Icons.animation,
          value: AppSettings.enableMusicPlayerBackgroundParallax,
          onChange: (value) {
            AppSettings.enableMusicPlayerBackgroundParallax = value;
            setState(() {});
          }
        ),
        const SizedBox(height: 12),
        // Restore thumbnails and artworks
        SettingTile(
          title: 'Restore thumbnails',
          subtitle: 'Force thumbnails and artwork generation process',
          leadingIcon: LineIcons.imageFile,
          onTap: () async {
            showSnackbar(
              customSnackBar: CustomSnackBar(
                leading: SizedBox(
                  width: 24, height: 24,
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)),
                ),
              title: 'Restoring artworks...'));
            final completer = Completer();
            final files = <File>[];
            songArtworkPath.list().listen((event) {
              files.add(File(event.path));
            }, onDone: () => completer.complete());
            await completer.future;
            for (final item in files) {
              await item.delete();
            }
            imageCache.clearLiveImages();
            imageCache.clear();
            showSnackbar(
              customSnackBar: const CustomSnackBar(
                icon: Icons.check,
                title: 'Restoring artworks is done!'));
          }
        )
      ],
    );
  }
}