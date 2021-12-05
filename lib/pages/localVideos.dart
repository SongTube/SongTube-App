import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/models/folder.dart';
import 'package:songtube/internal/models/videoFile.dart';
import 'package:songtube/pages/components/localVideos/folderGridView.dart';
import 'package:songtube/pages/components/localVideos/videosOnFolderListView.dart';
import 'package:songtube/players/videoPlayer.dart';
import 'package:songtube/provider/mediaProvider.dart';

class LocalVideosPage extends StatefulWidget {
  @override
  _LocalVideosPageState createState() => _LocalVideosPageState();
}

class _LocalVideosPageState extends State<LocalVideosPage> {
  
  // Current Viewing Folder
  FolderItem folderOnView;

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          "Local Videos",
          style: TextStyle(
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Theme.of(context).textTheme.bodyText1.color
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).iconTheme.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[600].withOpacity(0.1),
            indent: 12,
            endIndent: 12
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: folderOnView == null
                ? FolderGridView(
                    list: mediaProvider.listFolders,
                    onFolderTap: (FolderItem selectedFolder) {
                      setState(() => folderOnView = selectedFolder);
                    }
                  )
                : WillPopScope(
                    onWillPop: () {
                      setState(() => folderOnView = null);
                      return Future.value(false);
                    },
                    child: VideosOnFolderListView(
                      list: folderOnView.videos,
                      onVideoTap: (VideoFile video) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => 
                            AppVideoPlayer(video))
                        );
                      }
                    ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}