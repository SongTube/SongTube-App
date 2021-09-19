// Flutter
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/screens/musicScreen/components/downloadsEmpty.dart';
import 'package:songtube/screens/musicScreen/components/loadingListWidget.dart';
import 'package:songtube/screens/musicScreen/components/noPermissionWidget.dart';
import 'package:songtube/screens/musicScreen/components/playlistEmpty.dart';

enum MediaListBaseType { Downloads, Any }

class MediaListBase extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool isEmpty;
  final MediaListBaseType listType;
  MediaListBase({
    @required this.child,
    @required this.isLoading,
    @required this.isEmpty,
    @required this.listType,
  });
  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: animatedSwitcherChild(mediaProvider),
    );
  }

  Widget animatedSwitcherChild(mediaProvider) {
    if (!mediaProvider.storagePermission) {
      return NoPermissionWidget(
        onPermissionRequest: () {
          Permission.storage.request().then((value) {
            if (value == PermissionStatus.granted) {
              mediaProvider.storagePermission = true;
              mediaProvider.loadSongList();
            }
          });
        }
      );
    } else if (!isEmpty) {
      return child;
    } else if (isLoading) {  
      return MediaLoadingWidget();
    } else {
      if (listType == MediaListBaseType.Downloads) {
        return MediaDownloadsEmpty();
      } else {
        return PlaylistEmptyWidget();
      }
    }
  }

}