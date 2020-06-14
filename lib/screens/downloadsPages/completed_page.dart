import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/database/infoset_database.dart';
import 'package:songtube/internal/database/models/downloaded_file.dart';
import 'package:songtube/internal/native.dart';
import 'package:songtube/provider/downloads_manager.dart';
import 'package:songtube/provider/player_provider.dart';
import 'package:songtube/ui/downloads_screen/no_downloads_completed.dart';
import 'package:songtube/ui/reusable/download_tile.dart';

class CompletedPage extends StatefulWidget {
  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> with TickerProviderStateMixin {

  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    Player audioPlayer = Provider.of<Player>(context);
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
      duration: Duration(milliseconds: 300),
      child: manager.downloadedFileList.isNotEmpty
        ? AnimatedSize(
          vsync: this,
          duration: Duration(milliseconds: 300),
          child: ListView.builder(
            controller: scrollController,
            physics: BouncingScrollPhysics(),
              itemCount: manager.downloadedFileList.length,
              itemBuilder: (context, index) {
                DownloadedFile download = manager.downloadedFileList[index];
                return Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  child: DownloadTileWithoutStream(
                    title: download.title,
                    author: download.author,
                    coverUrl: download.coverUrl,
                    onTilePlay: () {
                      if (download.downloadType == "Audio") {
                        audioPlayer.queue = manager.downloadedFileList;
                        audioPlayer.play(index);
                      }
                      if (download.downloadType == "Video") {
                        NativeMethod.openVideo(download.path);
                      }
                    },
                    onTileRemove: () {
                      final dbHelper = DatabaseService.instance;
                      dbHelper.deleteDownload(int.parse(download.id));
                      setState(() {
                        manager.getDatabase();
                      });
                    },
                  ),
                );
              },
            ),
        )
        : NoDownloadsCompleted()
    );
  }
}