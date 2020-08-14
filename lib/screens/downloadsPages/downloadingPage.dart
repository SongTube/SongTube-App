// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.forward
        && manager.showDownloadTabsStatus == true) {
          manager.showDownloadsTabs.add(false);
          manager.showDownloadTabsStatus = false;
      }
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse
        && manager.showDownloadTabsStatus == false) {
        manager.showDownloadsTabs.add(true);
        manager.showDownloadTabsStatus = true;
      }
    });
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: manager.downloadInfoSetList.isNotEmpty 
        ? ListView.builder(
            controller: scrollController,
            physics: BouncingScrollPhysics(),
            itemCount: manager.downloadInfoSetList.length,
            itemBuilder: (context, index) {
              List<DownloadInfoSet> reversedList = manager.downloadInfoSetList.reversed.toList();
              DownloadInfoSet infoset = reversedList[index];
              return Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
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
                              infoset.downloadMedia();
                              setState((){});
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