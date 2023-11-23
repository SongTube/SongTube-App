
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newpipeextractor_dart/models/infoItems/channel.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/screens/channel.dart';
import 'package:songtube/ui/components/channel_image.dart';
import 'package:songtube/ui/components/subscribe_text.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/ui_utils.dart';

enum ChannelTileSize { small, big }

class ChannelTile extends StatefulWidget {
  const ChannelTile({
    required this.channel,
    required this.size,
    this.forceHighQuality = false,
    this.disablePaddings = false,
    this.margin,
    this.padding,
    super.key});
  final ChannelInfoItem channel;
  final ChannelTileSize size;
  final bool forceHighQuality;
  final bool disablePaddings;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
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
      padding: widget.disablePaddings ? null : widget.padding ?? const EdgeInsets.all(12),
      margin: widget.disablePaddings ? null : widget.margin ?? const EdgeInsets.all(12),
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
                  style: smallTextStyle(context),
                  maxLines: 2,
                ),
                Text(
                  widget.channel.subscriberCount != -1 && widget.channel.subscriberCount != null ? "${NumberFormat().format(widget.channel.subscriberCount)} Subs • " : '' '${widget.channel.streamCount} ${Languages.of(context)!.labelVideos}',
                  style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12)
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
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
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
            size: 68,
            onTap: openChannel,
            highQuality: widget.forceHighQuality,
            borderRadius: 100,
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.channel.name??'', style: smallTextStyle(context).copyWith(), maxLines: 1, textAlign: TextAlign.center),
              Text(widget.channel.subscriberCount?.toString()??'Unknown Subs', style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12), maxLines: 1, textAlign: TextAlign.center),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

}