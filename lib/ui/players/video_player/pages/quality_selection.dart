import 'package:flutter/material.dart';
import 'package:songtube/internal/models/content_wrapper.dart';
import 'package:songtube/internal/models/playback_quality.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/ui/sheet_phill.dart';
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

  SliderThemeData sliderTheme() {
    return SliderThemeData(
      thumbColor: Theme.of(context).primaryColor,
      activeTrackColor: Theme.of(context).primaryColor,
      trackHeight: 6,
      thumbShape: const RoundSliderThumbShape(
        disabledThumbRadius: 7,
        enabledThumbRadius: 7
      ),
      inactiveTickMarkColor: Theme.of(context).primaryColor,
      inactiveTrackColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.only(top: 16, left: 16),
      child: Wrap(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: BottomSheetPhill(),
            )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Video playback speed
              Text(Languages.of(context)!.labelPlaybackSpeed, style: textStyle(context)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text('${Languages.of(context)!.labelCurrent}: ', style: subtitleTextStyle(context, opacity: 0.7)),
                  Text('x${values[playbackSpeedIndex].toStringAsFixed(2)}', style: subtitleTextStyle(context).copyWith(color: Theme.of(context).primaryColor)),
                ],
              ),
              Row(
                children: [
                  Text('0.25', style: smallTextStyle(context, opacity: 0.7)),
                  Expanded(
                    child: SliderTheme(
                      data: sliderTheme(),
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
                  Text('2.00', style: smallTextStyle(context, opacity: 0.7)),
                  const SizedBox(width: 16),
                ],
              ),
              // Video current quality
              Text(Languages.of(context)!.labelCurrentQuality, style: textStyle(context)),
              const SizedBox(height: 6),
              Text('${Languages.of(context)!.labelFastStreamingOptions}:', style: subtitleTextStyle(context, opacity: 0.7)),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: videoOptions(),
              ),
              Text('${Languages.of(context)!.labelStreamingOptions}:', style: subtitleTextStyle(context, opacity: 0.7)),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: videoOnlyOptions(),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget videoOptions() {
    return SizedBox(
      height: kToolbarHeight,
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
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
        padding: const EdgeInsets.all(0),
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
    final selected = widget.currentQuality == quality;
    return GestureDetector(
      onTap: () {
        widget.onChangeQuality(quality);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(8).copyWith(left: 16, right: 16),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).primaryColor : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.06), width: 1.5)
        ),
        child: Row(
          children: [
            Text('${quality.resolution}p', style: subtitleTextStyle(context, bold: selected ? true : false)),
            if (quality.framerate > 30)
            Text(' ${quality.framerate.round()}FPS', style: smallTextStyle(context, bold: true).copyWith(color: Theme.of(context).primaryColor))
          ],
        ),
      ),
    );
  }

}