import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreenYoutubeVideoPlayer extends StatelessWidget {
  final bool openPlayer;
  final String playerThumbnailUrl;
  final YoutubePlayerController playerController;
  final Function onPlayPressed;
  HomeScreenYoutubeVideoPlayer({
    @required this.openPlayer,
    @required this.playerController,
    @required this.playerThumbnailUrl,
    @required this.onPlayPressed
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: openPlayer
          ? YoutubePlayer(
              controller: playerController,
              progressColors: ProgressBarColors(
                playedColor: Colors.red,
                bufferedColor: Colors.white70,
                backgroundColor: Colors.transparent,
                handleColor: Theme.of(context).accentColor,
              ),
              progressIndicatorColor: Theme.of(context).accentColor,
              topActions: [
                PlayPauseButton()
              ],
              bottomActions: [
                CurrentPosition(),
                ProgressBar(isExpanded: true),
                RemainingDuration()
              ],
            )
          : AspectRatio(
            aspectRatio: 16/9,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  FadeInImage(
                    fadeInDuration: Duration(milliseconds: 300),
                    image: NetworkImage(playerThumbnailUrl),
                    placeholder: MemoryImage(kTransparentImage),
                    fit: BoxFit.fitWidth,
                  ),
                  Center(
                    child: Icon(MdiIcons.play, size: 60, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: onPlayPressed,
                    child: Center(
                      child: Icon(MdiIcons.youtube, size: 80, color: Colors.red),
                    ),
                  )
                ],
              )
            ),
          ),
      ),
    );
  }
}