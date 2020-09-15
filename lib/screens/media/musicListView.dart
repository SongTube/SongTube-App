// Dart
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/internal/models/songFile.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/internal/playerService.dart';
import 'package:songtube/provider/mediaProvider.dart';

// Packages
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:audio_service/audio_service.dart';
import 'package:provider/provider.dart';

// UI
import 'package:songtube/screens/media/ui/dialogs/confirmDialog.dart';

class MediaMusicList extends StatefulWidget {
  @override
  _MediaMusicListState createState() => _MediaMusicListState();
}

class _MediaMusicListState extends State<MediaMusicList> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      child: mediaProvider.storagePermission
        ? mediaProvider.listSongs.isEmpty
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
                      "Getting your Songs...",
                      style: TextStyle(
                        fontFamily: 'YTSans',
                        fontSize: 20
                      ),
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: mediaProvider.listSongs.length,
              itemBuilder: (context, index) { 
                SongFile song = mediaProvider.listSongs[index];
                return ListTile(
                  title: Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                  ),
                  subtitle: Text(
                    song.author,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6)
                    ),
                  ),
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        fadeInDuration: Duration(milliseconds: 200),
                        placeholder: MemoryImage(kTransparentImage),
                        image: FileImage(File(song.coverPath)),
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                  trailing: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    icon: Icon(MdiIcons.dotsVertical, size: 18),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: "Delete",
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1.color
                            ),
                          ),
                        )
                      ];
                    },
                    onSelected: (String value) {
                      switch (value) {
                        case "Delete":
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ConfirmDialog(
                                onConfirm: () async {
                                  Navigator.pop(context);
                                  if (AudioService.playbackState.playing) {
                                    if (AudioService.currentMediaItem.id == song.path) {
                                      AudioService.stop();
                                    }
                                  }
                                  mediaProvider.listSongs.removeAt(index);
                                  mediaProvider.listMediaItems.removeAt(index);
                                  await File(song.path).delete();
                                  NativeMethod.registerFile(song.path);
                                },
                                onCancel: () {
                                  Navigator.pop(context);
                                  return null;
                                },
                              );
                            }
                          );
                          break;
                        default:
                          break;
                      }
                    },
                  ),
                  onTap: () async {
                    if (!AudioService.running) {
                      await AudioService.start(
                        backgroundTaskEntrypoint: audioPlayerTaskEntrypoint,
                        androidNotificationChannelName: 'SongTube',
                        // Enable this if you want the Android service to exit the foreground state on pause.
                        //androidStopForegroundOnPause: true,
                        androidNotificationColor: 0xFF2196f3,
                        androidNotificationIcon: 'drawable/ic_stat_music_note',
                        androidEnableQueue: true,
                      );
                    }
                    await AudioService.updateQueue(mediaProvider.listMediaItems);
                    await AudioService.playFromMediaId(index.toString());
                  },
                );
              },
            )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(EvaIcons.saveOutline, size: 80),
                Container(
                  margin: EdgeInsets.only(top: 16, bottom: 16),
                  child: Text(
                    "Listen to your Music by\nGranting Storage Permission",
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
                        mediaProvider.loadSongList();
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