import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/models/channel.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/avatarHandler.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/subscription.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:songtube/ui/components/shimmerContainer.dart';
import 'package:songtube/ui/components/subscribeTile.dart';
import 'package:songtube/ui/internal/snackbar.dart';
import 'package:songtube/ui/layout/streamsListTile.dart';
import 'package:string_validator/string_validator.dart';
import 'package:transparent_image/transparent_image.dart';

class YoutubeChannelPage extends StatefulWidget {
  final String url;
  final String name;
  final String lowResAvatar;
  final String heroTag;
  YoutubeChannelPage({
    @required this.url,
    @required this.name,
    this.lowResAvatar,
    this.heroTag = ""
  });

  @override
  _YoutubeChannelPageState createState() => _YoutubeChannelPageState();
}

class _YoutubeChannelPageState extends State<YoutubeChannelPage> {

  YoutubeChannel channel;

  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
    ChannelExtractor.channelInfo(widget.url).then((value) {
      setState(() => channel = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness:
          Theme.of(context).brightness ==
            Brightness.dark ?  Brightness.light : Brightness.dark,
      ),
    );
    return Column(
      children: [
        Expanded(
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              titleSpacing: 0,
              title: Text("${widget.name}",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w600
                )),
              iconTheme: IconThemeData(
                color: Theme.of(context).iconTheme.color
              ),
              elevation: 0,
              backgroundColor: Colors.transparent
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // background image and bottom contents
                Column(
                  children: <Widget>[
                    Container(
                      height: 150,
                      color: Colors.transparent,
                      child: Center(
                        child: bannerWidget()
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            SizedBox(height: 62),
                            Text(
                              "${widget.name}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Product Sans',
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${NumberFormat.compact().format(channel?.subscriberCount ?? 0)} Subs",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Product Sans',
                                color: Theme.of(context).textTheme.bodyText1.color
                                  .withOpacity(0.6)
                              ),
                            ),
                            SizedBox(height: 8),
                            ChannelSubscribeComponent(
                              channelName: widget.name,
                              channel: channel,
                              scaffoldState: scaffoldKey.currentState
                            ),
                            SizedBox(height: 16),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey[600].withOpacity(0.1),
                              indent: 12,
                              endIndent: 12
                            ),
                            Expanded(
                              child: FadeInTransition(
                                delay: Duration(milliseconds: 600),
                                child: FutureBuilder<List<StreamInfoItem>>(
                                  future: ChannelExtractor.getChannelUploads(widget.url),
                                  builder: (context, AsyncSnapshot<List<StreamInfoItem>> snapshot) {
                                    return ListView(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          height: 60,
                                          child: Row(
                                            children: [
                                              Text(
                                                Languages.of(context).labelVideos,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Product Sans',
                                                  color: Theme.of(context).textTheme.bodyText1.color
                                                ),
                                              ),
                                              Spacer(),
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
                                        StreamsListTileView(
                                          shrinkWrap: true,
                                          removePhysics: true,
                                          streams: snapshot.hasData
                                            ? snapshot.data : [],
                                          onTap: (stream, index) {
                                            Navigator.pop(context);
                                            pageProvider.infoItem = stream;
                                          }
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    )
                  ],
                ),
                // Profile image
                Positioned(
                  top: 100, // (background container size) - (circle height / 2)
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child: widget.lowResAvatar != null
                      ? Hero(
                          tag: widget.heroTag,
                          child: FutureBuilder(
                            future: AvatarHandler.getAvatarUrl(widget.name, widget.url),
                            builder: (context, snapshot) {
                              String avatar = snapshot.hasData
                                ? snapshot.data : widget.lowResAvatar;
                              return Container(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: FadeInImage(
                                    fadeInDuration: Duration(milliseconds: 300),
                                    placeholder: MemoryImage(kTransparentImage),
                                    image: isURL(avatar)
                                      ? NetworkImage(avatar)
                                      : FileImage(File(avatar)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }
                          ),
                        )
                      : ShimmerContainer(
                          height: 100,
                          width: 100,
                          borderRadius: BorderRadius.circular(100),
                        ),
                  ),
                )
              ],
            )
          )
        )
      ]
    );
  }

  Widget bannerWidget() {
    if (channel == null) {
      return ShimmerContainer(
        width: double.infinity
      );
    } else if (channel?.bannerUrl == null) {
      return Container(
        color: Theme.of(context).accentColor
      );
    } else {
      return FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: NetworkImage(channel.bannerUrl),
        fit: BoxFit.fitHeight,
        height: 150,
      );
    }
  }
}