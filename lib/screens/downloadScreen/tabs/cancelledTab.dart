import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:autolist/autolist.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/downloadinfoset.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/screens/downloadScreen/components/downloadTile.dart';
import 'package:songtube/screens/downloadScreen/components/downloadsEmpty.dart';

class DownloadsCancelledTab extends StatefulWidget {
  @override
  _DownloadsCancelledTabState createState() => _DownloadsCancelledTabState();
}

class _DownloadsCancelledTabState extends State<DownloadsCancelledTab> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: downloadsBody(context)
    );
  }

  Widget downloadsBody(BuildContext context) {
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context);
    if (downloadsProvider.cancelledList.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 8),
        child: AutoList<DownloadInfoSet>(
          physics: BouncingScrollPhysics(),
          items: downloadsProvider.cancelledList,
          duration: Duration(milliseconds: 400),
          itemBuilder: (context, infoset) {
            return Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: DownloadTile(
                dataProgress: infoset.dataProgress.stream,
                progressBar: infoset.progressBar.stream,
                currentAction: infoset.currentAction.stream,
                metadata: infoset.metadata,
                downloadType: infoset.downloadType,
                onDownloadCancel: () {
                  Permission.storage.request().then((value) {
                    if (value == PermissionStatus.granted) {
                      downloadsProvider.retryDownload(infoset.downloadId);
                      setState(() {});
                    }
                  });
                },
                cancelDownloadIcon: Icon(Icons.refresh, size: 18)
              )
            );
          },
        ),
      );
    } else {
      return Align(
        alignment: Alignment.bottomCenter,
        child: const NoDownloads()
      );
    }
  }
}