// Flutter
import 'dart:async';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_fade/image_fade.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share/share.dart';
import 'package:songtube/downloadMenu/downloadMenu.dart';
import 'package:songtube/internal/models/channelLogo.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/routes/channel.dart';
import 'package:songtube/routes/playlist.dart';
import 'package:songtube/routes/video.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/dialogs/loadingDialog.dart';
import 'package:songtube/ui/internal/snackbar.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoTile extends StatelessWidget {
  final searchItem;
  final bool enableSaveToWatchLater;
  final bool enableSaveToFavorites;
  final Function() onDelete;
  VideoTile({
    @required this.searchItem,
    this.enableSaveToFavorites = true,
    this.enableSaveToWatchLater = true,
    this.onDelete
  });
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return InkWell(
      onTap: () async {
        manager.updateMediaInfoSet(searchItem);
        Navigator.push(context,
        BlurPageRoute(
          slideOffset: Offset(0.0, 10.0),
          builder: (_) {
            if (searchItem is Video) {
              return YoutubePlayerVideoPage(
                url: searchItem.id.value,
                thumbnailUrl: searchItem.thumbnails.highResUrl
              );
            } else if (searchItem is SearchVideo) {
              return YoutubePlayerVideoPage(
                url: searchItem.videoId.value,
                thumbnailUrl: searchItem.videoThumbnails.last.url.toString(),
              );
            } else if (searchItem is SearchPlaylist) {
              return YoutubePlayerPlaylistPage();
            } else {
              return Container();
            }
          }
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
                        tag: searchItem is Video
                          ? searchItem.id.value + "player"
                          : searchItem is SearchVideo
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
                      if (snapshot.hasData || searchItem is SearchPlaylist) {
                        String channelLogo = snapshot.data;
                        return GestureDetector(
                          onTap: () {
                            if (searchItem is Video) {
                              Video video = searchItem;
                              Navigator.push(context,
                                BlurPageRoute(
                                  builder: (_) => 
                                  YoutubeChannelPage(
                                    id: video.id.value,
                                    name: video.author,
                                    logoUrl: channelLogo,
                              )));
                            } else if (searchItem is SearchVideo) {
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
                            tag: searchItem is Video
                              ? searchItem.id.value
                              : searchItem is SearchVideo
                                ? searchItem.videoId.value
                                : searchItem.playlistId.value,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black.withOpacity(0.05)
                              ),
                              child: searchItem is Video || searchItem is SearchVideo
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
                    margin: EdgeInsets.only(top: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          searchItem is Video
                            ? "${searchItem.title}"
                            : searchItem is SearchVideo
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
                          searchItem is Video
                            ? "${searchItem.engagement.viewCount}"
                            : searchItem is SearchVideo
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
                if (searchItem is SearchVideo || searchItem is Video)
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    showMenu<String>(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        details.globalPosition.dx,
                        details.globalPosition.dy,
                        0, 0
                      ),
                      items: [
                        PopupMenuItem<String>(
                          child: Text("Share"),
                          value: "Share",
                        ),
                        PopupMenuItem<String>(
                          child: Text("Copy link"),
                          value: "Copy Link",
                        ),
                        PopupMenuItem<String>(
                          child: Text("Download"),
                          value: "Download",
                        ),
                        if (onDelete != null)
                        PopupMenuItem<String>(
                          child: Text("Remove"),
                          value: "Remove",
                        ),
                        if (enableSaveToFavorites)
                        PopupMenuItem<String>(
                          child: Text("Add to Favorites"),
                          value: "Favorites",
                        ),
                        if (enableSaveToWatchLater)
                        PopupMenuItem<String>(
                          child: Text("Add to Watch later"),
                          value: "Watch Later",
                        ),
                      ],
                    ).then((value) async {
                      switch(value) {
                        case "Share":
                          Share.share(
                            searchItem is Video
                              ? "https://www.youtube.com/watch?v=${searchItem.id.value}"
                              : searchItem is SearchVideo
                                ? "https://www.youtube.com/watch?v=${searchItem.videoId.value}"
                                : "https://www.youtube.com/playlist?list=${searchItem.PlaylistId.value}"
                          );
                          break;
                        case "Copy Link":
                          String link = searchItem is Video
                            ? "https://www.youtube.com/watch?v=${searchItem.id.value}"
                            : searchItem is SearchVideo
                              ? "https://www.youtube.com/watch?v=${searchItem.videoId.value}"
                              : "https://www.youtube.com/playlist?list=${searchItem.PlaylistId.value}";
                          Clipboard.setData(ClipboardData(
                            text: link
                          ));
                          final scaffold = Scaffold.of(context);
                          AppSnack.showSnackBar(
                            icon: Icons.copy,
                            title: "Link copied to Clipboard",
                            duration: Duration(seconds: 2),
                            context: context,
                            scaffoldKey: scaffold
                          );
                          break;
                        case "Download":
                          showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            context: context,
                            builder: (context) {
                              String url = searchItem is SearchVideo
                                ? "http://youtube.com/watch?v=${searchItem.videoId.value}"
                                : "http://youtube.com/watch?v=${searchItem.id.value}";
                              return Wrap(
                                children: [
                                  DownloadMenu(
                                    videoUrl: url,
                                    scaffoldState: manager
                                      .libraryScaffoldKey.currentState,
                                  ),
                                ],
                              );
                            }
                          );
                          break;
                        case "Remove":
                          onDelete();
                          break;
                        case "Favorites":
                          Video videoToSave;
                          if (searchItem is SearchVideo) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => LoadingDialog()
                            );
                            videoToSave = await manager.youtubeExtractor
                              .getVideoDetails(
                                searchItem.videoId
                              );
                            Navigator.pop(context);
                          } else {
                            videoToSave = searchItem;
                          }
                          List<Video> videos = prefs.favoriteVideos;
                          videos.add(videoToSave);
                          prefs.favoriteVideos = videos;
                          AppSnack.showSnackBar(
                            icon: EvaIcons.heartOutline,
                            title: "Video added to Favorites",
                            context: context,
                            scaffoldKey: Scaffold.of(context)
                          );
                          break;
                        case "Watch Later":
                          Video videoToSave;
                          if (searchItem is SearchVideo) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => LoadingDialog()
                            );
                            videoToSave = await manager.youtubeExtractor
                              .getVideoDetails(
                                searchItem.videoId
                              );
                            Navigator.pop(context);
                          } else {
                            videoToSave = searchItem;
                          }
                          List<Video> videos = prefs.watchLaterVideos;
                          videos.add(videoToSave);
                          prefs.watchLaterVideos = videos;
                          AppSnack.showSnackBar(
                            icon: EvaIcons.clockOutline,
                            title: "Video added to Watch Later",
                            context: context,
                            scaffoldKey: Scaffold.of(context)
                          );
                          break;
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.transparent,
                    child: Icon(Icons.more_vert_rounded,
                      size: 18),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getThumbnailLink() async {
    if (searchItem is Video) {
      String link = searchItem.thumbnails.highResUrl;
      return link;
    } else if (searchItem is SearchVideo) {
      String link = searchItem.videoThumbnails.last.url.toString();
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
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    if (searchItem is Video) {
      Video video = searchItem;
      Channel channel = await manager.youtubeExtractor
        .getChannelByVideoId(video.id);
      return channel.logoUrl;
    } else if (searchItem is SearchVideo) {
      SearchVideo video = searchItem;
      return await ChannelLogo.getChannelLogoUrl(context, video);
    } else {
      return null;
    }
  }

}