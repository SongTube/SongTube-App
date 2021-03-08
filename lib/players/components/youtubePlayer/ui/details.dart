import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/utils/url.dart';
import 'package:songtube/pages/channel.dart';
import 'package:songtube/pages/components/video/shimmer/shimmerChannelLogo.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoDetails extends StatelessWidget {
  final dynamic infoItem;
  final String uploaderAvatarUrl;
  VideoDetails({
    @required this.infoItem,
    this.uploaderAvatarUrl,
  });
  @override
  Widget build(BuildContext context) {
    String title = infoItem?.name ?? "";
    String author = infoItem?.uploaderName ?? "";
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 12, right: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: uploaderAvatarUrl != null
                  ? FutureBuilder<String>(
                      future: _getAvatarUrl(infoItem.uploaderUrl),
                      builder: (context, snapshot) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                              BlurPageRoute(
                                blurStrength: 0,
                                builder: (_) => 
                                YoutubeChannelPage(
                                  url: infoItem.uploaderUrl,
                                  name: infoItem.uploaderName,
                                  lowResAvatar: snapshot.data,
                            )));
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            margin: EdgeInsets.only(right: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: FadeInImage(
                                fadeInDuration: Duration(milliseconds: 400),
                                placeholder: MemoryImage(kTransparentImage),
                                image: snapshot.hasData
                                  ? NetworkImage(snapshot.data)
                                  : MemoryImage(kTransparentImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }
                    )
                  : Container(
                      margin: EdgeInsets.only(right: 12),
                      child: const ShimmerChannelLogo()
                    )
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video Title
                    Padding(
                      padding: const EdgeInsets.only(right: 16, bottom: 4),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Product Sans',
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Video Author
                    Padding(
                      padding: const EdgeInsets.only(right: 16, bottom: 8),
                      child: Text(
                        author,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color
                            .withOpacity(0.8),
                          fontFamily: "Product Sans",
                          fontSize: 12,
                          letterSpacing: 0.2
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<String> _getAvatarUrl(String uploaderUrl) async {
    String id = (await YoutubeId.getIdFromChannelUrl(uploaderUrl)).split("/").last;
    return await ChannelExtractor.getAvatarUrl(id);
  }

}