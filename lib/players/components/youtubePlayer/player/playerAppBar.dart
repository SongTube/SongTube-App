import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/preferencesProvider.dart';

class PlayerAppBar extends StatelessWidget {
  final List<dynamic> streams;
  final String videoTitle;
  final Function onChangeQuality;
  final Function onEnterPipMode;
  final String currentQuality;
  final bool audioOnly;
  PlayerAppBar({
    @required this.streams,
    @required this.videoTitle,
    @required this.onChangeQuality,
    @required this.currentQuality,
    @required this.audioOnly,
    this.onEnterPipMode
  });
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return Container(
      margin: EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(width: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(MdiIcons.circle, color: Colors.white, size: 16),
              Icon(MdiIcons.youtube, color: Colors.red, size: 32),
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "$videoTitle",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Product Sans',
                fontWeight: FontWeight.w600
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
          ),
          if (!audioOnly)
          SizedBox(width: 16),
          if (!audioOnly)
          FutureBuilder(
            future: DeviceInfoPlugin().androidInfo, 
            builder: (context, AsyncSnapshot<AndroidDeviceInfo> info) {
              if (info.hasData) {
                if (info.data.version.sdkInt >= 26) {
                  return GestureDetector(
                    onTap: onEnterPipMode,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      color: Colors.transparent,
                      child: Icon(
                        MdiIcons.pictureInPictureBottomRightOutline,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.all(4),
                    color: Colors.transparent,
                    child: Icon(
                      MdiIcons.pictureInPictureBottomRightOutline,
                      color: Colors.transparent,
                      size: 18,
                    ),
                  );
                }
              } else {
                return Container(
                  padding: EdgeInsets.all(4),
                  color: Colors.transparent,
                  child: Icon(
                    MdiIcons.pictureInPictureBottomRightOutline,
                    color: Colors.transparent,
                    size: 18,
                  ),
                );
              }
            }
          ),
          if (!audioOnly)
          SizedBox(width: 8),
          if (!audioOnly)
          GestureDetector(
            onTap: () => onChangeQuality(),
            child: Container(
              padding: EdgeInsets.all(4),
              color: Colors.transparent,
              child: Text(
                (
                  "${currentQuality.split('p').first+"p"}".split('•').last.trim() +
                  "${currentQuality.split('p').last.contains("60") ? " • 60 FPS" : ""}"
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Product Sans'
                ),
              )
            ),
          ),
          SizedBox(width: 8),
          Switch(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeThumbImage: AssetImage('assets/images/playArrow.png'),
            activeColor: Colors.white,
            activeTrackColor: Colors.white.withOpacity(0.6),
            inactiveThumbColor: Colors.white.withOpacity(0.6),
            inactiveTrackColor: Colors.white.withOpacity(0.2),
            value: prefs.youtubeAutoPlay,
            onChanged: (bool value) {
              prefs.youtubeAutoPlay = value;
            },
          ),
        ],
      ),
    );
  }
}