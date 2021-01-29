import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:songtube/internal/models/infoSets/mediaInfoSet.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/routes/video.dart';
import 'package:songtube/routes/videoCollapsed.dart';

typedef FloatingWidgetCallback = void Function(double position);

class SlidableVideoPage extends StatefulWidget {
  final FloatingWidgetCallback callback;
  SlidableVideoPage({
    @required this.callback,
  });

  @override
  _SlidableVideoPageState createState() => _SlidableVideoPageState();
}

class _SlidableVideoPageState extends State<SlidableVideoPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ManagerProvider>(context, listen: false)
        .expandablePlayerPanelController.open();
    });
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    var borderRadius = 20.0;
    return SlidingUpPanel(
      controller: manager.expandablePlayerPanelController,
      minHeight: kToolbarHeight * 1.15,
      maxHeight: MediaQuery.of(context).size.height,
      isPanelVisible: true,
      margin: EdgeInsets.only(
        left: 12, right: 12,
        bottom: 12
      ),
      backdropColor: Colors.black,
      backdropEnabled: true,
      borderRadius: borderRadius,
      backdropBlurStrength: prefs.enableBlurUI ? 15 : 0,
      onPanelSlide: (double position) {
        widget.callback(position);
      },
      boxShadow: [
        BoxShadow(
          blurRadius: 5,
          offset: Offset(0,-5),
          color: Colors.black.withOpacity(0.05)
        )
      ],
      color: Theme.of(context).cardColor,
      panel: manager.mediaInfoSet.mediaType != null
        ? YoutubePlayerVideoPage(
            isPlaylist: manager.mediaInfoSet.mediaType == MediaInfoSetType.Playlist
              ? true : false,
          )
        : Container(),
      collapsed: GestureDetector(
        onTap: () {
          manager.expandablePlayerPanelController.open();
        },
        child: manager.mediaInfoSet.mediaType != null
          ? VideoPageCollapsed(
              isPlaylist: manager.mediaInfoSet.mediaType == MediaInfoSetType.Playlist
                ? true : false,
          )
          : Container()
      ),
    );
  }
}