// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/homeScreen/pages/components/homePage/pageBody.dart';
import 'package:songtube/screens/homeScreen/pages/components/homePage/searchBar.dart';
import 'package:songtube/ui/components/searchHistory.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';
import 'package:songtube/ui/internal/lifecycleEvents.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HomePage extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onQuickSearch;
  HomePage({
    @required this.controller,
    @required this.onQuickSearch
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // TextController & FocusNode
  FocusNode quickSearchFocusNode;

  // ClipBoard Data
  bool clipboardHasLink;
  String clipboardLink;
  LinkType linkType;

  @override
  void initState() {
    clipboardHasLink = false;
    clipboardLink = "";
    quickSearchFocusNode = new FocusNode();
    super.initState();
    if (mounted) {
      WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) {
          checkClipboard();
      });
      WidgetsBinding.instance.addObserver(
        new LifecycleEventHandler(resumeCallBack: () {
          Future.delayed(Duration(milliseconds: 500), () =>
            checkClipboard());
          return;
        }, )
      );
    }
  }

  Future<void> checkClipboard() async {
    ClipboardData data = await Clipboard.getData('text/plain');
    if (data == null) {
      clipboardLink = "";
      if (mounted)
        setState(() => clipboardHasLink = false);
      return;
    }
    if (PlaylistId.parsePlaylistId(data.text) != null) {
      clipboardLink = PlaylistId.parsePlaylistId(data.text);
      linkType = LinkType.Playlist;
      if (mounted)
        setState(() => clipboardHasLink = true);
    } else if (VideoId.parseVideoId(data.text) != null) {
      clipboardLink = VideoId.parseVideoId(data.text);
      linkType = LinkType.Video;
      if (mounted)
        setState(() => clipboardHasLink = true);
    } else {
      clipboardLink = "";
      linkType = null;
      if (mounted)
        setState(() => clipboardHasLink = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() => manager.showSearchBar = false);
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: ShowUpTransition(
            forward: true,
            duration: Duration(milliseconds: 400),
            slideSide: SlideFromSlide.TOP,
            child: HomePageSearchBar(
              showQuickSearch: manager.showSearchBar,
              controller: widget.controller,
              quickSearchFocusNode: quickSearchFocusNode,
              onSearch: (String searchQuery) {
                widget.onQuickSearch(searchQuery);
              }
            ),
          ),
        ),
        body: Stack(
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: manager.showSearchBar ? SearchHistoryList(
                onItemTap: (String searchQuery) =>
                  widget.onQuickSearch(searchQuery),
              ) : Container(),
            ),
            ShowUpTransition(
              forward: !manager.showSearchBar,
              duration: Duration(milliseconds: 400),
              slideSide: SlideFromSlide.BOTTOM,
              child: HomePageBody(
                onQuickSearchTap: () {
                  setState(() {
                    manager.showSearchBar = true;
                  });
                  quickSearchFocusNode.requestFocus();
                },
              )
            ),
          ],
        ),
        floatingActionButton: ShowUpTransition(
          forward: clipboardHasLink ? true : false,
          duration: Duration(milliseconds: 400),
          slideSide: SlideFromSlide.BOTTOM,
          child: FloatingActionButton(
            elevation: 0,
            child: Icon(
              EvaIcons.linkOutline,
              color: Theme.of(context).accentColor
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            onPressed: () => linkType == LinkType.Playlist
              ? manager.getPlaylistDetails(clipboardLink)
              : manager.getVideoDetails(clipboardLink),
          ),
        ),
      ),
    );
  }
}