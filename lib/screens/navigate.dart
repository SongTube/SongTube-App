// Dart
import 'dart:math';

// Flutter
import 'package:flutter/material.dart';
import 'package:songtube/provider/app_provider.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/navigateScreen/searchPage.dart';
import 'package:songtube/screens/navigateScreen/components/shimmer/shimmerSearchPage.dart';
import 'package:songtube/ui/components/searchHistory.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:provider/provider.dart';

// UI
import 'package:songtube/screens/navigateScreen/components/searchBar.dart';

List<dynamic> searchResults = new List<SearchVideo>();

class Navigate extends StatefulWidget {
  final String searchQuery;
  Navigate({
    this.searchQuery,
  });
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {

  // YT Explode Instance
  YoutubeExplode yt;

  // No Internet
  bool errorSearching;

  // Focus Node
  FocusNode searchNode;

  @override
  void initState() {
    super.initState();
    errorSearching = false;
    searchNode = new FocusNode();
    yt = new YoutubeExplode();
    if (searchResults.isEmpty || widget.searchQuery != null) {
      search(widget.searchQuery);
    }
  }

  Future<void> search([String searchQuery]) async {
    errorSearching = false;
    searchResults.clear();
    setState(() {});
    var search = await yt.search
      .getVideosFromPage(
        searchQuery == null
          ? String.fromCharCodes(Iterable.generate(
              1, (_) => 'qwertyuiopasdfghjlcvbnm'
              .codeUnitAt(Random().nextInt('qwertyuiopasdfgjlcvbnm'.length))
            ))
          : searchQuery
      ).take(20).toList();
    searchResults = search;
    if (mounted) {
      if (searchQuery != null) {
        Provider.of<AppDataProvider>(context, listen: false)
          .addStringtoSearchHistory(searchQuery.trim());
      }
      setState((){});
    }
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
            search(manager.urlController.text);
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
          search(item);
        }
      );
    } else {
      if (errorSearching) {
        return Center(
          child: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => search(widget.searchQuery),
          ),
        );
      } else {
        if (searchResults.isNotEmpty) {
          return SearchPage(
            results: searchResults,
          );
        } else {
          return const ShimmerSearchPage();
        }
      }
    }
  }

}