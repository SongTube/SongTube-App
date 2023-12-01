import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/colors_palette.dart';
import 'package:songtube/internal/models/content_wrapper.dart';
import 'package:songtube/internal/models/playback_quality.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/animations/animated_text.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/text_styles.dart';

class PlaybackQualitySheet extends StatefulWidget {
  const PlaybackQualitySheet({
    required this.content,
    required this.currentQuality,
    required this.onChangeQuality,
    required this.currentPlaybackSpeed,
    required this.onPlaybackSpeedChange,
    super.key});
  final ContentWrapper content;
  final double currentPlaybackSpeed;
  final Function(double) onPlaybackSpeedChange;
  final VideoPlaybackQuality currentQuality;
  final Function(VideoPlaybackQuality) onChangeQuality;
  @override
  State<PlaybackQualitySheet> createState() => _PlaybackQualitySheetState();
}

class _PlaybackQualitySheetState extends State<PlaybackQualitySheet> {

  List<VideoPlaybackQuality> get videoList => widget.content.videoOptions!.reversed.toList();

  List<VideoPlaybackQuality> get videoOnlyList => widget.content.videoOnlyOptions!;

  // Playback speed values
  final List<double> values = [0.25, 0.5, 0.75, 1.0, 1.25, 1.50, 1.75, 2.0];
  late int playbackSpeedIndex = values.indexWhere((element) => element == widget.currentPlaybackSpeed);

  SliderThemeData sliderTheme(ColorsPalette colors) {
    return SliderThemeData(
      thumbColor: colors.vibrant,
      activeTrackColor: colors.vibrant,
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(
        disabledThumbRadius: 5,
        enabledThumbRadius: 5
      ),
      inactiveTickMarkColor: colors.vibrant,
      inactiveTrackColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of(context);
    return CommonSheet(
      useCustomScroll: false,
      builder: (context, scrollController) {
        return Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const AppAnimatedIcon(Iconsax.arrow_left, size: 22)
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(Languages.of(context)!.labelPlayerSettings, style: textStyle(context, bold: false))),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                // Video playback speed
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Text(Languages.of(context)!.labelPlaybackSpeed, style: subtitleTextStyle(context)),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    children: [
                      Text('${Languages.of(context)!.labelCurrent}: ', style: subtitleTextStyle(context, opacity: 0.6).copyWith(fontSize: 14)),
                      AnimatedText('x${values[playbackSpeedIndex].toStringAsFixed(2)}', style: subtitleTextStyle(context).copyWith(letterSpacing: 1), auto: true),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    children: [
                      Text('0.25', style: tinyTextStyle(context, opacity: 0.6).copyWith(letterSpacing: 1)),
                      Expanded(
                        child: SliderTheme(
                          data: sliderTheme(mediaProvider.currentColors),
                          child: Slider(
                            value: playbackSpeedIndex.toDouble(),
                            min: 0,
                            max: values.length - 1,
                            divisions: values.length - 1,
                            onChanged: (index) {
                              setState(() {
                                playbackSpeedIndex = index.toInt();
                              });
                            },
                            onChangeEnd: (index) {
                              widget.onPlaybackSpeedChange(values[index.toInt()]);
                            },
                          )
                        ),
                      ),
                      Text('2.00', style: tinyTextStyle(context, opacity: 0.6).copyWith(letterSpacing: 1)),
                    ],
                  ),
                ),
                // Video current quality
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Text(Languages.of(context)!.labelCurrentQuality, style: subtitleTextStyle(context)),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Text('${Languages.of(context)!.labelFastStreamingOptions}:', style: subtitleTextStyle(context, opacity: 0.6).copyWith(fontSize: 14)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: videoOptions(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Text('${Languages.of(context)!.labelStreamingOptions}:', style: subtitleTextStyle(context, opacity: 0.6).copyWith(fontSize: 14)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: videoOnlyOptions(),
                )
              ],
            ),
          ],
        );
      }
    );
  }

  Widget videoOptions() {
    return SizedBox(
      height: kToolbarHeight,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          return optionTile(videoList[index]);
        },
      ),
    );
  }

  Widget videoOnlyOptions() {
    return SizedBox(
      height: kToolbarHeight,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: videoOnlyList.length,
        itemBuilder: (context, index) {
          return optionTile(videoOnlyList[index]);
        },
      ),
    );
  }

  Widget optionTile(VideoPlaybackQuality quality) {
    MediaProvider mediaProvider = Provider.of(context);
    final selected = widget.currentQuality == quality;
    return GestureDetector(
      onTap: () {
        widget.onChangeQuality(quality);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(0).copyWith(left: 24, right: 24),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: selected ? mediaProvider.currentColors.vibrant?.withOpacity(0.07) : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            AnimatedText('${quality.resolution}p', style: subtitleTextStyle(context, opacity: 0.6).copyWith(fontSize: 14), auto: selected, opacity: selected ? 1 : 0.6),
            if (quality.framerate > 30)
            AnimatedText(' ${quality.framerate.round()}FPS', style: smallTextStyle(context).copyWith(fontSize: 14), auto: true)
          ],
        ),
      ),
    );
  }

}