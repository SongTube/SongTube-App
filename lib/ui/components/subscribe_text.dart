import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/channel_subscription.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/ui/text_styles.dart';

class ChannelSubscribeText extends StatefulWidget {
  final String channelName;
  final ChannelInfoItem channel;
  final bool autoUpdate;
  const ChannelSubscribeText({
    required this.channelName,
    required this.channel,
    this.autoUpdate = true,
    Key? key
  }) : super(key: key);
  @override
  _ChannelSubscribeTextState createState() => _ChannelSubscribeTextState();
}

class _ChannelSubscribeTextState extends State<ChannelSubscribeText> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    ContentProvider contentProvider = Provider.of(context);
    bool isSubscribed = contentProvider.channelSubscriptions.indexWhere((element) =>
      element.name == widget.channelName) == -1
        ? false : true;
    // bool notificationsEnabled = isSubscribed ? contentProvider.channelSubscriptions[
    //   contentProvider.channelSubscriptions.indexWhere((element) =>
    //   element.name == widget.channelName)
    // ].enableNotifications : false;
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (!isSubscribed) {
              contentProvider.addChannelSubscription(ChannelSubscription
                .generateFromChannel(
                  YoutubeChannel(
                    url: widget.channel.url,
                    name: widget.channelName,
                    id: widget.channel.url,
                    subscriberCount: widget.channel.subscriberCount
                  )
                ));
              if (widget.autoUpdate) contentProvider.loadChannelsFeed();
            } else {
              contentProvider.removeChannelSubscription(widget.channel.url!);
              if (widget.autoUpdate) contentProvider.loadChannelsFeed();
            }
          },
          borderRadius: BorderRadius.circular(10),
          child: Ink(
            color: Colors.transparent,
            child: Text(
              isSubscribed ? 'UNSUBSCRIBE' : 'SUBSCRIBE',
              style: smallTextStyle(context).copyWith(fontWeight: FontWeight.w900, letterSpacing: 1, color: isSubscribed
                ? Theme.of(context).iconTheme.color!
                    .withOpacity(0.6)
                : Theme.of(context).primaryColor),
            ),
          ),
        ),
        /*AnimatedSize(
          vsync: this,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
          child: FadeInTransition(
            delay: Duration(milliseconds: 200),
            duration: Duration(milliseconds: 300),
            child: isSubscribed ? IconButton(
              padding: EdgeInsets.zero,
              icon: PageTransitionSwitcher(
                transitionBuilder: (
                  Widget child,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                ) {
                  return FadeThroughTransition(
                    fillColor: Colors.transparent,
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                  );
                },
                duration: Duration(milliseconds: 300),
                child: notificationsEnabled
                  ? Icon(
                      EvaIcons.bellOutline,
                      key: Key("bellOutline"),
                      color: Theme.of(context).accentColor,
                    )
                  : Icon(
                      EvaIcons.bellOffOutline,
                      key: Key("bellOffOutline"),
                      color: Theme.of(context).iconTheme.color
                        .withOpacity(0.6)
                    ),
              ),
              onPressed: () => prefs
                .enableChannelNotifications(widget.channel.url),
            ) : Container(width: 12),
          ),
        ),*/
      ],
    );
  }
}