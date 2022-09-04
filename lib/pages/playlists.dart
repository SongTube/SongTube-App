import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:autolist/autolist.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/playlist.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/provider/videoPageProvider.dart';
import 'package:songtube/ui/components/emptyIndicator.dart';
import 'package:transparent_image/transparent_image.dart';

class PlaylistsPage extends StatefulWidget {
  @override
  _PlaylistsPageState createState() => _PlaylistsPageState();
}

class _PlaylistsPageState extends State<PlaylistsPage> {
  
  // Current Playlist Selected
  StreamPlaylist currentPlaylist;

  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    VideoPageProvider pageProvider = Provider.of<VideoPageProvider>(context);
    return WillPopScope(
      onWillPop: () {
        if (currentPlaylist != null) {
          setState(() => currentPlaylist = null);
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            currentPlaylist == null
              ? Languages.of(context).labelPlaylists
              : currentPlaylist.name,
            style: TextStyle(
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Theme.of(context).textTheme.bodyText1.color
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).iconTheme.color),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Theme.of(context).cardColor,
              child: Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey[600].withOpacity(0.1),
                indent: 12,
                endIndent: 12
              ),
            ),
            Expanded(
              child: PageTransitionSwitcher(
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
                child: currentPlaylist == null
                  ? prefs.streamPlaylists.isNotEmpty 
                    ? _playlistsListView()
                    : Container(
                        alignment: Alignment.topCenter,
                        color: Theme.of(context).cardColor,
                        child: EmptyIndicator()
                      )
                  : _playlistStreamsListView()
              ),
            ),
            Container(
              height: MediaQuery.of(context).padding.bottom,
              color: Theme.of(context).cardColor
            )
          ],
        ),
        floatingActionButton: IgnorePointer(
          ignoring: currentPlaylist == null ? true : false,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: currentPlaylist == null ? 0.0 : 1.0,
            child: FloatingActionButton.extended(
              backgroundColor: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.pop(context);
                pageProvider.infoItem = currentPlaylist;
              },
              label: Row(
                children: [
                  Icon(Icons.play_arrow_rounded,
                    color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    Languages.of(context).labelStart,
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }

  Widget _playlistsListView() {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    List<StreamPlaylist> listPlaylists = prefs.streamPlaylists;
    return AutoList(
      duration: Duration(milliseconds: 300),
      items: listPlaylists,
      itemBuilder: (context, playlist) {
        return Padding(
          padding: EdgeInsets.only(
            top: 12,
            bottom: 12,
            left: 12, right: 12
          ),
          child: GestureDetector(
            onTap: () {
              setState(() => currentPlaylist = playlist);
            },
            child: _playlistView(playlist)
          ),
        );
      },
    );
  }
  
  Widget _playlistView(StreamPlaylist playlist) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: 16/9,
            child: Transform.scale(
              scale: 1.01,
              child: FadeInImage(
                fadeInDuration: Duration(milliseconds: 300),
                image: NetworkImage(playlist.streams[0].thumbnails.hqdefault),
                placeholder: MemoryImage(kTransparentImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8)
                ],
                begin: const Alignment(0.0, -1),
                end: const Alignment(0.0, 0.8),
                tileMode: TileMode.clamp
              )
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12, right: 12,
                  bottom: 12
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor
                          .withOpacity(0.4),
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Icon(
                        Icons.playlist_play_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            playlist.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.white
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            playlist.author + " • ${playlist.streams.length} " +
                            Languages.of(context).labelVideos,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(EvaIcons.trash2Outline,
                        color: Colors.white,
                        size: 18),
                      onPressed: () {
                        prefs.streamPlaylistRemove(playlist.name);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _playlistStreamsListView() {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    int playlistIndex = prefs.streamPlaylists.indexWhere((element)
      => element.name == currentPlaylist.name);
    return AutoList(
      duration: Duration(milliseconds: 300),
      items: prefs.streamPlaylists[playlistIndex].streams,
      itemBuilder: (context, stream) {
        return Padding(
          padding: EdgeInsets.only(
            top: 12,
            bottom: 0,
            left: 12, right: 12
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AspectRatio(
                    aspectRatio: 16/9,
                    child: FadeInImage(
                      fadeInDuration: Duration(milliseconds: 300),
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(
                        stream.thumbnails.hqdefault
                      ),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 4,
                        bottom: 4
                      ),
                      child: Text(
                        stream.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14
                        ),
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        stream.uploaderName,
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context).textTheme
                            .bodyText1.color.withOpacity(0.8)
                        ),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(EvaIcons.trash2Outline,
                  size: 16),
                onPressed: () {
                  prefs.streamPlaylistRemoveStream(currentPlaylist.name, stream);
                },
              )
            ],
          ),
        );
      },
    );
  }

}