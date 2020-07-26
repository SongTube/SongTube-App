// Dart
import 'dart:async';
import 'dart:ui';

// Flutter
import 'package:flutter/material.dart';


// Internal
import 'package:songtube/internal/lifecycleEvents.dart';
import 'package:songtube/internal/youtube/downloader.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/homeScreen/shimmerPage.dart';
import 'package:songtube/screens/homeScreen/videoPage.dart';
import 'package:songtube/screens/settings.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;
import 'package:provider/provider.dart';

// UI
import 'package:songtube/ui/downloadMenu.dart';
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
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: manager.mediaStreamReady
                  ? VideoPage()
                  : manager.showEmptyScreenWidget
                    ? IntroSplash()
                    : ShimmerPage()
              ),
            ),
            SearchBar(
              padding: EdgeInsets.zero,
              textfieldColor: Theme.of(context).inputDecorationTheme.fillColor,
              hintText: "URL",
              controller: manager.urlController,
              containerColor: Theme.of(context).cardColor,
              prefixIcon: Icon(Icons.https),
              indicatorValue: manager.showLoadingBar == true ? null : 0.0,
              onSearchPressed: manager.showLoadingBar
                ? null
                : () async {
                  await manager.getMediaStreamInfo(manager.getIdFromLink());
                }
            )
          ],
        ),
        floatingActionButton: IgnorePointer(
          ignoring: manager.showFloatingActionButtom ? false : true,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: manager.showFloatingActionButtom ? 1.0 : 0.0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: FloatingActionButton(
                child: Icon(Icons.file_download),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                onPressed: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  List<youtube.VideoStreamInfo> videoList = Downloader.extractVideoStreams(manager.mediaStream);
                  List<String> response = await showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  ),
                    context: context,
                    builder: (context) {
                      return CustomDownloadMenu(
                        videoList: videoList,
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
      ),
    );
  }
}
