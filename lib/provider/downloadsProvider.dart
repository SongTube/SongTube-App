import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:newpipeextractor_dart/models/streams/audioOnlyStream.dart';
import 'package:newpipeextractor_dart/models/streams/videoOnlyStream.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/download/audioFilters.dart';
import 'package:songtube/internal/download/downloadItem.dart';
import 'package:songtube/internal/download/downloadSet.dart';
import 'package:songtube/internal/download/tags.dart';
import 'package:songtube/internal/randomString.dart';
import 'package:songtube/provider/configurationProvider.dart';

class DownloadsProvider extends ChangeNotifier {

  DownloadsProvider() {
    downloadingList = <DownloadSet>[];
    completedList   = <DownloadSet>[];
    cancelledList   = <DownloadSet>[];
    
  }

  // Downloading List
  List<DownloadSet> downloadingList;

  // Completed List
  List<DownloadSet> completedList;

  // Cancelled List
  List<DownloadSet> cancelledList;

  // Handle Single Video Download
  void handleDownloadItem({
    @required Languages language,
    DownloadItem item
  }) {
    DownloadSet download = new DownloadSet(
      language: language,
      downloadItem: item,
      downloadId: RandomString.getRandomString(6),
      completedCallback: (String downloadId, bool converted) {
        int index = downloadingList.indexWhere((element)
          => element.downloadId == downloadId);
        downloadingList.removeAt(index);
        notifyListeners();
        checkQueue();
      },
      cancelledCallback: (String downloadId) {
        moveToCancelled(downloadId);
        checkQueue();
      },
      saveErrorCallback: (String downloadId) {
        moveToCancelled(downloadId);
        checkQueue();
      }
    );
    downloadingList.add(download);
    checkQueue();
  }

  // Handle Playlist Download
  void handleDownloadItems({
    @required Languages language,
    List<DownloadItem> items
  }) {
    items.forEach((item) {
      DownloadSet download = new DownloadSet(
        language: language,
        downloadItem: item,
        downloadId: RandomString.getRandomString(6),
        completedCallback: (String downloadId, bool converted) {
          int index = downloadingList.indexWhere((element)
            => element.downloadId == downloadId);
          downloadingList.removeAt(index);
          notifyListeners();
          checkQueue();
        },
        cancelledCallback: (String downloadId) {
          moveToCancelled(downloadId);
          checkQueue();
        },
        saveErrorCallback: (String downloadId) {
          moveToCancelled(downloadId);
          checkQueue();
        }
      );
      downloadingList.add(download);
    });
    checkQueue();
  }

  void checkQueue() {
    if (downloadingList.isEmpty) return;
    int maxSimultaneousDownloads = downloadingList.length <= 2
      ? downloadingList.length : 2;
    for (int i = 0; i < maxSimultaneousDownloads; i++) {
      if (downloadingList[i].downloadStatusStream.value == DownloadStatus.Loading)
        downloadingList[i].downloadMedia();
    }
    notifyListeners();
  }

  void moveToCancelled(String id) {
    int index = downloadingList.indexWhere((element)
      => element.downloadId == id);
    cancelledList.add(downloadingList[index]);
    downloadingList.removeAt(index);
    checkQueue();
  }

  void retryDownload(String id) {
    int index = cancelledList.indexWhere((element)
      => element.downloadId == id);
    cancelledList[index].downloadStatusStream
      .add(DownloadStatus.Loading);
    downloadingList.add(cancelledList[index]);
    cancelledList.removeAt(index);
    checkQueue();
  }

  void cancelDownload(String id) async {
    int index = downloadingList.indexWhere((element)
      => element.downloadId == id);
    downloadingList[index].cancelDownload = true;
    await Future.delayed(Duration(seconds: 2));
    cancelledList.add(downloadingList[index]);
    downloadingList.removeAt(index);
    checkQueue();
  }

  
}