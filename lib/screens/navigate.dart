// Dart
import 'dart:async';
import 'dart:math';

// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/navigateScreen/components/shimmer/shimmerSearchPage.dart';
import 'package:songtube/ui/components/searchHistory.dart';
import 'package:songtube/provider/app_provider.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:provider/provider.dart';

// UI
import 'package:songtube/screens/navigateScreen/components/searchBar.dart';

import 'navigateScreen/components/videoTile.dart';

class Navigate extends StatefulWidget {
  final String searchQuery;
  Navigate({
    this.searchQuery,
  });
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> with TickerProviderStateMixin {

  // YT Explode Instance
  YoutubeExplode yt;

  // Focus Node
  FocusNode searchNode;

  // Current Search Query
  String currentStateSearchQuery;

  // Results Counter
  int resultsCounter = 0;

  // Search Stream
  StreamSubscription searchStream;

  // ListView Scroll Controller
  ScrollController scrollController;

  // Searching Status
  bool isSearching;

  void fillSearchResults() {
    if (isSearching) return;
    setState(() => isSearching = true);
    ManagerProvider manager = Provider.of<ManagerProvider>
      (context, listen: false);
    if (manager.navigateQuery == null) {
      manager.navigateQuery = String.fromCharCodes(Iterable.generate(
        1, (_) => 'qwertyuiopasdfghjlcvbnm'
        .codeUnitAt(Random().nextInt('qwertyuiopasdfgjlcvbnm'.length))
      ));
    }
    if (currentStateSearchQuery == null || currentStateSearchQuery != manager.navigateQuery) {
      manager.navigateSearchResults = new List<dynamic>();
      if (searchStream != null) searchStream.cancel();
      setState(() {});
      resultsCounter = 0;
      currentStateSearchQuery = manager.navigateQuery;
      if (currentStateSearchQuery.length > 1) {
        Future.delayed(Duration(milliseconds: 400), () =>
          Provider.of<AppDataProvider>(context, listen: false)
            .addStringtoSearchHistory(currentStateSearchQuery.trim()
        ));
      }
      searchStream = yt.search.getVideosFromPage(manager.navigateQuery)
        .listen((event) {
          manager.navigateSearchResults.add(event);
          resultsCounter++;
          if (resultsCounter >= 10) {
            searchStream.pause();
            isSearching = false;
            setState(() {});
          }
        });
    } else {
      resultsCounter = 0;
      searchStream.resume();
    }
  }

  @override
  void initState() {
    super.initState();
    searchNode = new FocusNode();
    yt = new YoutubeExplode();
    isSearching = false;
    fillSearchResults();
    scrollController = new ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    searchStream.cancel();
    yt.close();
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 12,
        shadowColor: Colors.black.withOpacity(0.3),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: SearchBar(
          focusNode: searchNode,
          controller: manager.urlController,
          onSearch: (String searchQuery) async {
            searchNode.unfocus();
            manager.showSearchBar = false;
            manager.navigateQuery = manager.urlController.text;
            fillSearchResults();
          },
          onSearchTap: () {
            setState(() => manager.showSearchBar = !manager.showSearchBar);
            if (manager.showSearchBar == true)
              searchNode.requestFocus();
            else
              searchNode.unfocus();
          },
          openSearch: manager.showSearchBar,
          onBack: () {
            FocusScope.of(context).unfocus();
            manager.showSearchBar = false;
          }
        ),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: currentBody(context),
      )
    );
  }

  Widget currentBody(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    if (manager.showSearchBar) {
      return SearchHistoryList(
        margin: EdgeInsets.zero,
        borderRadius: 0,
        onItemTap: (String item) {
          searchNode.unfocus();
          manager.showSearchBar = false;
          manager.navigateQuery = item;
          fillSearchResults();
        }
      );
    } else {
      if (manager.navigateSearchResults.isNotEmpty) {
        List<dynamic> results = manager.navigateSearchResults;
        return NotificationListener(
          child: ListView.builder(
            controller: scrollController,
            itemCount: results.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: results.length-1 == index ? 16 : 0
                ),
                child: Column(
                  children: [
                    VideoTile(
                      searchItem: results[index],
                    ),
                    if (results.length-1 == index)
                    AnimatedSize(
                      vsync: this,
                      duration: Duration(milliseconds: 400),
                      child: isSearching
                        ? CircularProgressIndicator(
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          )
                        : Container(),
                    )
                  ],
                ),
              );
            }
          ),
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              if (scrollController.position.pixels > scrollController.position.maxScrollExtent-400) {
                if (isSearching == false) {
                  fillSearchResults();
                }
              }
            }
            return true;
          },
        );
      } else {
        return const ShimmerSearchPage();
      }
    }
  }

}