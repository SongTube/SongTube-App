import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newpipeextractor_dart/extractors/playlist.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:songtube/downloadMenu/downloadMenu.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/components/addToPlaylist.dart';
import 'package:songtube/ui/dialogs/loadingDialog.dart';
import 'package:songtube/ui/internal/popupMenu.dart';
import 'package:songtube/ui/internal/snackbar.dart';

class StreamsPopupMenu extends StatelessWidget {
  final dynamic infoItem;
  final Function(dynamic) onDelete;
  final scaffoldKey;
  StreamsPopupMenu({
    @required this.infoItem,
    this.onDelete,
    this.scaffoldKey,
  });
  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return FlexiblePopupMenu(
      items: [
        FlexiblePopupItem(
          title: Languages.of(context).labelShare,
          value: "Share"
        ),
        FlexiblePopupItem(
          title: Languages.of(context).labelCopyLink,
          value: "CopyLink"
        ),
        if (infoItem is StreamInfoItem)
        FlexiblePopupItem(
          title: Languages.of(context).labelDownload,
          value: "Download"
        ),
        if (onDelete != null)
        FlexiblePopupItem(
          title: Languages.of(context).labelRemove,
          value: "Remove"
        ),
        FlexiblePopupItem(
          title: Languages.of(context).labelAddToPlaylist,
          value: "AddPlaylist"
        ),
      ],
      onItemTap: (String value) async {
        switch(value) {
          case "Share":
            Share.share(
              infoItem.url
            );
            break;
          case "CopyLink":
            Clipboard.setData(ClipboardData(
              text: infoItem.url
            ));
            AppSnack.showSnackBar(
              icon: Icons.copy,
              title: "Link copied to Clipboard",
              duration: Duration(seconds: 2),
              context: context,
              scaffoldKey: scaffoldKey
            );
            break;
          case "Download":
            showModalBottomSheet<dynamic>(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                ),
              ),
              clipBehavior: Clip.antiAlias,
              context: context,
              builder: (context) {
                String url = infoItem.url;
                return Wrap(
                  children: [
                    Consumer<ManagerProvider>(
                      builder: (context, provider, _) {
                        return DownloadMenu(
                          videoUrl: url,
                          scaffoldState: provider
                            .internalScaffoldKey.currentState,
                        );
                      }
                    ),
                  ],
                );
              }
            );
            break;
          case "Remove":
            onDelete(infoItem);
            break;
          case "AddPlaylist":
            if (infoItem is StreamInfoItem) {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)
                  )
                ),
                builder: (context) {
                  return AddStreamToPlaylistSheet(stream: infoItem);
                }
              );
            } else {
              PlaylistInfoItem playlist = infoItem as PlaylistInfoItem;
              if (prefs.streamPlaylists.indexWhere((element) => element.name == playlist.name) != -1) {
                AppSnack.showSnackBar(
                  icon: Icons.warning_rounded,
                  title: Languages.of(context).labelCancelled,
                  message: "Playlist already exists!",
                  context: context,
                );
                return;
              }
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return LoadingDialog();
                }
              );
              prefs.streamPlaylistCreate(
                playlist.name,
                playlist.uploaderName,
                await PlaylistExtractor.getPlaylistStreams(playlist.url)
              );
              Navigator.pop(context);
              AppSnack.showSnackBar(
                icon: Icons.playlist_add_check_rounded,
                title: Languages.of(context).labelCompleted,
                message: "Playlist saved successfully!",
                context: context,
              );
            }
            break;
          }
      },
      borderRadius: 10,
      child: Container(
        padding: EdgeInsets.all(4),
        color: Colors.transparent,
        child: Icon(Icons.more_vert_rounded,
          size: 16),
      ),
    );
  }
}