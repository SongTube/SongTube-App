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
    queueList       = <DownloadSet>[];
    downloadingList = <DownloadSet>[];
    convertingList  = <DownloadSet>[];
    completedList   = <DownloadSet>[];
    cancelledList   = <DownloadSet>[];
    
  }

  // Queue List
  List<DownloadSet> queueList;

  // Downloading List
  List<DownloadSet> downloadingList;

  // Converting List
  List<DownloadSet> convertingList;

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
      convertingCallback: (String downloadId) {
        moveToConverting(downloadId);
      },
      completedCallback: (String downloadId, bool converted) {
        moveToCompleted(downloadId, converted);
        checkQueue();
      },
      cancelledCallback: (String downloadId) {
        moveToCancelled(downloadId);
      },
      saveErrorCallback: (String downloadId) {
        moveToCancelled(downloadId);
      }
    );
    queueList.add(download);
    checkQueue();
  }

  void checkQueue() {
    if (queueList.isNotEmpty && downloadingList.length < 2) {
      DownloadSet download = queueList[0];
      downloadingList.add(download);
      int index = downloadingList.indexWhere((element)
        => element.downloadId == download.downloadId);
      downloadingList[index].downloadMedia();
      queueList.remove(queueList[0]);
      checkQueue();
    }
    notifyListeners();
  }

  void moveToConverting(String id) {
    int index = downloadingList.indexWhere((element)
      => element.downloadId == id);
    convertingList.add(downloadingList[index]);
    downloadingList.removeAt(index);
    checkQueue();
  }

  void moveToCompleted(String id, bool converted) {
    if (converted) {
      int index = convertingList.indexWhere((element)
        => element.downloadId == id);
      completedList.add(convertingList[index]);
      convertingList.removeAt(index);
    } else {
      int index = downloadingList.indexWhere((element)
        => element.downloadId == id);
      completedList.add(downloadingList[index]);
      downloadingList.removeAt(index);
    }
    checkQueue();
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
    queueList.add(cancelledList[index]);
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