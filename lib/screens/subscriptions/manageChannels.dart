import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/avatarHandler.dart';
import 'package:songtube/internal/models/subscription.dart';
import 'package:songtube/pages/channel.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/components/shimmerContainer.dart';
import 'package:transparent_image/transparent_image.dart';

class ManageChannelsSheet extends StatelessWidget {
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
              title: Text("Your subscriptions", style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontWeight: FontWeight.w600
              )),
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
            child: _channelList(context)
          )
        ],
      ),
    );
  }

  Widget _channelList(context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    List<ChannelSubscription> channels = prefs.channelSubscriptions;
    return ListView.builder(
      itemCount: channels.length,
      itemBuilder: (context, index) {
        ChannelSubscription channel = channels[index];
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
          child: _channelWidget(context, channel)
        );
      },
    );
  }

  Widget _channelWidget(context, ChannelSubscription channel) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return Container(
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
              ],
            ),
          ),
          IconButton(
            icon: Icon(EvaIcons.trashOutline,
              color: Theme.of(context).accentColor),
            onPressed: () {
              prefs.removeChannelSubscription(channel.url);
            },
          )
        ],
      ),
    );
  }
}