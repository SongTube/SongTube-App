import 'dart:io';
import 'package:flutter/material.dart';
import 'tabs/downloadtab.dart';
import 'tabs/hometab.dart';
import 'tabs/settingstab.dart';
import 'internal/songtube_classes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'internal/native.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {

  @override
  void initState() {
    checkPermissions();
    appdata = AppStreams();
    downloader = Downloader();
    method = NativeMethod();
    super.initState();
  }

  Future<void> showAlertDialog(BuildContext context, bool permanent) async {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("SongTube"),
      content: permanent == false
          ? Text(
              "This application needs external storage permission to convert or download from YouTube or other sites")
          : Text(
              "External storage permission is permanently denied, please go to settings and enable it manually for this app to work..."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  checkPermissions() async {
    final status = await Permission.storage.status;
    if (status.isUndetermined) {
      await showAlertDialog(context, false);
      final response = await Permission.storage.request();
      if (response.isDenied) exit(0);
      if (response.isPermanentlyDenied) exit(0);
    } else if (status.isGranted) {
      return;
    } else if (status.isDenied) {
      await showAlertDialog(context, false);
      final response = await Permission.storage.request();
      if (response.isDenied) exit(0);
      if (response.isPermanentlyDenied) exit(0);
    } else if (status.isPermanentlyDenied) {
      await showAlertDialog(context, true);
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: AppBar(
          title: Text(
            "SongTube",
            style: TextStyle(color: Theme.of(context).textTheme.body1.color),
          ),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), key: PageStorageKey("hometab")),
              Tab(icon: Icon(Icons.cloud_download)),
              Tab(icon: Icon(Icons.settings)),
            ],
            unselectedLabelColor: Theme.of(context).iconTheme.color,
            labelColor: Colors.redAccent,
            indicatorColor: Colors.redAccent,
          ),
          elevation: 1,
        ),
        body: TabBarView(children: [
          HomeTab(),
          DownloadTab(),
          SettingsTab(),
        ]),
        floatingActionButton: StreamBuilder<Object>(
            stream: appdata.linkReady.stream,
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 8),
                  child: FloatingActionButton(
                    onPressed: () async {
                      await downloader.download();
                    },
                    child: Icon(
                      Icons.file_download,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}
