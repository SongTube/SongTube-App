import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/stream_tile.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    ContentProvider contentProvider = Provider.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: contentProvider.favoriteVideos.isEmpty
        ? _emptyPage(context)
        : _list(context),
    );
  }
  
  Widget _list(context) {
    ContentProvider contentProvider = Provider.of(context);
    final favorites = contentProvider.favoriteVideos;
    return ListView.builder(
      padding: const EdgeInsets.only(top: 12),
      physics: const BouncingScrollPhysics(),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: StreamTileExpanded(
            stream: favorites[index]),
        );
      },
    );
  }

  Widget _emptyPage(context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Ionicons.star, size: 64),
        const SizedBox(height: 8),
        Text(Languages.of(context)!.labelNoFavoriteVideos, style: textStyle(context)),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Text(Languages.of(context)!.labelNoFavoriteVideosDescription, style: subtitleTextStyle(context, opacity: 0.6), textAlign: TextAlign.center,),
        ),
      ],
    ));
  }

}