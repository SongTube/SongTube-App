// Flutter
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/screens/mediaScreen/components/mediaListBase.dart';
import 'package:songtube/screens/mediaScreen/components/songsListView.dart';

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
    KeyboardVisibility.onChange.listen((bool visible) {
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
                  fontSize: 20,
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
                },
              ),
            ],
          ) : CommonSearchBar(
            textController: searchController,
            onClear: () => setState(() {
              searchController.clear();
              searchQuery = "";
            }),
            focusNode: searchNode,
            onChanged: (String search) => setState(() => searchQuery = search),
            hintText: Languages.of(context).labelSearchMedia,
          )
        ),
      ),
      body: Column(
        children: [
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
              child: SongsListView(
                songs: songs,
                searchQuery: searchQuery,
              ),
            ),
          ),
        ],
      ),
    );
  }
}