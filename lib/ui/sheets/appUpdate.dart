import 'dart:io';
import 'package:apk_installer/apk_installer.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/utils/httpClient.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/updateDetails.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AppUpdateSheet extends StatelessWidget {
  final UpdateDetails details;
  AppUpdateSheet(this.details);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.7,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 90,
                width: 90,
                child: AvatarGlow(
                  repeat: true,
                  endRadius: 45,
                  showTwoGlows: false,
                  glowColor: Theme.of(context).accentColor,
                  repeatPauseDuration: Duration(milliseconds: 50),
                  child: Image.asset(
                    'assets/images/ic_launcher.png',
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Text(
                "SongTube",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 24
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                "New version available",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color
                    .withOpacity(0.8),
                  fontSize: 18,
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w600
                ),
              ),
              Spacer(),
              Text(
                "${details.version}",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 18,
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w600
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "What's new:",
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 18,
                fontFamily: 'Product Sans',
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          SizedBox(height: 16),
          Divider(
            height: 1,
            thickness: 1,
            color: Theme.of(context).accentColor.withOpacity(0.1),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16
                ),
                child: MarkdownBody(
                  data: details.updateDetails),
              )
            )
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Theme.of(context).accentColor.withOpacity(0.1),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Later",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color
                      .withOpacity(0.8),
                    fontFamily: 'Product Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                )
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    isDismissible: false,
                    enableDrag: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                      )
                    ),
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          AppUpdateDownloadSheet(
                            newVersion: details.version,
                            downloadUrl: details.downloadUrl
                          ),
                        ],
                      );
                    }
                  );
                },
                child: Ink(
                  height: 50,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Theme.of(context).accentColor),
                  ),
                  child: Center(
                    child: FutureBuilder(
                      future: ExtractorHttpClient.getContentLength(details.downloadUrl),
                      builder: (context, AsyncSnapshot<int> data) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Languages.of(context).labelDownload,
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontFamily: 'Product Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            data.hasData
                              ? Text(
                                  " (${((data.data/1024)/1024).toStringAsFixed(0)} MB)",
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontFamily: 'Product Sans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                  ),
                                )
                              : Container(
                                  height: 20,
                                  width: 20,
                                  margin: const EdgeInsets.only(left: 12, right: 4),
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
                                    strokeWidth: 2,
                                  ),
                                )
                          ],
                        );
                      }
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class AppUpdateDownloadSheet extends StatefulWidget {
  final String newVersion;
  final String downloadUrl;
  AppUpdateDownloadSheet({
    @required this.newVersion,
    @required this.downloadUrl
  });
  @override
  _AppUpdateDownloadSheetState createState() => _AppUpdateDownloadSheetState();
}

class _AppUpdateDownloadSheetState extends State<AppUpdateDownloadSheet> {

  // Parameters
  double progress = 0;
  CancelToken cancelToken = CancelToken();

  // Download Path
  File downloadFile;

  @override
  void initState() {
    super.initState();
    initDownload();
  }

  Future<void> initDownload() async {
    var permissionStatus = await Permission.storage.request();
    if (permissionStatus == PermissionStatus.granted) {
      Dio dio = Dio();
      downloadFile = File((await ExtStorage
        .getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS))
        + "/update.apk");
      dio.download(
        widget.downloadUrl, downloadFile.path,
        onReceiveProgress: (recieved, total) {
          setState(() {
            progress = recieved/total;
          });
        },
        deleteOnError: true,
        cancelToken: cancelToken,
        options: Options()
      ).then((_) {
        if (!mounted || cancelToken.isCancelled) { dio.close(); return; }
        // Begin installation
        ApkInstaller.installApk(downloadFile.path).then((value) {
          Navigator.pop(context);
        });
        dio.close();
      }).catchError((_) {
        dio.close();
        return;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        cancelToken.cancel("Update windows closed");
        return Future.value(true);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15)
        ),
        child: Container(
          color: Theme.of(context).cardColor,
          child: Column(
            children: [
              AppBar(
                centerTitle: false,
                backgroundColor: Theme.of(context).cardColor,
                elevation: 0,
                automaticallyImplyLeading: false,
                title: Text(Languages.of(context).labelDownloading, style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Product Sans'
                )),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: Theme.of(context).accentColor.withOpacity(0.1),
              ),
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.all(4),
                    child: AvatarGlow(
                      repeat: true,
                      endRadius: 45,
                      showTwoGlows: false,
                      glowColor: Theme.of(context).accentColor,
                      repeatPauseDuration: Duration(milliseconds: 50),
                      child: Image.asset(
                        'assets/images/ic_launcher.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.newVersion.split("+").first}",
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 18,
                              fontFamily: 'Product Sans',
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: LinearProgressIndicator(
                              value: progress == 0 ? null : progress,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}