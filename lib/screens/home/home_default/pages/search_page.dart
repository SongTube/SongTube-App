import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/ui/components/infinite_scrolling_adapter.dart';
import 'package:songtube/ui/info_item_renderer.dart';
import 'package:songtube/ui/tiles/channel_tile.dart';
import 'package:songtube/ui/tiles/shimmer_tile.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    ContentProvider contentProvider = Provider.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: contentProvider.searchContent != null
        ? _contentList(context)
        : _shimmerList()
    );
  }
  
  Widget _contentList(context) {
    ContentProvider contentProvider = Provider.of(context);
    final list = <dynamic>[...contentProvider.searchContent!.searchPlaylists!, ...contentProvider.searchContent!.searchVideos!];
    return InfiniteScrollingAdapter(
      onReachingEnd: () {
        contentProvider.searchContentLoadNextPage();
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: appBarSize(context))),
          if (contentProvider.searchContent!.searchChannels?.isNotEmpty ?? false)
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ChannelTile(
                channel: contentProvider.searchContent!.searchChannels![index],
                size: ChannelTileSize.big,
                margin: const EdgeInsets.all(12).copyWith(top: 0),
              );
            }, childCount: contentProvider.searchContent!.searchChannels!.length),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = list[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InfoItemRenderer(
                  infoItem: item,
                  expandItem: true,
                ),
              );
            }, childCount: list.length)
          ),
          SliverToBoxAdapter(child: SizedBox(height: audioHandler.mediaItem.value != null ? (kToolbarHeight*1.6)+24 : 24))
        ]
      ),
    );
  }

  Widget _shimmerList() {
    return ListView.builder(
      itemCount: 20,
      padding: const EdgeInsets.only(top: 0),
      itemBuilder: (context, index) {
        return const ShimmerTile();
      },
    );
  }

}