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
      padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.center,
            child: BottomSheetPhill()),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text('${Languages.of(context)!.labelCurrentQuality}:   ${widget.currentQuality.resolution}p', style: textStyle(context)),
                    if (widget.currentQuality.framerate > 30)
                    Text(' ${widget.currentQuality.framerate.round()}FPS', style: smallTextStyle(context, bold: true).copyWith(color: Theme.of(context).primaryColor))
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Ionicons.flash_outline, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 6),
                    Expanded(child: Text('${Languages.of(context)!.labelFastStreamingOptions}:', style: subtitleTextStyle(context).copyWith(fontSize: 16))),
                  ],
                ),
                videoOptions(),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Ionicons.videocam_outline, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 6),
                    Expanded(child: Text('${Languages.of(context)!.labelStreamingOptions}:', style: subtitleTextStyle(context).copyWith(fontSize: 16))),
                  ],
                ),
                videoOnlyOptions()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget videoOptions() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: videoList.length,
      itemBuilder: (context, index) {
        return optionTile(videoList[index]);
      },
    );
  }

  Widget videoOnlyOptions() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: videoOnlyList.length,
      itemBuilder: (context, index) {
        return optionTile(videoOnlyList[index]);
      },
    );
  }

  Widget optionTile(VideoPlaybackQuality quality) {
    return ListTile(
      title: Row(
        children: [
          Text('${quality.resolution}p', style: subtitleTextStyle(context)),
          if (quality.framerate > 30)
          Text(' ${quality.framerate.round()}FPS', style: smallTextStyle(context, bold: true).copyWith(color: Theme.of(context).primaryColor))
        ],
      ),
      onTap: () {
        widget.onChangeQuality(quality);
        Navigator.pop(context);
      },
    );
  }

}