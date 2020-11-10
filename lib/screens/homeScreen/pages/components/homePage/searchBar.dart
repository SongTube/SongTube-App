import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';

class HomePageSearchBar extends StatelessWidget {
  final bool showQuickSearch;
  final TextEditingController controller;
  final FocusNode quickSearchFocusNode;
  final Function(String) onSearch;
  HomePageSearchBar({
    @required this.showQuickSearch,
    @required this.controller,
    @required this.quickSearchFocusNode,
    @required this.onSearch
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      child: showQuickSearch ? Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.only(left: 16, right: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.08),
              offset: Offset(0,0),
              spreadRadius: 0.01,
              blurRadius: 20.0
            )
          ]
        ),
        child: TextField(
          focusNode: quickSearchFocusNode,
          controller: controller,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color
          ),
          decoration: InputDecoration(
            hintText: Languages.of(context).labelQuickSearch,
            border: InputBorder.none,
            icon: Icon(EvaIcons.searchOutline),
          ),
          onSubmitted: (searchQuery) =>
            onSearch(searchQuery)
        ),
      ) : Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 8, left: 16),
            child: Icon(
              EvaIcons.homeOutline,
              color: Theme.of(context).accentColor
            ),
          ),
          Text(
            "SongTube",
            style: TextStyle(
              fontSize: 24,
              fontFamily: "YTSans",
              color: Theme.of(context).textTheme.bodyText1.color
            ),
          ),
        ],
      ),
    );
  }
}