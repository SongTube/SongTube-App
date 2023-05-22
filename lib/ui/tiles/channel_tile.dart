import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newpipeextractor_dart/models/infoItems/channel.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/screens/channel.dart';
import 'package:songtube/ui/components/channel_image.dart';
import 'package:songtube/ui/components/shimmer_container.dart';
import 'package:songtube/ui/components/subscribe_text.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/ui_utils.dart';
import 'package:transparent_image/transparent_image.dart';

enum ChannelTileSize { small, big }

class ChannelTile extends StatefulWidget {
  const ChannelTile({
    required this.channel,
    required this.size,
    this.forceHighQuality = false,
    this.disablePaddings = false,
    super.key});
  final ChannelInfoItem channel;
  final ChannelTileSize size;
  final bool forceHighQuality;
  final bool disablePaddings;
  @override
  State<ChannelTile> createState() => _ChannelTileState();
}

class _ChannelTileState extends State<ChannelTile> {

  void openChannel() {
    UiUtils.pushRouteAsync(context, ChannelPage(infoItem: widget.channel));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: openChannel,
      child: _size());
  }

  Widget _size() {
    switch (widget.size) {
      case ChannelTileSize.big:
        return _big();
      case ChannelTileSize.small:
        return _medium();
    }
  }

  Widget _big() {
    return Container(
      padding: widget.disablePaddings ? null : const EdgeInsets.all(12),
      margin: widget.disablePaddings ? null : const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          ChannelImage(
            channelUrl: widget.channel.url,
            heroId: widget.channel.name??'',
            channelName: widget.channel.name??'',
            size: 80,
            highQuality: true,
            onTap: openChannel,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.channel.name ?? '',
                  style: subtitleTextStyle(context, bold: true),
                  maxLines: 2,
                ),
                Text(
                  widget.channel.subscriberCount != -1 ? "${NumberFormat().format(widget.channel.subscriberCount)} Subs • " : '' '${widget.channel.streamCount} ${Languages.of(context)!.labelVideos}',
                  style: smallTextStyle(context, opacity: 0.8)
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ChannelSubscribeText(channelName: widget.channel.name??'', channel: widget.channel)
        ],
      ),
    );
  }

  Widget _medium() {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.only(left: 6, right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0,0),
            color: Theme.of(context).shadowColor.withOpacity(0.01)
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ChannelImage(
            channelUrl: widget.channel.url,
            heroId: widget.channel.name??'',
            channelName: widget.channel.name??'',
            size: 40,
            onTap: openChannel,
            highQuality: widget.forceHighQuality,
          ),
          const SizedBox(width: 8),
          Text(widget.channel.name??'', style: tinyTextStyle(context).copyWith(fontWeight: FontWeight.w600), maxLines: 1, textAlign: TextAlign.center),
        ],
      ),
    );
  }

}