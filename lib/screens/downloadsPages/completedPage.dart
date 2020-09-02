// Dart
import 'package:rxdart/rxdart.dart';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Internal
import 'package:songtube/internal/database/infoset_database.dart';
import 'package:songtube/internal/models/songFile.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/internal/playerService.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:provider/provider.dart';

// UI
import 'package:songtube/ui/reusable/downloadTile.dart';
import 'package:songtube/screens/downloadsPages/downloadLibraryEmpty.dart';

class CompletedPage extends StatefulWidget {
  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {

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
      duration: Duration(milliseconds: 300),
      child: manager.songFileList.isNotEmpty
        ? StreamBuilder<ScreenState>(
          stream: _screenStateStream,
          builder: (context, snapshot) {
            final screenState = snapshot.data;
            final state = screenState?.playbackState;
            final processingState =
                state?.processingState ?? AudioProcessingState.none;
            return ListView.builder(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
                itemCount: manager.songFileList.length,
                itemBuilder: (context, index) {
                  SongFile download = manager.songFileList[index];
                  return Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: DownloadTileWithoutStream(
                      title: download.title,
                      author: download.author,
                      coverPath: download.coverPath,
                      onTilePlay: () async {
                        if (download.downloadType == "Audio") {
                          if (processingState == AudioProcessingState.none) {
                            await AudioService.start(
                              backgroundTaskEntrypoint: audioPlayerTaskEntrypoint,
                              androidNotificationChannelName: 'SongTube',
                              // Enable this if you want the Android service to exit the foreground state on pause.
                              //androidStopForegroundOnPause: true,
                              androidNotificationColor: 0xFF2196f3,
                              androidNotificationIcon: 'drawable/ic_stat_music_note',
                              androidEnableQueue: true,
                            );
                          }
                          await AudioService.updateQueue(manager.getCurrentMediaItemList());
                          MediaItem item = AudioService.queue[index];
                          await AudioService.playMediaItem(item);
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
              );
          }
        )
        : NoDownloadsCompleted()
    );
  }
  /// Encapsulate all the different data we're interested in into a single
  /// stream so we don't have to nest StreamBuilders.
  Stream<ScreenState> get _screenStateStream =>
      Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState, ScreenState>(
          AudioService.queueStream,
          AudioService.currentMediaItemStream,
          AudioService.playbackStateStream,
          (queue, mediaItem, playbackState) =>
              ScreenState(queue, mediaItem, playbackState));
}