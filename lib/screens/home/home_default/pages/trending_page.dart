import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/channel_data.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/screens/channel.dart';
import 'package:songtube/ui/components/channel_image.dart';
import 'package:songtube/ui/info_item_renderer.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/channel_tile.dart';
import 'package:songtube/ui/tiles/shimmer_tile.dart';
import 'package:songtube/ui/tiles/stream_tile.dart';
import 'package:songtube/ui/ui_utils.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    ContentProvider contentProvider = Provider.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: contentProvider.trendingVideos != null
        ? _trendingList(context)
        : _shimmerList()
    );
  }
  
  Widget _trendingList(context) {
    ContentProvider contentProvider = Provider.of(context);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 52,
            child: ListView.builder(
              clipBehavior: Clip.none,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 12),
              scrollDirection: Axis.horizontal,
              itemCount: contentProvider.channelSuggestions.length,
              itemBuilder: (context, index) {
                final channel = contentProvider.channelSuggestions[index];
                return ChannelTile(
                  channel: ChannelInfoItem(channel.url, channel.name, '', '', null, -1),
                  size: ChannelTileSize.small,
                  forceHighQuality: true,
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final video = contentProvider.trendingVideos![index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: InfoItemRenderer(
                infoItem: video,
                expandItem: true,
              ),
            );
          }, childCount: contentProvider.trendingVideos!.length),
        )
      ],
    );
  }

  Widget _shimmerList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 20,
      padding: const EdgeInsets.only(top: 12),
      itemBuilder: (context, index) {
        return const ShimmerTile();
      },
    );
  }

}