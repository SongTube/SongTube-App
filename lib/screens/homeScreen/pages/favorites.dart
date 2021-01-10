import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/screens/homeScreen/components/homePageFavoritesEmpty.dart';
import 'package:songtube/screens/homeScreen/components/videoTile.dart';
import 'package:songtube/ui/internal/snackbar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HomePageFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    if (prefs.favoriteVideos.isNotEmpty) {
      return ListView.builder(
        itemCount: prefs.favoriteVideos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16, top: index == 0 ? 12 : 0),
            child: VideoTile(
              searchItem: prefs.favoriteVideos[index],
              enableSaveToFavorites: false,
              enableSaveToWatchLater: true,
              onDelete: () {
                List<Video> videos = prefs.favoriteVideos;
                videos.removeAt(index);
                prefs.favoriteVideos = videos;
                AppSnack.showSnackBar(
                  icon: EvaIcons.alertCircleOutline,
                  title: "Video removed from Favorites",
                  context: context,
                  scaffoldKey: Scaffold.of(context)
                );
              },
            ),
          );
        }
      );
    } else {
      return HomePageFavoritesEmpty();
    }
  }
}