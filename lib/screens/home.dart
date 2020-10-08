// Dart
import 'dart:ui';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Internal
import 'package:songtube/ui/internal/lifecycleEvents.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/screens/homeScreen/shimmer/shimmerVideoPage.dart';
import 'package:songtube/screens/homeScreen/videoPage.dart';
import 'package:songtube/screens/moreScreen/settings.dart';
import 'package:songtube/ui/internal/snackbar.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:provider/provider.dart';

// UI
import 'package:songtube/screens/homeScreen/downloadMenu.dart';
import 'package:songtube/screens/homeScreen/IntroSplash.dart';
import 'package:songtube/ui/animations/showUp.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // QuickSearch Controller
  TextEditingController quickSearchController;

  // ClipBoard Data
  bool clipboardHasLink;
  String clipboardLink;

  // IntroSplash Animation
  bool forward;

  @override
  void initState() {
    super.initState();
    quickSearchController = new TextEditingController();
    clipboardHasLink = false;
    clipboardLink = "";
    checkClipboard();
    forward = true;
    WidgetsBinding.instance.addObserver(
      new LifecycleEventHandler(resumeCallBack: () {
        Provider.of<ManagerProvider>(context, listen: false).handleIntent();
        checkClipboard();
        return;
      })
    );
  }

  void checkClipboard() {
    Clipboard.getData('text/plain').then((data) {
      if (data == null && mounted) {
        clipboardLink = "";
        setState(() => clipboardHasLink = false);
        return;
      }
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
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
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
                    ? const ShimmerVideoPage()
                    : Center(
                        child: IntroSplash(
                          forward: forward,
                          controller: quickSearchController,
                          onQuickSearch: (String searchQuery) {
                            quickSearchController.clear();
                            manager.pushYoutubePage(searchQuery);
                          },
                        )
                      )
              ),
            ),
          ],
        ),
        floatingActionButton: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: manager.showEmptyScreenWidget
            ? ShowUpTransition(
                forward: clipboardHasLink ? true : false,
                duration: Duration(milliseconds: 400),
                slideSide: SlideFromSlide.BOTTOM,
                child: FloatingActionButton(
                  elevation: 0,
                  child: Icon(
                    EvaIcons.linkOutline,
                    color: Theme.of(context).accentColor
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    child: manager.streamManifest == null
                      ? CircularProgressIndicator(
                          backgroundColor: Theme.of(context).accentColor,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                          strokeWidth: 4,
                        )
                      : Icon(Icons.file_download),
                    backgroundColor: Theme.of(context).accentColor,
                    foregroundColor: Colors.white,
                    onPressed: () async {
                      if (manager.streamManifest == null) {
                        manager.snackBar.showSnackBar(
                          icon: Icons.warning,
                          title: "Please Wait",
                          message: "Video Streams are beign loaded"
                        );
                      } else {
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
                    }
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
