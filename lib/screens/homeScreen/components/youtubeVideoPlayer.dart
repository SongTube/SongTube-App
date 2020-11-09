import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class HomeScreenYoutubeVideoPlayer extends StatelessWidget {
  final bool openPlayer;
  final String playerThumbnailUrl;
  final YoutubePlayerController playerController;
  HomeScreenYoutubeVideoPlayer({
    this.openPlayer = true,
    @required this.playerController,
    @required this.playerThumbnailUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AnimatedSwitcher(
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
                  image: NetworkImage(playerThumbnailUrl),
                  placeholder: MemoryImage(kTransparentImage),
                  fit: BoxFit.fitWidth,
                )
              ),
            ),
        ),
      ),
    );
  }
}