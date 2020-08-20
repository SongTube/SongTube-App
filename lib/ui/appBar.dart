import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'animations/fadeIn.dart';
import 'animations/showUp.dart';

class FiveoAppBar extends StatefulWidget {
  final Function(String) onSearch;
  FiveoAppBar({
    @required this.onSearch
  });
  @override
  _FiveoAppBarState createState() => _FiveoAppBarState();
}

class _FiveoAppBarState extends State<FiveoAppBar> {
  
  // Enable Search
  bool showSearch;

  // SearchController
  TextEditingController textEditingController;

  // Focus Node
  FocusNode focusNode;

  void _onSearch(String searchQuery) {
    widget.onSearch(
      searchQuery != null
        ? searchQuery
        : textEditingController.text
    );
  }

  @override
  void initState() {
    super.initState();
    showSearch = false;
    textEditingController =
      new TextEditingController();
    focusNode = new FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kToolbarHeight,
      color: Theme.of(context).scaffoldBackgroundColor,
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
                      margin: EdgeInsets.only(
                        left: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.05),
                            offset: Offset(0, 3), //(x,y)
                            blurRadius: 6.0,
                            spreadRadius: 0.01 
                          )
                        ]
                      ),
                      child: Theme(
                        data: ThemeData(primaryColor: Theme.of(context).accentColor),
                        child: TextField(
                          keyboardType: TextInputType.url,
                          focusNode: focusNode,
                          controller: textEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(13.0),
                            prefixIcon: Icon(Icons.video_library),
                            hintText: 'Search...',
                            border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0, 
                              style: BorderStyle.none,
                            ),
                          ),
                          ),
                          onSubmitted: (searchQuery) {
                            FocusScope.of(context).unfocus();
                            _onSearch(searchQuery);
                          }
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
                    margin: EdgeInsets.only(left: 16),
                    child: Text(
                      "Fiveo",
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 2,
                        fontFamily: 'Varela',
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyText1.color
                      ),
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
                  child: Icon(showSearch ? Icons.clear : EvaIcons.searchOutline),
                ),
                onPressed: () {
                  if (!showSearch) {
                    focusNode.requestFocus();
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                  setState(() => showSearch = !showSearch);
                }
              ),
            ),
          )
        ],
    )
    );
  }
}