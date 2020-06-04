import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/database/infoset_database.dart';
import 'package:songtube/internal/database/models/downloaded_file.dart';
import 'package:songtube/internal/native.dart';
import 'package:songtube/provider/media_provider.dart';
import 'package:songtube/provider/player_provider.dart';
import 'package:songtube/ui/no_downloads_completed.dart';
import 'package:songtube/ui/reusable/download_tile.dart';

class CompletedPage extends StatefulWidget {
  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    Player audioPlayer = Provider.of<Player>(context);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: mediaProvider.downloadedFileList.isNotEmpty
        ? AnimatedSize(
          vsync: this,
          duration: Duration(milliseconds: 300),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
              itemCount: mediaProvider.downloadedFileList.length,
              itemBuilder: (context, index) {
                DownloadedFile download = mediaProvider.downloadedFileList[index];
                return Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: DownloadTileWithoutStream(
                    title: download.title,
                    author: download.author,
                    coverUrl: download.coverUrl,
                    onTilePlay: () {
                      if (download.downloadType == "Audio") {
                        audioPlayer.queue = mediaProvider.downloadedFileList;
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
                        mediaProvider.getDatabase();
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