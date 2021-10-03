import 'package:animations/animations.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:newpipeextractor_dart/models/channel.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/subscription.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:songtube/ui/internal/snackbar.dart';

class ChannelSubscribeComponent extends StatefulWidget {
  final String channelName;
  final YoutubeChannel channel;
  final bool autoUpdate;
  final scaffoldState;
  ChannelSubscribeComponent({
    this.channelName,
    this.channel,
    this.autoUpdate = true,
    this.scaffoldState
  });
  @override
  _ChannelSubscribeComponentState createState() => _ChannelSubscribeComponentState();
}

class _ChannelSubscribeComponentState extends State<ChannelSubscribeComponent> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    bool isSubscribed = prefs.channelSubscriptions.indexWhere((element) =>
      element.name == widget.channelName) == -1
        ? false : true;
    bool notificationsEnabled = isSubscribed ? prefs.channelSubscriptions[
      prefs.channelSubscriptions.indexWhere((element) =>
      element.name == widget.channelName)
    ].enableNotifications : false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            if (!isSubscribed && widget.channel != null) {
              prefs.addChannelSubscription(ChannelSubscription
                .generateFromChannel(widget.channel));
              if (widget.autoUpdate) manager.loadChannelsFeed();
              if (widget.scaffoldState != null) {
                AppSnack.showSnackBar(
                  icon: MdiIcons.youtube,
                  title: "Subscribed!",
                  message: "${widget.channelName}",
                  context: context,
                  scaffoldKey: widget.scaffoldState,
                );
              }
            } else if (widget.channel != null) {
              prefs.removeChannelSubscription(widget.channel.url);
              if (widget.autoUpdate) manager.loadChannelsFeed();
            }
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Ink(
              color: Colors.transparent,
              child: Text(
                Languages.of(context).labelSubscribe.toUpperCase(),
                style: TextStyle(
                  color: isSubscribed || widget.channel == null
                    ? Theme.of(context).iconTheme.color
                        .withOpacity(0.6)
                    : Theme.of(context).accentColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
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