import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/folder.dart';
import 'package:songtube/internal/models/videoFile.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/screens/media/ui/folderGridView.dart';
import 'package:songtube/screens/media/ui/videosOnFolderListView.dart';

class MediaVideoList extends StatefulWidget {
  @override
  _MediaVideoListState createState() => _MediaVideoListState();
}

class _MediaVideoListState extends State<MediaVideoList> {

  // Current Viewing Folder
  FolderItem folderOnView;

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      child: mediaProvider.storagePermission
        ? mediaProvider.listFolders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text(
                      "Getting your Videos...",
                      style: TextStyle(
                        fontFamily: 'YTSans',
                        fontSize: 20
                      ),
                    ),
                  )
                ],
              ),
            )
          : AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              child: folderOnView == null
                ? FolderGridView(
                    list: mediaProvider.listFolders,
                    onFolderTap: (FolderItem selectedFolder) {
                      setState(() => folderOnView = selectedFolder);
                    }
                  )
                : VideosOnFolderListView(
                  list: folderOnView.videos,
                  onBackPressed: () => setState(() => folderOnView = null),
                  onVideoTap: (VideoFile video) {
                    // TODO: Play video
                  }
                )
            )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(EvaIcons.saveOutline, size: 80),
                Container(
                  margin: EdgeInsets.only(top: 16, bottom: 16),
                  child: Text(
                    "View your Videos by\nGranting Storage Permission",
                    style: TextStyle(
                      fontFamily: 'YTSans',
                      fontSize: 20
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Permission.storage.request().then((value) {
                      if (value == PermissionStatus.granted) {
                        mediaProvider.storagePermission = true;
                        mediaProvider.loadVideoList();
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 32),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).accentColor
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 8),
                          child: Text(
                            "Allow Access",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                            )
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          child: Icon(
                            EvaIcons.radioButtonOnOutline,
                            color: Colors.white,
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
    );
  }
}