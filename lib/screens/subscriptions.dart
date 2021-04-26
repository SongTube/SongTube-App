import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/avatarHandler.dart';
import 'package:songtube/internal/models/subscription.dart';
import 'package:songtube/pages/channel.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/components/autoHideScaffold.dart';
import 'package:songtube/ui/components/shimmerContainer.dart';
import 'package:songtube/ui/layout/streamsLargeThumbnail.dart';

class SubscriptionsScreen extends StatefulWidget {
  @override
  _SubscriptionsScreenState createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return Scaffold(
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
                  fontSize: 20,
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
                  onTap: () {
                    // TODO: Add new channel
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: FutureBuilder(
                            future: AvatarHandler.getAvatarUrl(subscription.name, subscription.url),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ImageFade(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(snapshot.data)),
                                  fadeDuration: Duration(milliseconds: 300),
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
                    );
                  },
                )
              ],
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
            child: prefs.channelSubscriptions.isNotEmpty
              ? StreamsLargeThumbnailView(
                  infoItems: manager.channelsFeedList
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
                          onTap: () {
                            // TODO: Add new channel
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