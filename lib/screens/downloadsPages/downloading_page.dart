import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/downloadinfoset.dart';
import 'package:songtube/provider/media_provider.dart';
import 'package:songtube/ui/downloads_screen/no_downloads.dart';
import 'package:songtube/ui/reusable/download_tile.dart';

class DownloadingPage extends StatefulWidget {
  @override
  _DownloadingPageState createState() => _DownloadingPageState();
}

class _DownloadingPageState extends State<DownloadingPage> {

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: mediaProvider.downloadInfoSetList.isNotEmpty 
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: mediaProvider.downloadInfoSetList.length,
            itemBuilder: (context, index) {
              DownloadInfoSet infoset = mediaProvider.downloadInfoSetList[index];
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