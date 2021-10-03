// Flutter
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/players/components/musicPlayer/currentPlaylist.dart';

// Internal
import 'package:songtube/players/components/musicPlayer/dialogs/settingsDialog.dart';
import 'package:songtube/players/components/musicPlayer/ui/marqueeWidget.dart';
import 'package:songtube/players/components/musicPlayer/ui/playerSlider.dart';
import 'package:songtube/players/components/musicPlayer/ui/randomButton.dart';
import 'package:songtube/players/components/musicPlayer/ui/repeatButton.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';


class PlayerControls extends StatelessWidget {
  final MediaItem mediaItem;
  final Color dominantColor;
  final Color vibrantColor;
  final Color textColor;
  final bool playing;
  final PlaybackState state;
  PlayerControls({
    @required this.mediaItem,
    @required this.dominantColor,
    @required this.vibrantColor,
    @required this.textColor,
    @required this.playing,
    @required this.state
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Title
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: MarqueeWidget(
              animationDuration: Duration(seconds: 10),
              backDuration: Duration(seconds: 5),
              pauseDuration: Duration(seconds: 2),
              direction: Axis.horizontal,
              child: Text(
                mediaItem?.title ?? '',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  fontFamily: "YTSans",
                  color: textColor
                ),
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
          ),
          // Artist
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 8),
            child: Text(
              mediaItem?.artist ?? "",
              style: TextStyle(
                color: textColor.withOpacity(0.6),
                fontFamily: "YTSans",
                fontSize: 16
              ),
            ),
          ),
          // Progress Indicator
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: PlayerSlider(
              state: state,
              mediaItem: mediaItem,
              sliderColor: vibrantColor,
              textColor: textColor
            )
          ),
          // MediaControls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Random Button
              MusicPlayerRandomButton(
                iconColor: textColor,
                enabledColor: vibrantColor
              ),
              // Previous button
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: textColor.withOpacity(0.7)
                ),
                onPressed: () => AudioService.skipToPrevious(),
              ),
              // Padding
              SizedBox(width: 20),
              // Play/Pause button
              GestureDetector(
                onTap: playing
                  ? () => AudioService.pause()
                  : () => AudioService.play(),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  height: 60,
                  width: 60,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: dominantColor,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: Offset(0,3),
                        blurRadius: 8,
                        spreadRadius: 1 
                      )
                    ]
                  ),
                  child: playing
                    ? Icon(Icons.pause, size: 25, 
                        color: dominantColor.computeLuminance() > 0.5
                          ? Colors.black : Colors.white
                      )
                    : Icon(Icons.play_arrow, size: 25,
                        color: dominantColor.computeLuminance() > 0.5
                          ? Colors.black : Colors.white
                      )
                ),
              ),
              // Padding
              SizedBox(width: 20),
              // Next button
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: textColor.withOpacity(0.7)
                ),
                onPressed: () => AudioService.skipToNext(),
              ),
              // Repeat Button
              MusicPlayerRepeatButton(
                iconColor: textColor,
                enabledColor: vibrantColor
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: Icon(
                      MdiIcons.playlistMusicOutline,
                      color: textColor.withOpacity(0.6)
                    ),
                    onPressed: () {
                      Navigator.push(context, 
                        BlurPageRoute(builder: (context) {
                          return MusicPlayerCurrentPlaylist(
                            blurUIEnabled: Provider.of<PreferencesProvider>
                              (context, listen: false).enableBlurUI,
                          );
                        },
                          duration: Duration(milliseconds: 400),
                          blurStrength: Provider.of<PreferencesProvider>
                            (context, listen: false).enableBlurUI ? 20 : 0,
                          useCardExit: Provider.of<PreferencesProvider>
                            (context, listen: false).enableBlurUI,
                        ));
                    },
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: IconButton(
                    icon: Icon(
                      EvaIcons.dropletOutline,
                      color: textColor.withOpacity(0.6)
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => MusicPlayerSettingsDialog(),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}