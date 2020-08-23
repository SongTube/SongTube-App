import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'animations/fadeIn.dart';
import 'animations/showUp.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  SearchBar({
    @required this.controller,
    @required this.onSearch
  });
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  
  // Enable Search
  bool showSearch;

  // Focus Node
  FocusNode focusNode;

  void _onSearch(String searchQuery) {
    widget.onSearch(searchQuery);
  }

  @override
  void initState() {
    super.initState();
    showSearch = false;
    focusNode = new FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kToolbarHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.08),
            offset: Offset(0.0, 1.5), //(x,y)
            blurRadius: 7.0,
            spreadRadius: 0.1
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                IgnorePointer(
                  ignoring: !showSearch,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: showSearch ? 1.0 : 0.0,
                    curve: Curves.easeIn,
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.only(
                        left: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Theme(
                        data: ThemeData(primaryColor: Theme.of(context).accentColor),
                        child: Stack(
                          children: [
                            TextField(
                              keyboardType: TextInputType.url,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                                fontSize: 14
                              ),
                              focusNode: focusNode,
                              controller: widget.controller,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(14.0),
                                prefixIcon: Icon(MdiIcons.youtube, size: 32, color: Colors.red),
                                hintText: 'Search Youtube...',
                                hintStyle: TextStyle(
                                  color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.4),
                                  fontSize: 14
                                ),
                                border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 0, 
                                  style: BorderStyle.none,
                                ),
                              ),
                              ),
                              onChanged: (_) => setState(() {}),
                              onSubmitted: (searchQuery) {
                                FocusScope.of(context).unfocus();
                                if (searchQuery == "" && searchQuery == null) {
                                  FocusScope.of(context).unfocus();
                                  setState(() => showSearch = false);
                                } else {
                                  _onSearch(searchQuery);
                                }
                              }
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: widget.controller.text != ""
                                ? IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      size: 20,
                                      color: Theme.of(context).iconTheme.color
                                    ),
                                    onPressed: () {
                                      setState(() => widget.controller.clear());
                                    },
                                  )
                                : Container(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ShowUpTransition(
                  forward: !showSearch,
                  duration: Duration(milliseconds: 300),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          child: Icon(
                            MdiIcons.youtube,
                            color: Colors.red,
                            size: 32,
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: Text(
                            "YouTube",
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'YTSans',
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).textTheme.bodyText1.color
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          FadeInTransition(
            duration: Duration(milliseconds: 400),
            curve: Curves.fastLinearToSlowEaseIn,
            child: Container(
              margin: EdgeInsets.only(right: 8),
              child: IconButton(
                icon: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: Icon(EvaIcons.searchOutline),
                ),
                onPressed: () {
                  if (!showSearch) {
                    focusNode.requestFocus();
                    setState(() => showSearch = true);
                  } else {
                    if (widget.controller.text != "") {
                      _onSearch(widget.controller.text);
                    } else {
                      FocusScope.of(context).unfocus();
                      setState(() => showSearch = false);
                    }
                  }
                }
              ),
            ),
          )
        ],
    )
    );
  }
}