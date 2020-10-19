// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/app_provider.dart';
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

  @override
  void initState() {
    clipboardHasLink = false;
    clipboardLink = "";
    WidgetsBinding.instance.addObserver(
      new LifecycleEventHandler(resumeCallBack: () {
        Provider.of<ManagerProvider>(context, listen: false).handleIntent();
        checkClipboard();
        return;
      })
    );
    checkClipboard();
    quickSearchFocusNode = new FocusNode();
    super.initState();
  }

  Future<void> checkClipboard() async {
    ClipboardData data = await Clipboard.getData('text/plain');
    if (data == null && mounted) {
      clipboardLink = "";
      setState(() => clipboardHasLink = false);
      return;
    }
    if (VideoId.parseVideoId(data.text) == null) {
      clipboardLink = "";
      setState(() => clipboardHasLink = false);
    } else {
      clipboardLink = data.text;
      setState(() => clipboardHasLink = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        Future.delayed(
          Duration(milliseconds: 200), () =>
          setState(() => manager.showSearchBar = false)
        );
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
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: manager.showSearchBar
            ? SearchHistoryList(
                onItemTap: (String searchQuery) =>
                  widget.onQuickSearch(searchQuery),
              )
            : ShowUpTransition(
                forward: true,
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
            onPressed: () => manager.getVideoDetails(clipboardLink)
          ),
        ),
      ),
    );
  }
}