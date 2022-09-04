// Flutter
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/screens/musicScreen/components/mediaListBase.dart';
import 'package:songtube/screens/musicScreen/tabs/albums.dart';
import 'package:songtube/screens/musicScreen/tabs/artist.dart';
import 'package:songtube/screens/musicScreen/tabs/genre.dart';
import 'package:songtube/screens/musicScreen/tabs/playlists.dart';
import 'package:songtube/screens/musicScreen/tabs/songs.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:songtube/ui/components/autoHideScaffold.dart';
import 'package:songtube/ui/components/searchBar.dart';

class MediaScreen extends StatefulWidget {
  @override
  _MediaScreenState createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {

  // Search Controller and FocusNode
  TextEditingController searchController;
  FocusNode searchNode;

  // Current Search Query
  String searchQuery = "";
  bool showSearchBar = false;

  @override
  void initState() {
    searchController = new TextEditingController();
    searchNode = new FocusNode();
    var keyboardVisibilityController = KeyboardVisibilityController();
    searchNode.addListener(() {
      if (!searchNode.hasFocus && searchQuery.isEmpty) {
        setState(() => showSearchBar = false);
      }
    });
    keyboardVisibilityController.onChange.listen((bool visible) {
        if (visible == false) {
          searchNode.unfocus();
        }
      }
    );
    Provider.of<MediaProvider>
      (context, listen: false).getDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    List<MediaItem> songs = <MediaItem>[];
    if (searchQuery == "") {
      songs = mediaProvider.listMediaItems;
    } else {
      mediaProvider.listMediaItems.forEach((item) {
        if (item.title.toLowerCase()
          .replaceAll(RegExp("[^0-9a-zA-Z]+"), "")
          .contains(searchQuery.toLowerCase()
          .replaceAll(RegExp("[^0-9a-zA-Z]+"), ""))
        ) {
          songs.add(item);
        }
      });
    }
    return AutoHideScaffold(
      backgroundColor: Theme.of(context).cardColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          child: !showSearchBar ? Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                child: Icon(
                  EvaIcons.musicOutline,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Text(
                Languages.of(context).labelMusic,
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  EvaIcons.searchOutline,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  setState(() => showSearchBar = !showSearchBar);
                  searchNode.requestFocus();
                },
              ),
            ],
          ) : CommonSearchBar(
            textController: searchController,
            onClear: () {
              setState(() {
                searchController.clear();
                searchQuery = "";
              });
            },
            focusNode: searchNode,
            onChanged: (String search) => setState(() => searchQuery = search),
            hintText: Languages.of(context).labelSearchMedia,
          )
        ),
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: 5,
        child: Column(
          children: [
            Container(
              height: 40,
              color: Theme.of(context).cardColor,
              child: TabBar(
                isScrollable: true,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3
                ),
                unselectedLabelStyle: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2
                ),
                labelColor: Theme.of(context).accentColor,
                unselectedLabelColor: Theme.of(context).textTheme.bodyText1
                  .color.withOpacity(0.4),
                indicator: MD2Indicator(
                  indicatorSize: MD2IndicatorSize.tiny,
                  indicatorHeight: 4,
                  indicatorColor: Theme.of(context).accentColor,
                ),
                tabs: [
                  Tab(child: Text(
                    "Songs"
                  )),
                  Tab(child: Text(
                    "Playlists"
                  )),
                  Tab(child: Text(
                    "Albums"
                  )),
                  Tab(child: Text(
                    "Artists"
                  )),
                  Tab(child: Text(
                    "Genres"
                  ))
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
              child: MediaListBase(
                isLoading: mediaProvider.loadingMusic,
                isEmpty: mediaProvider.listMediaItems.isEmpty,
                listType: MediaListBaseType.Any,
                child: TabBarView(
                  children: [
                    MusicScreenSongsTab(songs: songs, searchQuery: searchQuery),
                    MusicScreenPlaylistTab(),
                    MusicScreenAlbumsTab(songs: songs, searchQuery: searchQuery),
                    MusicScreenArtistTab(songs: songs, searchQuery: searchQuery),
                    MusicScreenGenreTab(songs: songs, searchQuery: searchQuery),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}