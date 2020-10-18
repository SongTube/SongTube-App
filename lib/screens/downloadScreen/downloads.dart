// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';

// Internal
import 'package:songtube/internal/models/downloadinfoset.dart';
import 'package:songtube/provider/downloadsProvider.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:songtube/screens/downloadScreen/components/downloadTile.dart';

// UI
import 'package:songtube/screens/downloadScreen/components/downloadsEmpty.dart';

class DownloadingPage extends StatefulWidget {
  @override
  _DownloadingPageState createState() => _DownloadingPageState();
}

class _DownloadingPageState extends State<DownloadingPage> {
  @override
  Widget build(BuildContext context) {
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: downloadsProvider.listDownloads.isNotEmpty 
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: downloadsProvider.listDownloads.length,
            itemBuilder: (context, index) {
              List<DownloadInfoSet> reversedList =
                downloadsProvider.listDownloads.reversed.toList();
              DownloadInfoSet infoset = reversedList[index];
              return Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  child: DownloadTile(
                    dataProgress: infoset.dataProgress.stream,
                    progressBar: infoset.progressBar.stream,
                    currentAction: infoset.currentAction.stream,
                    metadata: infoset.metadata,
                    downloadType: infoset.downloadType,
                    onDownloadCancel: infoset.downloadStatus == DownloadStatus.Completed
                      ? null : infoset.downloadStatus == DownloadStatus.Cancelled
                        ? () {
                            Permission.storage.request().then((value) {
                              if (value == PermissionStatus.granted) {
                                infoset.downloadMedia();
                                setState((){});
                              }
                            });
                          }
                        : () {
                            infoset.downloadStatus = DownloadStatus.Cancelled;
                            setState(() {});
                          },
                    cancelDownloadIcon: infoset.downloadStatus == DownloadStatus.Completed
                    ? Icon(Icons.clear, size: 18, color: Theme.of(context).cardColor)
                    : infoset.downloadStatus == DownloadStatus.Cancelled
                      ? Icon(Icons.refresh, size: 18)
                      : Icon(Icons.clear, size: 18)
                  )
                );
              },
            )
        : const NoDownloads(),
    );
  }
}