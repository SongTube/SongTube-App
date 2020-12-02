// Flutter
import 'dart:async';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:songtube/internal/models/channelLogo.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:songtube/routes/channel.dart';
import 'package:songtube/routes/playlist.dart';
import 'package:songtube/routes/video.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoTile extends StatelessWidget {
  final searchItem;
  VideoTile({
    @required this.searchItem,
  });
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return InkWell(
      onTap: () async {
        manager.updateMediaInfoSet(searchItem);
        Navigator.push(context,
        BlurPageRoute(
          slideOffset: Offset(0.0, 10.0),
          builder: (_) => searchItem is SearchVideo
            ? YoutubePlayerVideoPage(
                url: searchItem.videoId.value,
                thumbnailUrl: searchItem.videoThumbnails.last.url.toString(),
              )
            : YoutubePlayerPlaylistPage()
        ));
      },
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor
        ),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16/9,
              child: FutureBuilder<String>(
                future: _getThumbnailLink(),
                builder: (context, snapshot) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Hero(
                        tag: searchItem is SearchVideo
                          ? searchItem.videoId.value + "player"
                          : searchItem.playlistId.value + "player",
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: FadeInImage(
                            fadeInDuration: Duration(milliseconds: 200),
                            placeholder: MemoryImage(kTransparentImage),
                            image: snapshot.hasData
                              ? NetworkImage(snapshot.data)
                              : MemoryImage(kTransparentImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (searchItem is SearchPlaylist)
                      Container(
                          height: 25,
                          color: Colors.black.withOpacity(0.4),
                          child: Center(
                            child: Icon(EvaIcons.musicOutline,
                              color: Colors.white, size: 20),
                          ),
                        )
                    ],
                  );
                }
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 4),
                  child: FutureBuilder<String>(
                    future: _getChannelLogoUrl(context),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        String channelLogo = snapshot.data;
                        return GestureDetector(
                          onTap: () {
                            if (searchItem is SearchVideo) {
                              SearchVideo video = searchItem;
                              Navigator.push(context,
                                BlurPageRoute(
                                  builder: (_) => 
                                  YoutubeChannelPage(
                                    id: video.videoId.value,
                                    name: video.videoAuthor,
                                    logoUrl: channelLogo,
                              )));
                            }
                          },
                          child: Hero(
                            tag: searchItem is SearchVideo
                              ? searchItem.videoId.value
                              : searchItem.playlistId.value,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black.withOpacity(0.05)
                              ),
                              child: searchItem is SearchVideo
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                    child: ImageFade(
                                      fadeDuration: Duration(milliseconds: 200),
                                      image: channelLogo != null
                                        ? NetworkImage(channelLogo)
                                        : MemoryImage(kTransparentImage),
                                    ),
                                  )
                                : Icon(MdiIcons.playlistMusicOutline,
                                    color: Theme.of(context).iconTheme.color),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Theme.of(context).cardColor
                          ),
                        );
                      }
                    }
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 12, right: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          searchItem is SearchVideo
                            ? "${searchItem.videoTitle}"
                            : "${searchItem.playlistTitle}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 4),
                        Text(
                          searchItem is SearchVideo
                            ? "${searchItem.videoAuthor} • " +
                              "${NumberFormat.compact().format(searchItem.videoViewCount)} views"
                            : "Playlist • ${searchItem.playlistVideoCount} videos",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getThumbnailLink() async {
    if (searchItem is SearchVideo) {
      String link = "https://i.ytimg.com" +
        searchItem.videoThumbnails.last.url.path;
      return link;
    } else {
      SearchPlaylist searchPlaylist = searchItem;
      YoutubeExplode yt = YoutubeExplode();
      Playlist playlist = await yt.playlists.get(searchPlaylist.playlistId);
      yt.close();
      return playlist.thumbnails.highResUrl;
    }
  }

  Future<String> _getChannelLogoUrl(context) async {
    if (searchItem is SearchVideo) {
      SearchVideo video = searchItem;
      return await ChannelLogo.getChannelLogoUrl(context, video);
    } else {
      return null;
    }
  }

}