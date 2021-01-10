import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/routes/components/relatedVideosList.dart';
import 'package:songtube/routes/video.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/animations/fadeIn.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeChannelPage extends StatelessWidget {
  final String id;
  final String name;
  final String logoUrl;
  YoutubeChannelPage({
    @required this.id,
    @required this.name,
    @required this.logoUrl,
  });
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness:
          Theme.of(context).brightness ==
            Brightness.dark ?  Brightness.light : Brightness.dark,
      ),
    );
    return WillPopScope(
      onWillPop: () {
        manager.youtubeExtractor.killIsolates();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Text("$name",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
            )),
          iconTheme: IconThemeData(
            color: Theme.of(context).iconTheme.color
          ),
          elevation: 0,
          backgroundColor: Colors.transparent
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: id,
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        fadeInDuration: Duration(milliseconds: 300),
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(logoUrl)
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 8
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(EvaIcons.cloudUploadOutline,
                          color: Theme.of(context).accentColor),
                        SizedBox(width: 8),
                        Text(
                          "Uploads",
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
                child: FutureBuilder<List<Video>>(
                  future: manager.youtubeExtractor.getChannelVideos(VideoId(id)),
                  builder: (context, AsyncSnapshot<List<Video>> snapshot) {
                    List<Video> videos = snapshot.data;
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: snapshot.hasData
                        ? RelatedVideosList(
                            related: videos,
                            onVideoTap: (index) {
                              Navigator.pop(context);
                              manager.updateMediaInfoSet(videos[index], null);
                              Navigator.push(context,
                              BlurPageRoute(
                                blurStrength: prefs.enableBlurUI ? 20 : 0,
                                slideOffset: Offset(0.0, 10.0),
                                builder: (_) => 
                                YoutubePlayerVideoPage(
                                  url: videos[index].id.value,
                                  thumbnailUrl: "${videos[index].thumbnails.highResUrl}",
                              )));
                            }
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: 32),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                    );
                  },
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}