import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/info_item_renderer.dart';
import 'package:songtube/ui/sheets/channel_suggestions.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/channel_tile.dart';
import 'package:songtube/ui/tiles/shimmer_tile.dart';

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
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 80,
            child: ListView.builder(
              clipBehavior: Clip.none,
              padding: const EdgeInsets.only(left: 12),
              scrollDirection: Axis.horizontal,
              itemCount: contentProvider.channelSuggestions.length+1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Bounce(
                    duration: kAnimationShortDuration,
                    onPressed: () {
                      showModalBottomSheet(
                        context: internalNavigatorKey.currentContext!,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const ChannelSuggestions());
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const AppAnimatedIcon(Icons.add),
                          Text(Languages.of(context)!.labelMore, style: tinyTextStyle(context).copyWith(letterSpacing: 0.2)),
                        ],
                      ),
                    ),
                  );
                } else {
                  final channel = contentProvider.channelSuggestions[index-1];
                  return ChannelTile(
                    channel: ChannelInfoItem(channel.url, channel.name, '', '', null, -1),
                    size: ChannelTileSize.small,
                    forceHighQuality: true,
                  );
                }
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final video = contentProvider.trendingVideos![index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
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
      
      itemCount: 20,
      padding: const EdgeInsets.only(top: 12),
      itemBuilder: (context, index) {
        return const ShimmerTile();
      },
    );
  }

}