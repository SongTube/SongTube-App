// Dart
import 'dart:async';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:songtube/provider/downloads_manager.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// UI
import 'package:songtube/ui/snackbar.dart';
import 'package:songtube/screens/home.dart';

class YoutubeWebview extends StatefulWidget {
  @override
  _YoutubeWebviewState createState() => _YoutubeWebviewState();
}

class _YoutubeWebviewState extends State<YoutubeWebview> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  GlobalKey<ScaffoldState> scaffoldState;
  InAppWebViewController webController;
  bool _showLoading;
  String _currentUrl;
  double progress = 0;

  @override
  void initState() {
    scaffoldState = new GlobalKey<ScaffoldState>();
    _currentUrl = "https://m.youtube.com";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldState,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 2,
              width: MediaQuery.of(context).size.width,
              child:LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              )
            ),
            Expanded(
              child: InAppWebView(
                initialUrl: _currentUrl,
                onWebViewCreated: (InAppWebViewController controller) {
                  webController = controller;
                },
                onProgressChanged: (InAppWebViewController controller, int value) {
                  setState(() {
                    progress = value / 100;
                  });
                },
              )
            ),
            Container(
              height: kToolbarHeight,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () async {
                      bool result = await webController.canGoBack();
                      if (result == true) {
                        webController.goBack();
                      }
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () async {
                      bool result = await webController.canGoForward();
                      if (result == true) {
                        webController.goForward();
                        String url = await webController.getUrl();
                        setState(() => _currentUrl = url);
                      }
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () async {
                      await webController.reload();
                    }
                  ),
                  Expanded(
                    child: GestureDetector(
                      onLongPress: () async {
                        Clipboard.setData(new ClipboardData(text: await webController.getUrl()));
                        final snackBar = AppSnack.withEverything(
                          context,
                          Icons.content_copy,
                          "Copy",
                          "Text copied to Clipboard",
                          Duration(seconds: 1)
                        );
                        scaffoldState.currentState.showSnackBar(snackBar);
                      },
                      child: Container(
                        height: kToolbarHeight*0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).cardColor
                        ),
                        child: Row(
                          children: <Widget> [
                            SizedBox(width: 12),
                            Icon(Icons.https),
                            SizedBox(width: 8),
                            Expanded(child: Text(_currentUrl, overflow: TextOverflow.clip, softWrap: true, maxLines: 1))
                          ]
                        ),
                      ),
                    )
                  )
                ]
              ),
            )
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: kToolbarHeight),
          child: FloatingActionButton(
            child: Icon(Icons.file_download),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            onPressed: () async {
              String _url;
              try {
                _url = await webController.getUrl();
              } catch (_) {
                scaffoldState.currentState.showSnackBar(
                  AppSnack.withEverything(
                    context,
                    Icons.error,
                    "Error",
                    "Page still loading...",
                    Duration(seconds: 2)
                  )
                );
                return;
              }
              String _id = youtube.YoutubeExplode.parseVideoId(_url);
              if (_id == null) {
                scaffoldState.currentState.showSnackBar(
                  AppSnack.withEverything(
                    context,
                    Icons.error,
                    "Error",
                    "Select a valid video",
                    Duration(seconds: 2)
                  )
                );
                return;
              }
              appData.screenIndex = 0;
              manager.urlController.text = _url;
              manager.getMediaStreamInfo(_id);
            },
          ),
        ),
      ),
    );
  }
}