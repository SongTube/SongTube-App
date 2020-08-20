import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'animations/fadeIn.dart';
import 'animations/showUp.dart';

class SongTubeAppBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  SongTubeAppBar({
    @required this.controller,
    @required this.onSearch
  });
  @override
  _SongTubeAppBarState createState() => _SongTubeAppBarState();
}

class _SongTubeAppBarState extends State<SongTubeAppBar> {
  
  // Enable Search
  bool showSearch;

  // Focus Node
  FocusNode focusNode;

  void _onSearch(String searchQuery) {
    widget.onSearch(
      searchQuery != null
        ? searchQuery
        : widget.controller.text
    );
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
      height: kToolbarHeight*0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            offset: Offset(0.0, 1.5), //(x,y)
            blurRadius: 10.0,
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
                      margin: EdgeInsets.only(
                        left: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Theme(
                        data: ThemeData(primaryColor: Theme.of(context).accentColor),
                        child: TextField(
                          keyboardType: TextInputType.url,
                          focusNode: focusNode,
                          controller: widget.controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            prefixIcon: Icon(MdiIcons.youtube, size: 32),
                            hintText: 'Search Youtube...',
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
                            "SongTube",
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'YTSans',
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800]
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
                  child: Icon(showSearch ? Icons.clear : EvaIcons.searchOutline),
                ),
                onPressed: () {
                  if (!showSearch) {
                    focusNode.requestFocus();
                    setState(() => showSearch = true);
                  } else {
                    if (widget.controller.text != "") {
                      widget.controller.clear();
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