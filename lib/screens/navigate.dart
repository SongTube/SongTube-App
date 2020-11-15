// Dart
import 'dart:async';

// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/navigateScreen/components/shimmer/shimmerSearchPage.dart';
import 'package:songtube/ui/components/searchHistory.dart';
import 'package:songtube/provider/configurationProvider.dart';

// Packages
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

  // Focus Node
  FocusNode searchNode;

  // ListView Scroll Controller
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    searchNode = new FocusNode();
    scrollController = new ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ManagerProvider>(context, listen: false)
        .updateYoutubeSearchResults();
    });
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    ConfigurationProvider appData = Provider.of<ConfigurationProvider>(context);
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
            manager.updateYoutubeSearchResults(updateResults: true);
            if (searchQuery.length > 1) {
              Future.delayed(Duration(milliseconds: 400), () =>
                appData.addStringtoSearchHistory(searchQuery.trim()
              ));
            }
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
          manager.updateYoutubeSearchResults(updateResults: true);
          if (item.length > 1) {
            Future.delayed(Duration(milliseconds: 400), () =>
              Provider.of<ConfigurationProvider>(context, listen: false)
                .addStringtoSearchHistory(item.trim()
            ));
          }
        }
      );
    } else {
      if (manager.youtubeSearchResults.isNotEmpty) {
        List<dynamic> results = manager.youtubeSearchResults;
        return NotificationListener(
          child: ListView.builder(
            key: PageStorageKey('youtubeSearchResults'),
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
                      child: manager.searchStreamRunning
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
                if (manager.searchStreamRunning == false) {
                  manager.updateYoutubeSearchResults();
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