// Dart
import 'dart:ui';

// Flutter
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Internal
import 'package:songtube/internal/lifecycleEvents.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/homeScreen/shimmer/shimmerVideoPage.dart';
import 'package:songtube/screens/homeScreen/videoPage.dart';
import 'package:songtube/screens/settings.dart';
import 'package:songtube/ui/animations/showUp.dart';

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

  // ClipBoard Data
  bool clipboardHasLink;
  String clipboardLink;

  // IntroSplash Animation
  bool forward;

  @override
  void initState() {
    super.initState();
    clipboardHasLink = false;
    clipboardLink = "";
    forward = true;
    checkClipboard();
  }

  void checkClipboard() {
    Clipboard.getData('text/plain').then((data) {
      if (VideoId.parseVideoId(data.text) == null) {
        clipboardLink = "";
        setState(() => clipboardHasLink = false);
      } else {
        clipboardLink = data.text;
        setState(() => clipboardHasLink = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    WidgetsBinding.instance.addObserver(
      new LifecycleEventHandler(resumeCallBack: () {
        manager.handleIntent();
        checkClipboard();
        return;
      })
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
                    : Center(child: IntroSplash(forward))
              ),
            ),
          ],
        ),
        floatingActionButton: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: manager.showEmptyScreenWidget
            ? ShowUpTransition(
                forward: clipboardHasLink ? true : false,
                duration: Duration(milliseconds: 600),
                slideSide: SlideFromSlide.BOTTOM,
                child: FloatingActionButton.extended(
                  elevation: 120,
                  label: Text("Clipboard Search", style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color
                  )),
                  icon: Icon(
                    EvaIcons.linkOutline,
                    color: Theme.of(context).accentColor
                  ),
                  backgroundColor: Theme.of(context).cardColor,
                  onPressed: () async {
                    setState(() => forward = false);
                    await Future.delayed(Duration(milliseconds: 400), () {
                      manager.getVideoDetails(clipboardLink);
                    });
                    await Future.delayed(Duration(milliseconds: 400), () {
                      setState(() => forward = true);
                    });
                  },
                ),
              )
            : IgnorePointer(
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
      ),
    );
  }
}
