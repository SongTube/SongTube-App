import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/extractors/trending.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/models/channel.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/avatarHandler.dart';
import 'package:songtube/pages/channel.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/animations/showUp.dart';
import 'package:songtube/ui/components/shimmerContainer.dart';
import 'package:songtube/ui/components/subscribeTile.dart';
import 'package:transparent_image/transparent_image.dart';

class ChannelRecommendationsSheet extends StatefulWidget {
  @override
  _ChannelRecommendationsSheetState createState() => _ChannelRecommendationsSheetState();
}

class _ChannelRecommendationsSheetState extends State<ChannelRecommendationsSheet> {

  bool fetchingChannels = false;

  List<YoutubeChannel> channels = [];

  @override
  void initState() {
    generateChannelRecommendations(
      Provider.of<ManagerProvider>(context, listen: false).homeTrendingVideoList
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.6,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15)
        )
      ),
      child: Column(
        children: [
          Theme(
            data: ThemeData(
              fontFamily: 'Product Sans',
            ),
            child: AppBar(
              centerTitle: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text("Add Channels", style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontWeight: FontWeight.w600
              )),
            ),
          ),
          ShowUpTransition(
            forward: fetchingChannels,
            slideSide: SlideFromSlide.BOTTOM,
            child: LinearProgressIndicator(
              minHeight: 2,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[600].withOpacity(0.1),
            indent: 12,
            endIndent: 12
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: channels.isEmpty
                ? _loadingIndicator()
                : _channelList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _channelList() {
    return ListView.builder(
      itemCount: channels.length,
      itemBuilder: (context, index) {
        YoutubeChannel channel = channels[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(context,
              BlurPageRoute(
                blurStrength: Provider.of<PreferencesProvider>
                  (context, listen: false).enableBlurUI ? 20 : 0,
                builder: (_) => 
                YoutubeChannelPage(
                  url: channel.url,
                  name: channel.name,
            )));
          },
          child: _channelWidget(channel)
        );
      },
    );
  }

  Widget _channelWidget(YoutubeChannel channel) {
    return ShowUpTransition(
      forward: true,
      slideSide: SlideFromSlide.BOTTOM,
      child: Container(
        margin: EdgeInsets.all(12),
        color: Colors.transparent,
        child: Row(
          children: [
            FutureBuilder(
              future: AvatarHandler.getAvatarUrl(channel.name, channel.url),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FadeInImage(
                      fadeInDuration: Duration(milliseconds: 300),
                      placeholder: MemoryImage(kTransparentImage),
                      image: FileImage(File(snapshot.data)),
                      height: 80,
                      width: 80,
                    ),
                  );
                } else {
                  return ShimmerContainer(
                    height: 80,
                    width: 80,
                    borderRadius: BorderRadius.circular(100),
                  );
                }
              },
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    channel.name,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontSize: 18,
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2
                    ),
                  ),
                  Text(
                    "${NumberFormat().format(channel.subscriberCount)} Subs",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontSize: 12,
                      fontFamily: 'Product Sans',
                    ),
                  )
                ],
              ),
            ),
            ChannelSubscribeComponent(
              channelName: channel.name,
              channel: channel,
              autoUpdate: false,
            )
          ],
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 120, width: 120,
            child: LoadingIndicator(
              indicatorType: Indicator.orbit,
              color: Theme.of(context).accentColor),
          ),
          SizedBox(height: 8),
          Text(
            "Fetching channels...",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Product Sans',
              color: Theme.of(context).iconTheme.color
                .withOpacity(0.6)
            ),
          )
        ],
      ),
    );
  }

  // Generate a list of YoutubeChannels extracting channels from multiple sources
  Future<void> generateChannelRecommendations(List<StreamInfoItem> trendingPage) async {
    setState(() {
      fetchingChannels = true;
    });
    List<StreamInfoItem> trendingVideos = trendingPage;

    //If trending page videos are null, extract manually the trending page
    if (trendingVideos == null) {
      trendingVideos = (await TrendingExtractor.getTrendingVideos()).take(20).toList();
    } else {
      trendingVideos = trendingVideos.take(20).toList();
    }

    // Extract channels from the recommended videos of your last watch history video
    if (Provider.of<PreferencesProvider>(context, listen: false).watchHistory.isNotEmpty) {
      StreamInfoItem lastWHVideo = Provider.of<PreferencesProvider>
        (context, listen: false).watchHistory.first;
      List<StreamInfoItem> watchHistoryRelatedVideos = await VideoExtractor
        .getRelatedStreams(lastWHVideo.url);
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