// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';

// Internal
import 'package:songtube/internal/models/downloadinfoset.dart';
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:provider/provider.dart';

// UI
import 'package:songtube/screens/downloadsPages/downloadsEmpty.dart';
import 'package:songtube/ui/reusable/downloadTile.dart';

class DownloadingPage extends StatefulWidget {
  @override
  _DownloadingPageState createState() => _DownloadingPageState();
}

class _DownloadingPageState extends State<DownloadingPage> {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: manager.downloadInfoSetList.isNotEmpty 
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: manager.downloadInfoSetList.length,
            itemBuilder: (context, index) {
              List<DownloadInfoSet> reversedList = manager.downloadInfoSetList.reversed.toList();
              DownloadInfoSet infoset = reversedList[index];
              return Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  child: DownloadTile(
                    dataProgress: infoset.dataProgress.stream,
                    progressBar: infoset.progressBar.stream,
                    currentAction: infoset.currentAction.stream,
                    title: infoset.metadata.title,
                    author: infoset.metadata.artist,
                    coverUrl: infoset.metadata.coverurl,
                    onDownloadCancel: infoset.downloaderClosed != true
                      ? infoset.cancelDownload == false
                          ? () {
                              infoset.cancelDownload = true;
                              setState(() {});
                            }
                          : () {
                              Permission.storage.request().then((value) {
                                if (value == PermissionStatus.granted) {
                                  infoset.downloadMedia();
                                  setState((){});
                                }
                              });
                            }
                      : null,
                    cancelDownloadIcon: infoset.downloaderClosed != true
                    ? infoset.cancelDownload == false
                        ? Icon(Icons.clear, size: 18)
                        : Icon(Icons.refresh, size: 18)
                    : Icon(Icons.clear, size: 18, color: Theme.of(context).cardColor)
                  )
                );
              },
            )
        : NoDownloads(),
    );
  }
}