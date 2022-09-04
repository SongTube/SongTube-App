import 'dart:io';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/videoFile.dart';
import 'package:songtube/internal/systemUi.dart';
import 'package:songtube/players/service/playerService.dart';
import 'package:songtube/players/videoPlayer.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/internal/popupMenu.dart';
import 'package:songtube/pages/tagsEditor.dart';
import 'package:songtube/ui/internal/snackbar.dart';
import 'package:songtube/ui/sheets/localPlaylistSheet.dart';
import 'package:transparent_image/transparent_image.dart';

class SongsListView extends StatelessWidget {
  final List<MediaItem> songs;
  final bool hasDownloadType;
  final String searchQuery;
  final bool shrinkWrap;
  final bool tintNowPlaying;
  final bool addBottomPadding;
  final ScrollController scrollController;
  SongsListView({
    @required this.songs,
    this.hasDownloadType = false,
    this.searchQuery = "",
    this.shrinkWrap = false,
    this.tintNowPlaying = true,
    this.addBottomPadding = true,
    this.scrollController,
    Key key
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    return ListView.builder(
      key: key,
      controller: scrollController,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
      itemCount: songs.length,
      padding: addBottomPadding ? EdgeInsets.only(bottom: kToolbarHeight*2) : null,
      itemBuilder: (context, index) {
        MediaItem song = songs[index];
        bool selected = AudioService.currentMediaItem == song;
        if (searchQuery == "" || getSearchQueryMatch(song)) {
          return ListTile(
            tileColor: selected && tintNowPlaying
              ? Theme.of(context).accentColor.withOpacity(0.08) : null,
            title: Text(
              song.title,
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontWeight: FontWeight.w600,
                fontFamily: 'Product Sans',
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              song.artist,
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6)
              ),
            ),
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (hasDownloadType)
                Container(
                  height: 30,
                  width: 30,
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black12.withOpacity(0.04),
                  ),
                  child: Icon(
                    song.extras["downloadType"] == "Audio"
                      ? EvaIcons.musicOutline
                      : EvaIcons.videoOutline,
                    color: Theme.of(context).iconTheme.color,
                    size: 20,
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      fadeInDuration: Duration(milliseconds: 200),
                      placeholder: MemoryImage(kTransparentImage),
                      image: FileImage(File(song.extras["artwork"])),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ],
            ),
            trailing: FlexiblePopupMenu(
              borderRadius: 10,
              items: [
                FlexiblePopupItem(
                  title: Languages.of(context).labelShare,
                  value: "Share"
                ),
                FlexiblePopupItem(
                  title: Languages.of(context).labelAddToPlaylist,
                  value: "Add Playlist"
                ),
                FlexiblePopupItem(
                  title: Languages.of(context).labelEditTags,
                  value: "Edit Tags"
                ),
                FlexiblePopupItem(
                  title: Languages.of(context).labelDeleteSong,
                  value: "Delete"
                )
              ],
              onItemTap: (String value) async {
                if (value == "Delete") {
                  if (AudioService.running && AudioService.playbackState.playing) {
                    if (AudioService.currentMediaItem.id == song.id) {
                      AudioService.stop();
                    }
                  }
                }
                switch (value) {
                  case "Share":
                    FlutterShare.shareFile(
                      title: song.title,
                      text: '${song.title} - ${song.artist}\n\n'
                            'Shared from SongTube\nsongtube.github.io',
                      fileType: 'audio/*',
                      filePath: song.id
                    );
                    break;
                  case "Add Playlist":
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)
                        )
                      ),
                      builder: (context) {
                        return LocalPlaylistSheet(song: song);
                      }
                    );
                    break;
                  case "Delete":
                    mediaProvider.deleteSong(song);
                    break;
                  case "Edit Tags":
                    FFmpegConverter().getMediaFormat(song.id).then((format) async {
                      if (format == "m4a") {
                        await Navigator.of(context).push(
                          BlurPageRoute(
                            builder: (_) {
                              return TagsEditorPage(
                                song: song,
                              );
                            },
                            blurStrength: Provider.of<PreferencesProvider>
                              (context, listen: false).enableBlurUI ? 20 : 0,
                          )
                        );
                        Future.delayed(Duration(milliseconds: 400), () {
                          setSystemUiColor(context);
                        });
                      } else {
                        AppSnack.showSnackBar(
                          icon: EvaIcons.alertCircleOutline,
                          title: "Cannot Edit Tags",
                          message: "Audio format not supported ($format)",
                          context: context,
                        );
                      }
                    });
                    break;
                  case "Apply Filters":
                    // TODO: Allow Audio Filters application
                    break;
                }
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(8).copyWith(top: 16, bottom: 16),
                child: Icon(Icons.more_vert, size: 18),
              )
            ),
            onTap: () async {
              if (hasDownloadType == false || song.extras["downloadType"] == "Audio") {
                if (!AudioService.running) {
                  await AudioService.start(
                    backgroundTaskEntrypoint: songtubePlayer,
                    androidNotificationChannelName: 'SongTube',
                    // Enable this if you want the Android service to exit the foreground state on pause.
                    //androidStopForegroundOnPause: true,
                    androidNotificationColor: 0xFF2196f3,
                    androidNotificationIcon: 'drawable/ic_stat_music_note',
                    androidEnableQueue: true,
                  );
                }
                if (listEquals(songs, AudioService.queue) == false) {
                  await AudioService.updateQueue(songs);
                }
                await AudioService.playMediaItem(songs[index]);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => 
                    AppVideoPlayer(VideoFile(
                      name: song.title,
                      path: song.id,
                    )))
                );
              }
            }
          );
        } else {
          return Container();
        }
      },
    );
  }

  bool getSearchQueryMatch(MediaItem song) {
    if (searchQuery != "") {
      if (song.title.toLowerCase().contains(searchQuery.toLowerCase())) {
        return true;
      } else if (song.artist.toLowerCase().contains(searchQuery.toLowerCase())) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

}