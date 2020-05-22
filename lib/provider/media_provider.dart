import 'package:flutter/material.dart';
import 'package:songtube/internal/models/downloadinfoset.dart';

class MediaProvider extends ChangeNotifier {

  // Media
  List<DownloadInfoSet> _downloadInfoSetList = [];
  
  List<DownloadInfoSet> get downloadInfoSetList => _downloadInfoSetList;

  set downloadInfoSetList(List<DownloadInfoSet> newList) {
    _downloadInfoSetList = newList;
    notifyListeners();
  }

  void addItemToDownloadList(DownloadInfoSet newItem) {
    _downloadInfoSetList.add(newItem);
    notifyListeners();
  }

  void removeItemFromDownloadList(int index) {
    _downloadInfoSetList.removeAt(index);
    downloadInfoSetList = _downloadInfoSetList;
  }

}