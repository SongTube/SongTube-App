// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/provider/managerProvider.dart';

// Internal
import 'package:songtube/screens/mediaScreen/tabs/downloadsTab.dart';
import 'package:songtube/screens/mediaScreen/tabs/musicTab.dart';
import 'package:songtube/screens/mediaScreen/tabs/videosTab.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:songtube/screens/mediaScreen/components/mediaSearchBar.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class MediaScreen extends StatefulWidget {
  @override
  _MediaScreenState createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {

  // Search Controller and FocusNode
  TextEditingController searchController;
  FocusNode searchNode;

  // Current Search Query
  String searchQuery = "";

  @override
  void initState() {
    searchController = new TextEditingController();
    searchNode = new FocusNode();
    KeyboardVisibility.onChange.listen((bool visible) {
        if (visible == false) {
          searchNode.unfocus();
        }
      }
    );
    Provider.of<DownloadsProvider>
      (context, listen: false).getDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 12,
          shadowColor: Colors.black.withOpacity(0.15),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: ShowUpTransition(
            forward: true,
            duration: Duration(milliseconds: 400),
            slideSide: SlideFromSlide.TOP,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: !manager.showSearchBar ? Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8, left: 16),
                    child: Icon(
                      EvaIcons.musicOutline,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Text(
                    Languages.of(context).labelMedia,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "YTSans",
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      EvaIcons.searchOutline,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {
                      setState(() {
                        manager.showSearchBar = true;
                        if (manager.showSearchBar == true)
                          searchNode.requestFocus();
                      });
                    },
                  ),
                  SizedBox(width: 16)
                ],
              ) : MediaSearchBar(
                textController: searchController,
                onClear: () => setState(() {
                  searchController.clear();
                  searchQuery = "";
                }),
                focusNode: searchNode,
                onChanged: (String search) => setState(() => searchQuery = search),
              )
            ),
          ),
          bottom: TabBar(
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Theme.of(context).textTheme.bodyText1.color,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Theme.of(context).accentColor,
            tabs: [
              Tab(child: Text(
                Languages.of(context).labelDownloads,
                style: TextStyle(
                  fontFamily: 'YTSans',
                ),
              )),
              Tab(child: Text(
                Languages.of(context).labelMusic,
                style: TextStyle(
                  fontFamily: 'YTSans',
                ),
              )),
              Tab(child: Text(
                Languages.of(context).labelVideos,
                style: TextStyle(
                  fontFamily: 'YTSans',
                ),
              ))
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MediaDownloadTab(searchQuery),
            MediaMusicTab(searchQuery),
            MediaVideoTab(searchQuery)
          ],
        ),
      ),
    );
  }
}