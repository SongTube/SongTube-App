// Dart
import 'dart:async';
import 'dart:ui';

// Flutter
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Internal
import 'package:songtube/internal/lifecycleEvents.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/homeScreen/searchResults.dart';
import 'package:songtube/screens/homeScreen/shimmerPage.dart';
import 'package:songtube/screens/homeScreen/videoPage.dart';
import 'package:songtube/screens/settings.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

// UI
import 'package:songtube/screens/homeScreen/downloadMenu.dart';
import 'package:songtube/screens/homeScreen/IntroSplash.dart';
import 'package:songtube/ui/reusable/searchBar.dart';

StreamController<String> videoUrl = new StreamController.broadcast();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  // Variables
  Image cachedImage;
  bool _searching = false;
  bool get searching => _searching;
  set searching(bool value) {
    searchResults = null;
    _searching = value;
    setState((){});
  }
  List<SearchVideo> searchResults;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    WidgetsBinding.instance.addObserver(
      new LifecycleEventHandler(resumeCallBack: () => manager.handleIntent())
    );
    return GestureDetector(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SearchBar(
              padding: EdgeInsets.zero,
              textfieldColor: Theme.of(context).inputDecorationTheme.fillColor,
              hintText: "Quick Search",
              controller: manager.urlController,
              containerColor: Theme.of(context).cardColor,
              prefixIcon: Icon(MdiIcons.youtube),
              enablePasteButton: false,
              indicatorValue: manager.loadingVideo == true ? null : 0.0,
              onSearchPressed: manager.loadingVideo == true
                ? null
                : () async {
                  FocusScope.of(context).unfocus();
                  String url = manager.urlController.text;
                  // Check if Input is URL
                  bool validate = isURL(url);
                  if (validate == true) {
                    // If true, try fetch video Details
                    manager.getVideoDetails(manager.urlController.text);
                  } else {
                    // If false, search on Youtube
                    manager.loadHome(LoadingStatus.Failed);
                    searching = true;
                    YoutubeExplode yt = new YoutubeExplode();
                    SearchQuery search = await yt.search.queryFromPage(manager.urlController.text);
                    searchResults = new List<SearchVideo>();
                    search.content.whereType<SearchVideo>().forEach((element) {
                      searchResults.add(element);
                    });
                    setState((){});
                  }
                }
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: manager.mediaStreamReady
                  ? VideoPage()
                  : manager.loadingVideo
                    ? ShimmerPage()
                    : searching == true
                      ? searchResults == null
                        ? ShimmerPage()
                        : SearchResults(
                            results: searchResults,
                            onSelect: () {setState(() => searching = false);},
                          )
                      : IntroSplash()
              ),
            ),
          ],
        ),
        floatingActionButton: IgnorePointer(
          ignoring: manager.showFloatingActionButtom ? false : true,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: manager.showFloatingActionButtom ? 1.0 : 0.0,
            child: FloatingActionButton(
              child: Icon(Icons.file_download),
              backgroundColor: Theme.of(context).accentColor,
              foregroundColor: Colors.white,
              onPressed: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                List<dynamic> response = await showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                    ),
                ),
                  context: context,
                  builder: (context) {
                    return DownloadMenu(
                      videoList: manager.streamManifest.videoOnly.sortByVideoQuality(),
                      onSettingsPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Theme.of(context).canvasColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SettingsTab(),
                              )
                            );
                          }
                        );
                      },
                    );
                  }
                );
                if (response == null) return;
                manager.handleDownload(context, response);
              }
            ),
          ),
        ),
      ),
    );
  }
}
