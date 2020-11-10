// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:songtube/internal/languages.dart';

// UI
import '../../../ui/animations/fadeIn.dart';
import '../../../ui/animations/showUp.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSearch;
  final Function onSearchTap;
  final bool openSearch;
  final Function onBack;
  SearchBar({
    @required this.controller,
    @required this.focusNode,
    @required this.onSearch,
    @required this.onSearchTap,
    @required this.openSearch,
    @required this.onBack
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kToolbarHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            offset: Offset(0.0, 4), //(x,y)
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
                  ignoring: !openSearch,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: openSearch ? 1.0 : 0.0,
                    curve: Curves.easeIn,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
                          onPressed: onBack
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Theme(
                              data: ThemeData(primaryColor: Theme.of(context).accentColor),
                              child: TextField(
                                focusNode: focusNode,
                                keyboardType: TextInputType.url,
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyText1.color,
                                  fontSize: 14
                                ),
                                controller: controller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(14.0),
                                  prefixIcon: Icon(MdiIcons.youtube, size: 32, color: Colors.red),
                                  hintText: Languages.of(context).labelSearchYoutube,
                                  hintStyle: TextStyle(
                                    color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.4),
                                    fontSize: 14
                                  ),
                                  border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 0, 
                                    style: BorderStyle.none,
                                  ),
                                ),
                                ),
                                onSubmitted: (searchQuery) {
                                  onSearch(searchQuery);
                                }
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ShowUpTransition(
                  forward: !openSearch,
                  slideSide: SlideFromSlide.TOP,
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
                  child: Icon(EvaIcons.searchOutline,
                    color: Theme.of(context).iconTheme.color),
                ),
                onPressed: () {
                  if (openSearch) {
                    if (controller.text == "") {
                      onSearchTap();
                    } else {
                      onSearch(controller.text);
                    }
                  } else {
                    onSearchTap();
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