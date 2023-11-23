import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/artwork_manager.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/ui/sheets/snack_bar.dart';
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
      
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: (kToolbarHeight * 1.6)+12),
      children: [
        // Music Player blur background
        SettingTileCheckbox(
          title: Languages.of(context)!.labelBlurBackground,
          subtitle: Languages.of(context)!.labelBlurBackgroundDescription,
          value: appSettings.enableMusicPlayerBlur,
          onChange: (value) {
            appSettings.enableMusicPlayerBlur = value;
          },
          leadingIcon: Icons.blur_on,
        ),
        const SizedBox(height: 12),
        // Music Player blur background intensity
        SettingTileSlider(
          title: Languages.of(context)!.labelBlurIntensity,
          subtitle: Languages.of(context)!.labelBlurIntensityDescription,
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
        // Music Player Backdrop color intensity
        SettingTileSlider(
          title: Languages.of(context)!.labelBackdropOpacity,
          subtitle: Languages.of(context)!.labelBackdropOpacityDescription,
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
        // Music Player Artwork Shadow Level
        SettingTileSlider(
          title: Languages.of(context)!.labelArtworkShadowOpacity,
          subtitle: Languages.of(context)!.labelArtworkShadowOpacityDescription,
          leadingIcon: Icons.texture,
          value: (AppSettings.musicPlayerArtworkShadowLevel*100).roundToDouble(),
          min: 0,
          max: 100,
          valueTrailingString: '%',
          onChange: (value) {
            AppSettings.musicPlayerArtworkShadowLevel = value/100;
            setState(() {});
          }
        ),
        const SizedBox(height: 12),
        // Music Player Artwork Shadow Radius
        SettingTileSlider(
          title: Languages.of(context)!.labelArtworkShadowRadius,
          subtitle: Languages.of(context)!.labelArtworkShadowRadiusDescription,
          leadingIcon: Icons.blur_circular,
          value: AppSettings.musicPlayerArtworkShadowRadius.roundToDouble(),
          min: 0,
          max: 40,
          valueTrailingString: '',
          onChange: (value) {
            AppSettings.musicPlayerArtworkShadowRadius = value.round();
            setState(() {});
          }
        ),
        const SizedBox(height: 12),
        // Music Player Artwork Zoom
        SettingTileSlider(
          title: Languages.of(context)!.labelArtworkScaling,
          subtitle: Languages.of(context)!.labelArtworkScalingDescription,
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
          title: Languages.of(context)!.labelBackgroundParallax,
          subtitle: Languages.of(context)!.labelBackgroundParallaxDescription,
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
          title: Languages.of(context)!.labelRestoreThumbnails,
          subtitle: Languages.of(context)!.labelRestoreThumbnailsDescription,
          leadingIcon: LineIcons.imageFile,
          onTap: () async {
            showSnackbar(
              customSnackBar: CustomSnackBar(
                leading: SizedBox(
                  width: 24, height: 24,
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)),
                ),
              title: Languages.of(context)!.labelRestoringArtworks));
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
              customSnackBar: CustomSnackBar(
                icon: Icons.check,
                title: Languages.of(context)!.labelRestoringArtworksDone));
          }
        )
      ],
    );
  }
}