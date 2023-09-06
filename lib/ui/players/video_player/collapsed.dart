import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/content_wrapper.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/ui/text_styles.dart';

class VideoPlayerCollapsed extends StatefulWidget {
  const VideoPlayerCollapsed({
    required this.content,
    super.key});
  final ContentWrapper content;

  @override
  State<VideoPlayerCollapsed> createState() => _VideoPlayerCollapsedState();
}

class _VideoPlayerCollapsedState extends State<VideoPlayerCollapsed> {
  
  @override
  Widget build(BuildContext context) {
    ContentProvider contentProvider = Provider.of(context);
    final playerController = contentProvider.playingContent!.videoPlayerController.videoPlayerController;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.content.infoItem is StreamInfoItem ? (widget.content.infoItem.name ?? '') : (widget.content.videoDetails?.videoInfo.name ?? ''),
                style: smallTextStyle(context).copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                widget.content.infoItem is StreamInfoItem ? (widget.content.infoItem.uploaderName ?? '') : (widget.content.videoDetails?.videoInfo.uploaderName ?? ''),
                style: tinyTextStyle(context, opacity: 0.8),
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
              ),
            ],
          ),
        ),
        Semantics(
          label: (playerController?.value.isPlaying ?? false) ? 'Pause' : 'Play',
          child: IconButton(
            icon: Icon((playerController?.value.isPlaying ?? false) ? Ionicons.pause_outline : Ionicons.play_outline, size: 20),
            onPressed: () async {
              if ((playerController?.value.isPlaying ?? false)) {
                await playerController?.pause();
              } else {
                await playerController?.play();
              }
              setState(() {});
            }
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}