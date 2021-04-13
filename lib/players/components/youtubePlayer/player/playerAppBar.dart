import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:newpipeextractor_dart/models/streams/videoOnlyStream.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/internal/popupMenu.dart';

class PlayerAppBar extends StatelessWidget {
  final List<VideoOnlyStream> streams;
  final String videoTitle;
  final Function(String, String) onStreamSelect;
  final Function onEnterPipMode;
  final String currentQuality;
  PlayerAppBar({
    @required this.streams,
    @required this.videoTitle,
    @required this.onStreamSelect,
    @required this.currentQuality,
    this.onEnterPipMode
  });
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    List<String> qualities = [];
    streams.forEach((stream) {
      qualities.add(stream.formatSuffix + " • " + stream.resolution);
    });
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
          SizedBox(width: 16),
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
          SizedBox(width: 8),
          FlexiblePopupMenu(
            borderRadius: 10,
            child: Container(
              padding: EdgeInsets.all(4),
              color: Colors.transparent,
              child: Text(
                currentQuality+"p",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Product Sans'
                ),
              )
            ),
            items: List<FlexiblePopupItem>.generate(qualities.length, (index) {
              return FlexiblePopupItem(
                title: qualities[index],
                value: qualities[index]
              );
            }),
            onItemTap: (String value) {
              if (value == null) return;
              int index = streams.indexWhere((element) =>
                element.formatSuffix + " • " + element.resolution == value);
              onStreamSelect(streams[index].url, streams[index].resolution);
            }
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