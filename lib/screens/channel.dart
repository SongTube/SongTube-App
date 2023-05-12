import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_fade/image_fade.dart';
import 'package:intl/intl.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:songtube/ui/components/channel_image.dart';
import 'package:songtube/ui/components/infinite_scrolling_adapter.dart';
import 'package:songtube/ui/components/subscribe_text.dart';
import 'package:songtube/ui/info_item_renderer.dart';
import 'package:songtube/ui/rounded_tab_indicator.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/stream_tile.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({
    required this.infoItem,
    super.key});
  final ChannelInfoItem infoItem;

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> with TickerProviderStateMixin {

  // TabBar Controller
  late TabController tabController = TabController(length: 3, vsync: this);

  // Channel Details
  YoutubeChannel? channel;

  // Channel Uploads
  List<StreamInfoItem> channelUploads = [];

  // Next page fetch running
  bool fetchingNextPage = false;

  Future<void> loadChannel() async {
    channel = await widget.infoItem.getChannel;
    setState(() {});
  }

  void loadChannelUploads() async {
    channelUploads = await ChannelExtractor.getChannelUploads(widget.infoItem.url!);
    setState(() {});
  }

  void loadChannelNextPage() async {
    if (fetchingNextPage) {
      return;
    }
    setState(() {
      fetchingNextPage = true;
    });
    final streams = await ChannelExtractor.getChannelNextUploads();
    channelUploads.addAll(streams);
    setState(() {
      fetchingNextPage = false;
    });
  }

  @override
  void initState() {
    loadChannel().then((_) => loadChannelUploads());
    super.initState();
  }

  Widget _tabs() {
    return SizedBox(
      height: kToolbarHeight,
      child: TabBar(
        padding: const EdgeInsets.only(left: 8),
        controller: tabController,
        isScrollable: true,
        labelColor: Theme.of(context).textTheme.bodyText1!.color,
        unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
        labelStyle: smallTextStyle(context).copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.4),
        unselectedLabelStyle: smallTextStyle(context).copyWith(fontWeight: FontWeight.normal, letterSpacing: 0.4),
        physics: const BouncingScrollPhysics(),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: RoundedTabIndicator(color: Theme.of(context).primaryColor, height: 3, radius: 100, bottomMargin: 0),
        tabs: const [
          // Recent videos
          Tab(child: Text('Videos')),
          // Playlists 
          Tab(child: Text('Playlists')),
          // Channel Information
          Tab(child: Text('About')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: (16/9),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Channel Banner
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                  ),
                  child: ImageFade(
                    fadeDuration: const Duration(milliseconds: 300),
                    fadeCurve: Curves.ease,
                    fit: BoxFit.cover,
                    image: channel != null
                      ? NetworkImage(channel!.bannerUrl ?? '') : null,
                    placeholder: Container(color: Theme.of(context).scaffoldBackgroundColor),
                    errorBuilder:(context, child, exception) {
                      return Container(color: Theme.of(context).scaffoldBackgroundColor);
                    }
                  ),
                ),
                // Backdrop
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)
                    ),
                  ),
                ),
                // Channel Details
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12, right: 12, top: MediaQuery.of(context).padding.top),
                      height: kToolbarHeight,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Iconsax.arrow_left, color: Theme.of(context).iconTheme.color)
                          ), 
                          const Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          ChannelImage(channelUrl: widget.infoItem.url, heroId: widget.infoItem.url ?? '', expand: true, channelName: widget.infoItem.name ?? '', highQuality: true),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(widget.infoItem.name ?? '', style: textStyle(context), maxLines: 2),
                                    const SizedBox(width: 2),
                                  ],
                                ),
                                Text('${channel != null ? '${ NumberFormat().format(channel!.subscriberCount)} Subs • ' : ''}${widget.infoItem.streamCount} videos', style: smallTextStyle(context, opacity: 0.8)),
                                const SizedBox(height: 2),
                                ChannelSubscribeText(channelName: widget.infoItem.name??'', channel: widget.infoItem)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ),
          //_tabs(),
          //Divider(height: 1, color: Theme.of(context).dividerColor),
          Expanded(
            child: _videos(),
          ),
        ],
      ),
    );
  }

  Widget _videos() {
    return InfiniteScrollingAdapter(
      onReachingEnd: () {
        loadChannelNextPage();
      },
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12),
        itemCount: channelUploads.length,
        itemBuilder: (context, index) {
          final stream = channelUploads[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: StreamTileCollapsed(stream: stream, showChannelName: false),
          );
        },
      ),
    );
  }

  Widget _playlists() {
    return SizedBox();
  }

  Widget _about() {
    return SizedBox();
  }

}