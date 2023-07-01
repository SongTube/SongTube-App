import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
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
    super.key});
  final ContentWrapper content;
  final VideoPlaybackQuality currentQuality;
  final Function(VideoPlaybackQuality) onChangeQuality;
  @override
  State<PlaybackQualitySheet> createState() => _PlaybackQualitySheetState();
}

class _PlaybackQualitySheetState extends State<PlaybackQualitySheet> {

  List<VideoPlaybackQuality> get videoList => widget.content.videoOptions!.reversed.toList();

  List<VideoPlaybackQuality> get videoOnlyList => widget.content.videoOnlyOptions!;

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
        physics: const BouncingScrollPhysics(),
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
        physics: const BouncingScrollPhysics(),
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