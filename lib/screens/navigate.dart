// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/app_provider.dart';

// Packages
import 'package:provider/provider.dart';

// UI
import 'package:songtube/ui/yt_webview.dart';
import 'package:songtube/ui/reusable/searchbar.dart';

class Navigate extends StatefulWidget {
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {

  // Controllers
  TextEditingController searchTextController;
  FocusNode searchFocusNode;

  // Variables
  bool showSearchBar;
  bool pageLoaded;

  @override
  bool get wantKeepAlive => true;

  void initState() {
    searchTextController = new TextEditingController();
    searchFocusNode = new FocusNode();
    showSearchBar = true;
    super.initState();
  }

  searchForVideos() {

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    return appData.useYoutubeWebview
    ? YoutubeWebview()
    : Scaffold(
      backgroundColor: Colors.redAccent,
      body: Column(
        children: <Widget>[
          AnimatedSize(
            duration: Duration(milliseconds: 400),
            vsync: this,
            curve: Curves.easeInOutBack,
            child: showSearchBar
              ? SearchBar(
                  hintText: "Search Youtube...",
                  indicatorValue: 0.0,
                  focusNode: searchFocusNode,
                  controller: searchTextController,
                  containerColor: Colors.white,
                  textfieldColor: Colors.grey[200],
                  onSearchPressed: () {
                    setState(() => showSearchBar = false);
                  },
                  enablePasteButton: false,
                )
              : Container()
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      
                    ],
                  ),
                ),
              )
            ),
          )
        ],
      ),
      floatingActionButton: IgnorePointer(
        ignoring: showSearchBar ? true : false,
        child: AnimatedOpacity(
          opacity: showSearchBar ? 0.0 : 1.0,
          duration: Duration(milliseconds: 200),
          child: Padding(
            padding: EdgeInsets.only(right: 8),
            child: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              child: Icon(Icons.search),
              onPressed: () {
                setState(() => showSearchBar = true);
              },
            ),
          ),
        ),
      )
    );
  }
}