// Dart
import 'dart:async';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/app_provider.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  WebViewController _webViewController;
  bool _showLoading;
  String _currentUrl;
  bool loop = true;

  @override
  void initState() {
    scaffoldState = new GlobalKey<ScaffoldState>();
    _currentUrl = "https://youtube.com";
    super.initState();
  }

  void initCheckLoop() async {
    while (loop == true) {      
      await Future.delayed(Duration(milliseconds: 500), () async {
        String testUrl = await _webViewController.currentUrl();
        if (testUrl != _currentUrl) {
          setState(() => _currentUrl = testUrl);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppDataProvider appData = Provider.of<AppDataProvider>(context);
    return Scaffold(
      key: scaffoldState,
      body: Column(
        children: <Widget>[
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width,
            child: _showLoading == true ? Expanded(
              child: LinearProgressIndicator(
                backgroundColor: Theme.of(context).canvasColor,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            ) : Container(),
          ),
          Expanded(
            child: WebView(
              initialUrl: "https://youtube.com",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController ctrl) {
                _controller.complete(ctrl);
                _webViewController = ctrl;
                initCheckLoop();
              },
              onPageStarted: (url) {
                setState(() => _currentUrl = url);
                setState(() {
                  _showLoading = true;
                });
              },
              onPageFinished: (url) {
                setState(() => _currentUrl = url);
                setState(() {
                  _showLoading = false;
                });
              },
            ),
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
                    bool result = await _webViewController.canGoBack();
                    if (result == true) {
                      _webViewController.goBack();
                      setState(() async => _currentUrl = await _webViewController.currentUrl());
                    }
                  }
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () async {
                    bool result = await _webViewController.canGoForward();
                    if (result == true) {
                      _webViewController.goForward();
                      setState(() async => _currentUrl = await _webViewController.currentUrl());
                    }
                  }
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () async {
                    await _webViewController.reload();
                  }
                ),
                Expanded(
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(new ClipboardData(text: _currentUrl));
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
              _url = await _webViewController.currentUrl();
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
            videoUrl.add(_url);
          },
        ),
      ),
    );
  }
}