// Flutter
import 'package:flutter/material.dart';

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
              DownloadInfoSet infoset = manager.downloadInfoSetList[index];
              return Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                child: DownloadTile(
                  dataProgress: infoset.downloader.dataProgress.stream,
                  progressBar: infoset.downloader.progressBar.stream,
                  currentAction: infoset.currentAction.stream,
                  title: infoset.metadata.title,
                  author: infoset.metadata.artist,
                  coverUrl: infoset.metadata.coverurl,
                  onDownloadCancel: infoset.downloader.downloadFinished == false
                  ? () {
                    setState(() => infoset.downloader.downloadFinished = true);
                  } : null,
                ),
              );
            },
          )
        : NoDownloads(),
    );
  }
}