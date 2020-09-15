// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class IntroSplash extends StatefulWidget {
  final bool forward;
  final TextEditingController controller;
  final Function(String) onQuickSearch;
  IntroSplash({
    @required this.forward,
    @required this.controller,
    @required this.onQuickSearch
  });

  @override
  _IntroSplashState createState() => _IntroSplashState();
}

class _IntroSplashState extends State<IntroSplash> {
  
  // Show QuickSearch
  bool showQuickSearch;

  // Focus Node
  FocusNode quickSearchFocusNode;

  @override
  void initState() {
    super.initState();
    quickSearchFocusNode = new FocusNode();
    showQuickSearch = false;
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          showQuickSearch = false;
        });
      },
      child: Stack(
        children: [
          AnimatedOpacity(
            opacity: showQuickSearch ? 1.0 : 0.0,
            duration: Duration(milliseconds: 600),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
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
                    controller: widget.controller,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                    decoration: InputDecoration(
                      hintText: 'Quick Search...',
                      border: InputBorder.none,
                      icon: Icon(EvaIcons.searchOutline),
                    ),
                    onSubmitted: (String searchQuery) {
                      widget.onQuickSearch(searchQuery);
                      Future.delayed(Duration(milliseconds: 100), () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          showQuickSearch = false;
                        });
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: showQuickSearch ? Container() : Stack(
              children: <Widget>[
                ShowUpTransition(
                  forward: true,
                  duration: Duration(milliseconds: 400),
                  slideSide: SlideFromSlide.TOP,
                  child: Container(
                    width: 180,
                    margin: EdgeInsets.only(left: 8, top: 8),
                    padding: EdgeInsets.only(bottom: 12, left: 12, top: 8),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 8, right: 8, top: 2),
                          child: Icon(
                            MdiIcons.youtube,
                            size: 32,
                            color: Theme.of(context).accentColor
                          )
                        ),
                        Text(
                          "SongTube",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "YTSans"
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ShowUpTransition(
                  forward: true,
                  duration: Duration(milliseconds: 400),
                  slideSide: SlideFromSlide.BOTTOM,
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.75,
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.only(left: 32, right: 32, bottom: 32),
                      height: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          AnimatedOpacity(
                            opacity: manager.showEmptyScreenWidget == true ? 1.0 : 0.0,
                            duration: (Duration(milliseconds: 300)),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  MdiIcons.youtube,
                                  size: 170,
                                  color: Colors.black12.withOpacity(0.04)
                                ),
                                Icon(
                                  MdiIcons.youtube,
                                  size: 150,
                                  color: Theme.of(context).accentColor
                                )
                              ],
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: manager.showEmptyScreenWidget == true ? 1.0 : 0.0,
                            duration: (Duration(milliseconds: 600)),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showQuickSearch = true;
                                        });
                                        quickSearchFocusNode.requestFocus();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: TextField(
                                          enabled: false,
                                          style: TextStyle(
                                            color: Theme.of(context).textTheme.bodyText1.color
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Quick Search...',
                                            border: InputBorder.none,
                                            icon: Icon(EvaIcons.searchOutline),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Theme.of(context).scaffoldBackgroundColor
                                    ),
                                    child: Icon(
                                      MdiIcons.arrowRight,
                                      color: Theme.of(context).iconTheme.color
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25)
              ],
            ),
          ),
        ],
      ),
    );
  }
}