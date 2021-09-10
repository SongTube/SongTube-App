import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/download/downloadSet.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/screens/downloadScreen/components/downloadTile.dart';
import 'package:songtube/ui/components/emptyIndicator.dart';
import 'package:autolist/autolist.dart';

class DownloadsQueueTab extends StatefulWidget {
  @override
  _DownloadsQueueTabState createState() => _DownloadsQueueTabState();
}

class _DownloadsQueueTabState extends State<DownloadsQueueTab> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: downloadsBody(context)
    );
  }

  Widget downloadsBody(BuildContext context) {
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context);
    if (downloadsProvider.downloadingList.isNotEmpty) {
      return AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        child: downloadsProvider.downloadingList.isNotEmpty ? Align(
          alignment: Alignment.topCenter,
          child: AutoList<DownloadSet>(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            items: downloadsProvider.downloadingList,
            duration: Duration(milliseconds: 400),
            itemBuilder: (context, infoset) {
              return StreamBuilder<Object>(
                stream: infoset.downloadStatusStream.stream,
                builder: (context, snapshot) {
                  return DownloadTile(
                    dataProgress: infoset.dataProgress.stream,
                    progressBar: infoset.progressBar.stream,
                    currentAction: infoset.currentAction.stream,
                    metadata: infoset.downloadItem.tags,
                    downloadType: infoset.downloadItem.downloadType,
                    onDownloadCancel: snapshot.data == DownloadStatus.Downloading
                      ? () {
                        infoset.cancelDownload = true;
                      } : null,
                    cancelDownloadIcon: snapshot.data == DownloadStatus.Downloading
                      ? Icon(Icons.clear, size: 18)
                      : Container()
                  );
                }
              );
            },
          ),
        ) : Container(),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: const EmptyIndicator()
      );
    }
  }
}