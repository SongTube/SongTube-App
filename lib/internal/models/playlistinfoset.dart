import 'package:flutter/material.dart';
import 'package:songtube/internal/models/downloadinfoset.dart';

class PlaylistInfoSet {

  // Class Variables
  List<DownloadInfoSet> listDownloads;
  int maxSimultaneousDownloads;

  int _queueIndex;

  PlaylistInfoSet({
    @required this.listDownloads,
    this.maxSimultaneousDownloads = 2
  }) {
    _queueIndex = 0;
    listDownloads.forEach((element) {
      if (!element.currentAction.isClosed) {
        element.currentAction.stream.listen((event) {
          if (event == "Converting") {
            if (_queueIndex+1 > listDownloads.length) return;
            listDownloads[_queueIndex].downloadMedia();
            _queueIndex++;
          }
        });
      }
    });
  }

  void initializeDownloads() {
    for (int i = 1; i <= maxSimultaneousDownloads; i++) {
      listDownloads[i].downloadMedia();
    }
    _queueIndex = 3;
  }

}


