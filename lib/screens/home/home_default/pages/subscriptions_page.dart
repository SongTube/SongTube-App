import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newpipeextractor_dart/models/infoItems/channel.dart';
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
import 'package:songtube/ui/ui_utils.dart';

class SubscriptionsPage extends StatefulWidget {
  const SubscriptionsPage({super.key});

  @override
  State<SubscriptionsPage> createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> {

  // Content Provider
  ContentProvider get contentProvider => Provider.of(context);

  // Has Subscriptions
  bool get hasSubscriptions => contentProvider.channelSubscriptions.isNotEmpty;

  // Open Channel Suggestions Sheet
  void openSuggestions() {
    UiUtils.showModal(
      context: internalNavigatorKey.currentContext!,
      modal: const ChannelSuggestions());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: hasSubscriptions
        ? _body()
        : _emptyPage(context),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Channels
          SizedBox(
            height: 80,
            child: ListView.builder(
              clipBehavior: Clip.none,
              padding: const EdgeInsets.only(left: 12),
              scrollDirection: Axis.horizontal,
              itemCount: contentProvider.channelSubscriptions.length+1,
              itemBuilder: (context, ind) {
                if (ind == 0) {
                  return Bounce(
                    duration: kAnimationShortDuration,
                    onPressed: () {
                      openSuggestions();
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
                  final index = ind-1;
                  final channel = contentProvider.channelSubscriptions[index];
                  return ChannelTile(
                    channel: ChannelInfoItem(channel.url, channel.name, '', '', null, -1),
                    size: ChannelTileSize.small,
                    forceHighQuality: true,
                  );
                }
              },
            ),
          ),
          // Videos
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 16).copyWith(bottom: audioHandler.mediaItem.value != null ? (kToolbarHeight*1.6)+24 : 24),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contentProvider.channelsFeedList.length,
            itemBuilder: (context, index) {
              final item = contentProvider.channelsFeedList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InfoItemRenderer(
                  infoItem: item,
                  expandItem: true,
                ),
              );
            } 
          ),
        ],
      ),
    );
  }

  Widget _emptyPage(context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 86, width: 86,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(width: 1.5, color: Theme.of(context).dividerColor.withOpacity(0.08)),
            borderRadius: BorderRadius.circular(100)
          ),
          child: IconButton(
            onPressed: () {
              openSuggestions();
            },
            icon: const AppAnimatedIcon(Ionicons.add, size: 52)),
        ),
        const SizedBox(height: 8),
        Text(Languages.of(context)!.labelNoSubscriptions, style: textStyle(context)),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Text(Languages.of(context)!.labelNoSubscriptionsDescription, style: subtitleTextStyle(context, opacity: 0.6), textAlign: TextAlign.center,),
        ),
      ],
    ));
  }
}