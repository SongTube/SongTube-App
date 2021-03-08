import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/models/channel.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:songtube/ui/components/shimmerContainer.dart';
import 'package:songtube/ui/layout/streamsListTile.dart';
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

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Channel Banner
            AnimatedContainer(
              duration: Duration(milliseconds: 250),
              child: bannerWidget(),
            ),
            Row(
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: widget.lowResAvatar != null
                    ? Hero(
                        tag: widget.heroTag,
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Container(
                            margin: EdgeInsets.all(16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: FadeInImage(
                                fadeInDuration: Duration(milliseconds: 300),
                                placeholder: MemoryImage(kTransparentImage),
                                image: NetworkImage(
                                  channel?.avatarUrl != null
                                    ? channel.avatarUrl
                                    : widget.lowResAvatar
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                    : ShimmerContainer(
                        height: 100,
                        width: 100,
                        borderRadius: BorderRadius.circular(100),
                      ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Product Sans',
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        "${NumberFormat.compact().format(channel?.subscriberCount ?? 0)} Subs",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Product Sans',
                          color: Theme.of(context).textTheme.bodyText1.color
                            .withOpacity(0.5)
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(EvaIcons.cloudUploadOutline,
                        color: Theme.of(context).accentColor),
                      SizedBox(width: 8),
                      Text(
                        "Videos",
                        style: TextStyle(
                          fontFamily: "YTSans",
                          fontSize: 22
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
            FadeInTransition(
              delay: Duration(milliseconds: 600),
              child: FutureBuilder<List<StreamInfoItem>>(
                future: ChannelExtractor.getChannelUploads(widget.url),
                builder: (context, AsyncSnapshot<List<StreamInfoItem>> snapshot) {
                  return StreamsListTileView(
                    shrinkWrap: true,
                    streams: snapshot.hasData
                      ? snapshot.data : [],
                    onTap: (stream, index) {
                      Navigator.pop(context);
                      pageProvider.infoItem = stream;
                    }
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }

  Widget bannerWidget() {
    if (channel == null) {
      return AspectRatio(
        aspectRatio: 20/9,
        child: ShimmerContainer(
          margin: EdgeInsets.only(left: 12, right: 12),
          borderRadius: BorderRadius.circular(10),
          width: double.infinity
        ),
      );
    } else if (channel?.bannerUrl == null) {
      return Container();
    } else {
      return AspectRatio(
        aspectRatio: 20/9,
        child: Container(
          margin: EdgeInsets.only(left: 12, right: 12),
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(channel.bannerUrl),
              fit: BoxFit.cover,
            )
          ),
        ),
      );
    }
  }

  Widget avatarWidget(String url) {
    
  }
}