
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/extractors/trending.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/cache_utils.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/ui/sheet_phill.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.all(12).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom+12, top: kBottomNavigationBarHeight),
      padding: const EdgeInsets.all(16).copyWith(left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: BottomSheetPhill()),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(Ionicons.arrow_back_outline, color: Theme.of(context).primaryColor),
                  )
                ),
                Expanded(child: Text(Languages.of(context)!.labelChannelSuggestions, style: textStyle(context))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Divider(indent: 12, endIndent: 12, color: Theme.of(context).dividerColor, height: 1),
          channels.isNotEmpty ? Expanded(
            child: _channelList(),
          ) : Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16),
            child: _loadingIndicator(),
          )
        ],
      ),
    );
  }

  Widget _channelList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: channels.length,
      itemBuilder: (context, index) {
        YoutubeChannel channel = channels[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ChannelTile(channel: channel.toChannelInfoItem(), size: ChannelTileSize.big, disablePaddings: true),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 25, width: 25,
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor))
          ),
          const SizedBox(height: 8),
          Text(
            Languages.of(context)!.labelFetchingChannels,
            style: smallTextStyle(context)
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