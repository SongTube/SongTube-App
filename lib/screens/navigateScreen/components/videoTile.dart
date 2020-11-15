// Flutter
import 'dart:isolate';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:songtube/internal/models/channelLogo.dart';
import 'package:songtube/provider/configurationProvider.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoTile extends StatefulWidget {
  final searchItem;
  VideoTile({
    @required this.searchItem
  });
  @override
  _VideoTileState createState() => _VideoTileState();

  static void getChannelLogoUrlIsolate(SendPort mainSendPort) async {
    ReceivePort childReceivePort = ReceivePort();
    mainSendPort.send(childReceivePort.sendPort);
    await for (var message in childReceivePort) {
      YoutubeExplode yt = YoutubeExplode();
      String videoId = message[0];
      SendPort replyPort = message[1];
      Channel channel;
      try {
        channel = await yt.channels.getByVideo(videoId);
      } catch (_) {
        replyPort.send("");
        yt.close();
        break;
      }
      replyPort.send(channel.logoUrl);
      yt.close();
      break;
    }
  }
}

class _VideoTileState extends State<VideoTile> {

  Isolate isolate;

  String channelLogo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.searchItem is SearchVideo)
        getChannelLogoUrl(widget.searchItem);
    });
  }

  @override
  void dispose() {
    if (isolate != null)
      isolate.kill(priority: Isolate.immediate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return InkWell(
      onTap: () {
        if (widget.searchItem is SearchVideo) {
          manager.getVideoDetails("https://www.youtube.com/watch?v=${widget.searchItem.videoId}");
        } else {
          manager.getPlaylistDetails("https://www.youtube.com/playlist?list=${widget.searchItem.playlistId}");
        }
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
                future: widget.searchItem is SearchVideo
                  ? getVideoThumbnailLink()
                  : getPlaylistThumbnailLink(widget.searchItem),
                builder: (context, snapshot) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 12,
                          right: 12,
                        ),
                        height: double.infinity,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
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
                      if (widget.searchItem is SearchPlaylist)
                      Container(
                          height: 25,
                            margin: EdgeInsets.only(
                            left: 12,
                            right: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black.withOpacity(0.4),
                          ),
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
            Container(
              margin: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 4),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black.withOpacity(0.05)
                    ),
                    child: widget.searchItem is SearchVideo
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                          child: FadeInImage(
                            fadeInDuration: Duration(milliseconds: 200),
                            placeholder: MemoryImage(kTransparentImage),
                            image: channelLogo != null
                              ? NetworkImage(channelLogo)
                              : MemoryImage(kTransparentImage),
                          ),
                        )
                      : Icon(MdiIcons.playlistMusicOutline,
                          color: Theme.of(context).iconTheme.color),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.searchItem is SearchVideo
                            ? "${widget.searchItem.videoTitle}"
                            : "${widget.searchItem.playlistTitle}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.searchItem is SearchVideo
                            ? "${widget.searchItem.videoAuthor} • " +
                              "${NumberFormat.compact().format(widget.searchItem.videoViewCount)} views"
                            : "Playlist • ${widget.searchItem.playlistVideoCount} videos",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getVideoThumbnailLink() async {
    String link = "http://img.youtube.com/vi/${widget.searchItem.videoId}/mqdefault.jpg";
    return link; 
  }

  Future<String> getPlaylistThumbnailLink(SearchPlaylist searchPlaylist) async {
    YoutubeExplode yt = YoutubeExplode();
    Playlist playlist = await yt.playlists.get(searchPlaylist.playlistId);
    yt.close();
    return playlist.thumbnails.mediumResUrl;
  }

  Future<void> getChannelLogoUrl(SearchVideo video) async {
    if (context == null) return;
    ConfigurationProvider appData = Provider.of<ConfigurationProvider>(context, listen: false);
    if ((appData.channelLogos.singleWhere((it) => it.name == video.videoAuthor,
          orElse: () => null)) != null) {
      return appData.channelLogos[appData.channelLogos
        .indexWhere((element) => element.name == video.videoAuthor)].logoUrl;
    } else {
      ReceivePort receivePort = ReceivePort();
      isolate = await Isolate.spawn(VideoTile.getChannelLogoUrlIsolate, receivePort.sendPort);
      SendPort childSendPort = await receivePort.first;
      ReceivePort responsePort = ReceivePort();
      childSendPort.send(["${video.videoId}", responsePort.sendPort]);
      String url = await responsePort.first;
      if (url == "") return null;
      if ((appData.channelLogos.singleWhere((it) => it.name == video.videoAuthor,
          orElse: () => null)) != null) {
        print("logo Exist");
      } else {
        appData.addItemtoChannelLogoList(ChannelLogo(
          name: video.videoAuthor,
          logoUrl: url
        ));
      }
      if (mounted)
        setState(() => channelLogo = url);
    }
  }
}