import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideoPlayer extends StatelessWidget {
  final bool openPlayer;
  final String playerThumbnailUrl;
  final YoutubePlayerController playerController;
  YoutubeVideoPlayer({
    this.openPlayer = true,
    @required this.playerController,
    this.playerThumbnailUrl,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      child: openPlayer
        ? YoutubePlayerIFrame(
            controller: playerController,
            aspectRatio: 16/9,
          )
        : AspectRatio(
          aspectRatio: 16/9,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: FadeInImage(
              fadeInDuration: Duration(milliseconds: 300),
              image: playerThumbnailUrl != null
                ? NetworkImage(playerThumbnailUrl)
                : MemoryImage(kTransparentImage),
              placeholder: MemoryImage(kTransparentImage),
              fit: BoxFit.fitWidth,
            )
          ),
        ),
    );
  }
}