import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/screens/homeScreen/components/videoTile.dart';
import 'package:songtube/ui/internal/snackbar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HomePageWatchLater extends StatelessWidget {
  final int index;
  HomePageWatchLater(this.index);
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: VideoTile(
        searchItem: prefs.watchLaterVideos[index],
        enableSaveToFavorites: true,
        enableSaveToWatchLater: false,
        onDelete: () {
          List<Video> videos = prefs.watchLaterVideos;
          videos.removeAt(index);
          prefs.watchLaterVideos = videos;
          AppSnack.showSnackBar(
            icon: EvaIcons.alertCircleOutline,
            title: "Video removed from Watch Later",
            context: context,
            scaffoldKey: Scaffold.of(context)
          );
        },
      ),
    );
  }
}