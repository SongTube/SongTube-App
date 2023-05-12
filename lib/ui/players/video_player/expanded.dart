import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:songtube/internal/models/content_wrapper.dart';
import 'package:songtube/ui/players/video_player/playlist_content.dart';
import 'package:songtube/ui/players/video_player/video_content.dart';

class VideoPlayerExpanded extends StatefulWidget {
  const VideoPlayerExpanded({
    required this.content,
    super.key});
  final ContentWrapper content;
  @override
  State<VideoPlayerExpanded> createState() => _VideoPlayerExpandedState();
}

class _VideoPlayerExpandedState extends State<VideoPlayerExpanded> {

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: widget.content.infoItem is StreamInfoItem
        ?  _videoBody()
        : _playlistBody()
    );
  }

  Widget _videoBody() {
    return VideoPlayerContent(content: widget.content, videoDetails: widget.content.videoDetails);
  }

  Widget _playlistBody() {
    return VideoPlayerPlaylistContent(content: widget.content);
  }

}