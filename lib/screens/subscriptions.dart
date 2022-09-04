import 'dart:io';

import 'package:animations/animations.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/avatarHandler.dart';
import 'package:songtube/internal/models/subscription.dart';
import 'package:songtube/pages/channel.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/screens/subscriptions/channelRecommendations.dart';
import 'package:songtube/screens/subscriptions/manageChannels.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/components/autoHideScaffold.dart';
import 'package:songtube/ui/components/shimmerContainer.dart';
import 'package:songtube/ui/layout/streamsLargeThumbnail.dart';
import 'package:transparent_image/transparent_image.dart';

class SubscriptionsScreen extends StatefulWidget {
  @override
  _SubscriptionsScreenState createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  
  String sortBy = "date";

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return AutoHideScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                child: Icon(
                  EvaIcons.bookOpenOutline,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Text(
                "Subscriptions",
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
              Spacer(),
            ],
          )
        ),
      ),
      body: Column(
        children: [
          Container(
            height: prefs.channelSubscriptions.isNotEmpty ? 50 : 0,
            width: double.infinity,
            color: Theme.of(context).cardColor,
            margin: prefs.channelSubscriptions.isNotEmpty
              ? EdgeInsets.only(bottom: 12)
              : EdgeInsets.only(bottom: 8),
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                if (prefs.channelSubscriptions.isNotEmpty)
                SizedBox(width: 12),
                if (prefs.channelSubscriptions.isNotEmpty)
                GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)
                        )
                      ),
                      context: context,
                      builder: (context) {
                        return ChannelRecommendationsSheet();
                      }
                    );
                    manager.loadChannelsFeed();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          spreadRadius: 0.2
                        )
                      ],
                      border: Border.all(color: Theme.of(context).accentColor),
                      color: Theme.of(context).cardColor
                    ),
                    child: Center(
                      child: Icon(Icons.add_rounded,
                        color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: prefs.channelSubscriptions.length,
                  itemBuilder: (context, index) {
                    ChannelSubscription subscription = prefs.channelSubscriptions[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                          BlurPageRoute(
                            blurStrength: Provider.of<PreferencesProvider>
                              (context, listen: false).enableBlurUI ? 20 : 0,
                            builder: (_) => 
                            YoutubeChannelPage(
                              heroTag: subscription.url,
                              url: subscription.url,
                              name: subscription.name,
                              lowResAvatar: subscription.avatarUrl,
                        )));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              spreadRadius: 0.2
                            )
                          ]
                        ),
                        child: Hero(
                          tag: subscription.url,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: FutureBuilder(
                              future: AvatarHandler.getAvatarUrl(subscription.name, subscription.url),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return FadeInImage(
                                    fit: BoxFit.cover,
                                    placeholder: MemoryImage(kTransparentImage),
                                    image: FileImage(File(snapshot.data)),
                                    fadeInDuration: Duration(milliseconds: 300),
                                  );
                                } else {
                                  return ShimmerContainer(
                                    aspectRatio: 1,
                                    borderRadius: BorderRadius.circular(100),
                                  );
                                }
                              }
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          if (prefs.channelSubscriptions.isNotEmpty)
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 12),
                // Sort filters
                Icon(Icons.sort_rounded),
                SizedBox(width: 4),
                DropdownButton<String>(
                  value: sortBy,
                  iconSize: 20,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color
                      .withOpacity(0.8),
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 14
                  ),
                  underline: Container(),
                  items: [
                    DropdownMenuItem(
                      child: Text("Date"),
                      value: "date",
                    ),
                    DropdownMenuItem(
                      child: Text("Views"),
                      value: "views",
                    )
                  ],
                  onChanged: (String value) => setState(() => sortBy = value),
                ),
                Spacer(),
                // Manage Subscriptions
                IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)
                        )
                      ),
                      context: context,
                      builder: (context) {
                        return ManageChannelsSheet();
                      }
                    );
                    manager.loadChannelsFeed();
                  },
                  icon: Icon(EvaIcons.settingsOutline,
                    color: Theme.of(context).accentColor),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[600].withOpacity(0.1),
            indent: prefs.channelSubscriptions.isNotEmpty ? 0 : 12,
            endIndent: prefs.channelSubscriptions.isNotEmpty ? 0 : 12
          ),
          Expanded(
            child: prefs.channelSubscriptions.isNotEmpty
              ? Builder(
                  builder: (context) {
                    List<StreamInfoItem> items = manager.channelsFeedList;
                    if (manager.channelsFeedList.isNotEmpty) {
                      if (sortBy == "date") {
                        items.sort((a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
                      } else if (sortBy == "views") {
                        items.sort((a, b) => b.viewCount.compareTo(a.viewCount));
                      }
                    }
                    return PageTransitionSwitcher(
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                      ) {
                        return FadeThroughTransition(
                          fillColor: Theme.of(context).cardColor,
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          child: child,
                        );
                      },
                      duration: Duration(milliseconds: 300),
                      child: StreamsLargeThumbnailView(
                        key: Key(sortBy),
                        infoItems: manager.channelsFeedList
                      ),
                    ); 
                  }
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Discover new Channels to start building your feed!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).iconTheme.color
                              .withOpacity(0.6),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Product Sans'
                          ),
                        ),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () async {
                            await showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)
                                )
                              ),
                              context: context,
                              builder: (context) {
                                return ChannelRecommendationsSheet();
                              }
                            );
                            manager.loadChannelsFeed();
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            margin: EdgeInsets.only(left: 8, right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).accentColor.withOpacity(0.2),
                                  blurRadius: 12,
                                  spreadRadius: 0.2
                                )
                              ],
                              border: Border.all(color: Theme.of(context).accentColor),
                              color: Theme.of(context).cardColor
                            ),
                            child: Center(
                              child: Icon(Icons.add_rounded,
                                color: Theme.of(context).accentColor),
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                )
          ),
        ]
      ),
    );
  }
}