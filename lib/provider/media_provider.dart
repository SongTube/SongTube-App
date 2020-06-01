import 'package:flutter/material.dart';
import 'package:songtube/internal/database/infoset_database.dart';
import 'package:songtube/internal/database/models/downloaded_file.dart';
import 'package:songtube/internal/models/downloadinfoset.dart';

class MediaProvider extends ChangeNotifier {

  // Database
  final dbHelper = DatabaseService.instance;

  // Media
  List<DownloadInfoSet> _downloadInfoSetList = [];
  List<DownloadedFile> _downloadedFileList = [];
  int _downloadsTabIndex = 0;

  MediaProvider() {
    getDatabase();
  }

  void getDatabase() async {
    _downloadedFileList = await dbHelper.getDownloadList();
    notifyListeners();
  }

  List<DownloadInfoSet> get downloadInfoSetList => _downloadInfoSetList;
  List<DownloadedFile> get downloadedFileList => _downloadedFileList;
  int get downloadsTabIndex => _downloadsTabIndex;

  set downloadInfoSetList(List<DownloadInfoSet> newList) {
    _downloadInfoSetList = newList;
    notifyListeners();
  }

  set downloadedFileList(List<DownloadedFile> newList) {
    _downloadedFileList = newList;
    notifyListeners();
  }

  set downloadsTabIndex(int value) {
    _downloadsTabIndex = value;
    notifyListeners();
  }

  void addItemToDownloadList(DownloadInfoSet newItem) {
    _downloadInfoSetList.add(newItem);
    notifyListeners();
  }
}