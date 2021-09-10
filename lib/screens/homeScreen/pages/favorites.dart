import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/components/emptyIndicator.dart';
import 'package:songtube/ui/internal/snackbar.dart';
import 'package:songtube/ui/layout/streamsLargeThumbnail.dart';

class HomePageFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: prefs.favoriteVideos.isNotEmpty
        ? StreamsLargeThumbnailView(
            infoItems: prefs.favoriteVideos,
            allowSaveToFavorites: false,
            allowSaveToWatchLater: true,
            onDelete: (infoItem) {
              List<StreamInfoItem> videos = prefs.favoriteVideos;
              videos.removeWhere((element) => element.url == infoItem.url);
              prefs.favoriteVideos = videos;
              AppSnack.showSnackBar(
                icon: EvaIcons.alertCircleOutline,
                title: "Video removed from Favorites",
                context: context,
              );
            },
          )
        : Container(
            alignment: Alignment.topCenter,
            child: EmptyIndicator()
          )
    );
  }
}