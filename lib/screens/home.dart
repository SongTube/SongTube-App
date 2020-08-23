// Dart
import 'dart:ui';

// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/internal/lifecycleEvents.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/homeScreen/shimmer/shimmerVideoPage.dart';
import 'package:songtube/screens/homeScreen/videoPage.dart';
import 'package:songtube/screens/settings.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:provider/provider.dart';

// UI
import 'package:songtube/screens/homeScreen/downloadMenu.dart';
import 'package:songtube/screens/homeScreen/IntroSplash.dart';
import 'package:rxdart/rxdart.dart';

BehaviorSubject<String> videoUrl = new BehaviorSubject();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    WidgetsBinding.instance.addObserver(
      new LifecycleEventHandler(resumeCallBack: () => manager.handleIntent())
    );
    return GestureDetector(
      child: Scaffold(
        resizeToAvoidBottomInset:
          manager.mediaStreamReady == false ? false : true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: manager.mediaStreamReady
                  ? VideoPage()
                  : manager.loadingVideo
                    ? ShimmerVideoPage()
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
