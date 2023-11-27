
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/extractors/trending.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/cache_utils.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/animations/fade_in.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/channel_tile.dart';

class ChannelSuggestions extends StatefulWidget {
  const ChannelSuggestions({super.key});

  @override
  _ChannelSuggestionsState createState() => _ChannelSuggestionsState();
}

class _ChannelSuggestionsState extends State<ChannelSuggestions> {

  bool fetchingChannels = false;

  List<YoutubeChannel> channels = [];

  @override
  void initState() {
    generateChannelRecommendations(
      Provider.of<ContentProvider>(context, listen: false).trendingVideos
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonSheet(
      useCustomScroll: channels.isNotEmpty,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(12.0).copyWith(bottom: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const AppAnimatedIcon(Iconsax.arrow_left, size: 22)
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(Languages.of(context)!.labelChannelSuggestions, style: textStyle(context, bold: false))),
                ],
              ),
              const SizedBox(height: 12),
              channels.isNotEmpty ? Expanded(
                child: _channelList(scrollController!),
              ) : Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 32),
                child: _loadingIndicator(),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _channelList(ScrollController controller) {
    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.only(top: 4),
      itemCount: channels.length,
      itemBuilder: (context, index) {
        YoutubeChannel channel = channels[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: FadeInTransition(child: ChannelTile(channel: channel.toChannelInfoItem(), size: ChannelTileSize.big, disablePaddings: true)),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<MediaProvider>(
            builder: (context, provider, _) {
              return SizedBox(
                height: 25, width: 25,
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(provider.currentColors.vibrant))
              );
            }
          ),
          const SizedBox(height: 12),
          Text(
            Languages.of(context)!.labelFetchingChannels,
            style: smallTextStyle(context, opacity: 0.6)
          )
        ],
      ),
    );
  }

  // Generate a list of YoutubeChannels extracting channels from multiple sources
  Future<void> generateChannelRecommendations(List<StreamInfoItem>? trendingPage) async {
    setState(() {
      fetchingChannels = true;
    });
    List<StreamInfoItem>? trendingVideos = trendingPage;

    //If trending page videos are null, extract manually the trending page
    if (trendingVideos == null) {
      trendingVideos = (await TrendingExtractor.getTrendingVideos()).take(20).toList();
    } else {
      trendingVideos = trendingVideos.take(20).toList();
    }

    // Extract channels from the recommended videos of your last watch history video
    if (CacheUtils.watchHistory.isNotEmpty) {
      StreamInfoItem lastWHVideo = CacheUtils.watchHistory.first;
      List<StreamInfoItem> watchHistoryRelatedVideos = (await VideoExtractor
        .getRelatedStreams(lastWHVideo.url!)).whereType<StreamInfoItem>().toList();
      for (var video in watchHistoryRelatedVideos) {
        // Check if this channel already exist in our recommended list, if not, add it
        if (channels.indexWhere((element) => element.name == video.uploaderName) == -1) {
          YoutubeChannel channel = await ChannelExtractor.channelInfo(video.uploaderUrl);
          channels.add(channel);
        }
        setState(() {});
      }
    }

    // Extract all channels from the trending page
    for (var video in trendingVideos) {
      // Check if this channel already exist in our recommended list, if not, add it
      if (channels.indexWhere((element) => element.name == video.uploaderName) == -1) {
        YoutubeChannel channel = await ChannelExtractor.channelInfo(video.uploaderUrl);
        setState(() => channels.add(channel));
      }
    }
    setState(() {
      fetchingChannels = false;
    });
  }

}