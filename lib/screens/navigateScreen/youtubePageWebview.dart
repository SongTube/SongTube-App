// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:provider/provider.dart';

class YoutubePageWebview extends StatefulWidget {
  @override
  _YoutubePageWebviewState createState() => _YoutubePageWebviewState();
}

class _YoutubePageWebviewState extends State<YoutubePageWebview> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  GlobalKey<ScaffoldState> scaffoldState;
  WebViewController webController;
  String _currentUrl;

  @override
  void initState() {
    scaffoldState = new GlobalKey<ScaffoldState>();
    _currentUrl = "https://m.youtube.com";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldState,
        body: Column(
          children: <Widget>[
            Expanded(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: _currentUrl,
                onWebViewCreated: (WebViewController controller) {
                  webController = controller;
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
                        String url = await webController.currentUrl();
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
                        Clipboard.setData(new ClipboardData(text: await webController.currentUrl()));
                        manager.snackBar.showSnackBar(
                          icon: Icons.content_copy,
                          title: "Copy",
                          message: "Text copied to Clipboard",
                          duration: Duration(seconds: 1)
                        );
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
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.white,
            onPressed: () async {
              String _url;
              try {
                _url = await webController.currentUrl();
              } catch (_) {
                manager.snackBar.showSnackBar(
                  icon: Icons.error,
                  title: "Error",
                  message: "Page is still loading",
                  duration: Duration(seconds: 2)
                );
                return;
              }
              String _id = youtube.VideoId.parseVideoId(_url);
              if (_id == null) {
                manager.snackBar.showSnackBar(
                  icon: Icons.error,
                  title: "Error",
                  message: "Select a valid Video",
                  duration: Duration(seconds: 2)
                );
                return;
              }
              manager.screenIndex = 0;
              manager.urlController.text = _url;
              manager.getVideoDetails(_url);
            },
          ),
        ),
      ),
    );
  }
}