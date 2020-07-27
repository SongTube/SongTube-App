import 'package:flutter/material.dart';
import 'package:songtube/ui/reusable/searchBar.dart';

class YoutubePage extends StatefulWidget {
  @override
  _YoutubePageState createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> with TickerProviderStateMixin {

  // Controllers
  TextEditingController searchTextController;

  // Variables
  bool showSearchBar;
  bool pageLoaded;

  void initState() {
    searchTextController = new TextEditingController();
    showSearchBar = true;
    super.initState();
  }

  searchForVideos() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
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
              backgroundColor: Theme.of(context).accentColor,
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