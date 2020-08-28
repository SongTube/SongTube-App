// Flutter
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/navigateScreen/searchPage.dart';
import 'package:songtube/screens/navigateScreen/shimmer/shimmerSearchPage.dart';

// UI
import 'package:songtube/ui/appBar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Navigate extends StatefulWidget {
  final String searchQuery;
  Navigate({
    this.searchQuery
  });
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {

  // YT Explode Instance
  YoutubeExplode yt;

  // List Videos
  List<SearchVideo> searchResults;

  @override
  void initState() {
    super.initState();
    yt= new YoutubeExplode();
    searchResults = new List<SearchVideo>();
    search(widget.searchQuery);
  }

  void search([String searchQuery]) async {
    setState(() => searchResults.clear());
    SearchQuery search = await yt.search
      .queryFromPage(
        searchQuery == null
          ? String.fromCharCodes(Iterable.generate(
              1, (_) => 'qwertyuiopasdfghjlcvbnm'
              .codeUnitAt(Random().nextInt('qwertyuiopasdfgjlcvbnm'.length))
            ))
          : searchQuery
      );
    searchResults = new List<SearchVideo>();
    search.content.whereType<SearchVideo>().forEach((element) {
      searchResults.add(element);
    });
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        children: [
          searchBar(context),
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: searchResults.isNotEmpty
                ? SearchPage(
                    results: searchResults,
                    onSelect: () {setState(() {});},
                  )
                : ShimmerSearchPage()
            ),
          )
        ]
      )
    );
  }

  Widget searchBar(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return SearchBar(
      controller: manager.urlController,
      onSearch: (String searchQuery) async {
        FocusScope.of(context).unfocus();
        search(manager.urlController.text);
      }
    );
  }
}