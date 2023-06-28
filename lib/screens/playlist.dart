import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/media_utils.dart';
import 'package:songtube/internal/models/media_set.dart';
import 'package:songtube/internal/music_brainz.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/providers/playlist_provider.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/ui/animations/mini_music_visualizer.dart';
import 'package:songtube/ui/playlist_artwork.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/song_tile.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({
    required this.mediaSet,
    Key? key}) : super(key: key);
  final MediaSet mediaSet;
  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {

  // MediaSet
  late final MediaSet mediaSet = widget.mediaSet;

  // Playlist name editing
  late TextEditingController nameController = TextEditingController(text: mediaSet.name);
  FocusNode focusNode = FocusNode();
  bool editingPlaylistName = false;

  // Save artwork for this playlist
  Future<void> setArtwork() async {
    final artwork = File('${(await getApplicationDocumentsDirectory()).path}/${MediaUtils.getRandomString(10)}');
    final image = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (image != null && image.files.isNotEmpty) {
      final file = File(image.files.first.path!);
      final bytes = await file.readAsBytes();
      await artwork.writeAsBytes(bytes);
      mediaSet.artwork = artwork.path;
      PlaylistProvider playlistProvider = Provider.of(context, listen: false);
      playlistProvider.updateGlobalPlaylist(mediaSet.id!, artworkPath: artwork.path);
      setState(() {});
    }
  }

  @override
  void initState() {
    if (mediaSet.id == 'userFavorites') {
      mediaSet.id = null;
    }
    if (mediaSet.isArtist) {
      MusicBrainzAPI.getArtistImage(mediaSet.name.trim()).then((value) {
        setState(() {
          mediaSet.artwork = value;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of(context);
    PlaylistProvider playlistProvider = Provider.of(context);
    UiProvider uiProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: (16/9),
            child: Stack(
              fit: StackFit.expand,
              children: [
                PlaylistArtwork(artwork: mediaSet.artwork, color: Theme.of(context).cardColor, opacity: 0.7, shadowIntensity: 0.2, shadowSpread: 24, enableHeroAnimation: false),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12, right: 12, top: MediaQuery.of(context).padding.top),
                      height: kToolbarHeight,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Iconsax.arrow_left, color: Theme.of(context).iconTheme.color)
                          ), 
                          const Spacer(),
                          if (mediaSet.id != null)
                          IconButton(
                            onPressed: () {
                              setArtwork();
                            },
                            icon: Icon(Iconsax.image, color: Theme.of(context).iconTheme.color)
                          ), 
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: IntrinsicWidth(
                                  child: editingPlaylistName
                                    ? TextField(
                                        maxLines: 1,
                                        style: bigTextStyle(context),
                                        controller: nameController,
                                        focusNode: focusNode,
                                        decoration: const InputDecoration.collapsed(hintText: ''),
                                        onSubmitted: (text) {
                                          setState(() {
                                            editingPlaylistName = false;
                                          });
                                          if (nameController.text != mediaSet.name) {
                                            // Update Playlist name
                                            playlistProvider.updateGlobalPlaylist(mediaSet.id!, newName: nameController.text);
                                            if (mediaProvider.currentPlaylistName == mediaSet.name) {
                                              mediaProvider.currentPlaylistName = nameController.text;
                                            }
                                            setState(() {
                                              mediaSet.name = nameController.text;
                                            });
                                          }
                                        },
                                      )
                                    : Text(
                                        mediaSet.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: bigTextStyle(context),
                                      )
                                )
                              ),
                              const SizedBox(width: 2),
                              // mediaSet.favorite ?? false
                              //   ? const FadeInTransition(
                              //       duration: Duration(milliseconds: 500),
                              //       child: Icon(Icons.star_rounded, color: Colors.orangeAccent, size: 18))
                              //   : const SizedBox()
                              if (mediaSet.id != null)
                              IconButton(
                                onPressed: () {
                                  if (editingPlaylistName) {
                                    setState(() {
                                      editingPlaylistName = false;
                                    });
                                    if (nameController.text != mediaSet.name) {
                                      // Update Playlist name
                                      playlistProvider.updateGlobalPlaylist(mediaSet.id!, newName: nameController.text);
                                      if (mediaProvider.currentPlaylistName == mediaSet.name) {
                                        mediaProvider.currentPlaylistName = nameController.text;
                                      }
                                      setState(() {
                                        mediaSet.name = nameController.text;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      editingPlaylistName = true;
                                    });
                                    nameController.selection = TextSelection(baseOffset: 0, extentOffset: mediaSet.name.length);
                                    focusNode.requestFocus();
                                  }
                                },
                                icon: Icon(editingPlaylistName ? Icons.check_rounded : Icons.edit_rounded, size: 20)
                              )
                            ],
                          ),
                          Text(mediaSet.songs.isEmpty ? Languages.of(context)!.labelEmpty : '${mediaSet.songs.length} ${Languages.of(context)!.labelSongs}', style: smallTextStyle(context))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ),
          Expanded(
            child: StreamBuilder<MediaItem?>(
              stream: audioHandler.mediaItem,
              builder: (context, snapshot) {
                final playerOpened = snapshot.data != null;
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 12),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final song = mediaSet.songs[index];
                        return SongTile(
                          song: song,
                          onPlay: () async {
                            mediaProvider.currentPlaylistName = mediaSet.name;
                            final queue = List<MediaItem>.generate(mediaSet.songs.length, (index) {
                              return mediaSet.songs[index].mediaItem;
                            });
                            uiProvider.currentPlayer = CurrentPlayer.music;
                            mediaProvider.playSong(queue, index);
                          }
                        );
                      }, childCount: mediaSet.songs.length),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16)
                          .copyWith(bottom: playerOpened
                            ? (kToolbarHeight * 1.6)+(kToolbarHeight)+34
                            : (kToolbarHeight * 1.6)),
                      ),
                    )
                  ],
                );
              }
            ),
          )
        ],
      ),
      floatingActionButton: StreamBuilder<MediaItem?>(
        stream: audioHandler.mediaItem,
        builder: (context, snapshot) {
          final playerOpened = snapshot.data != null;
          return Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(bottom: playerOpened ? (kToolbarHeight * 1.6)+14 : 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // if (mediaSet.id != null)
                // InkWell(
                //   onTap: () {
                //     setState(() {
                //       mediaSet.favorite = !(mediaSet.favorite ?? false);
                //     });
                //     playlistProvider.favoriteGlobalPlaylist(mediaSet.id!);
                //   },
                //   child: Container(
                //     decoration: BoxDecoration( 
                //       color: Theme.of(context).cardColor,
                //       borderRadius: BorderRadius.circular(100),
                //       boxShadow: [
                //         BoxShadow(
                //           blurRadius: 12,
                //           offset: const Offset(0,0),
                //           color: Theme.of(context).shadowColor.withOpacity(0.1)
                //         )
                //       ]
                //     ),
                //     margin: const EdgeInsets.only(right: 12),
                //     padding: const EdgeInsets.all(12),
                //     child: AnimatedSwitcher(
                //       duration: const Duration(milliseconds: 500),
                //       child: Icon(
                //         (mediaSet.favorite ?? false) ? Icons.star_rounded : Icons.star_outline_rounded,
                //         key: ValueKey('${mediaSet.favorite}+${mediaSet.id}'),
                //         color: (mediaSet.favorite ?? false) ? Colors.orangeAccent : Theme.of(context).iconTheme.color)),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    mediaProvider.currentPlaylistName = mediaSet.name;
                    final queue = List<MediaItem>.generate(mediaSet.songs.length, (index) {
                      return mediaSet.songs[index].mediaItem;
                    });
                    queue.shuffle();
                    mediaProvider.playSong(queue, 0);
                  },
                  child: Container(
                    decoration: BoxDecoration( 
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12,
                          offset: const Offset(0,0),
                          color: Theme.of(context).shadowColor.withOpacity(0.1)
                        )
                      ]
                    ),
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(12),
                    child: Icon(Ionicons.shuffle_outline, color: Theme.of(context).iconTheme.color),
                  ),
                ),
                InkWell(
                  onTap: () {
                    mediaProvider.currentPlaylistName = mediaSet.name;
                    final queue = List<MediaItem>.generate(mediaSet.songs.length, (index) {
                      return mediaSet.songs[index].mediaItem;
                    });
                    mediaProvider.playSong(queue, 0);
                  },
                  child: Container(
                    decoration: BoxDecoration( 
                      color: mediaSet.songs.first.palette!.vibrant,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12,
                          offset: const Offset(0,0),
                          color: Theme.of(context).shadowColor.withOpacity(0.1)
                        )
                      ]
                    ),
                    padding: const EdgeInsets.all(12).copyWith(left: 18, right: 24),
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: mediaProvider.currentPlaylistName != mediaSet.name
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Ionicons.play, color: Colors.white),
                                const SizedBox(width: 8),
                                Text(Languages.of(context)!.labelPlayAll, style: textStyle(context).copyWith(color: Colors.white))
                              ],
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                StreamBuilder<PlaybackState>(
                                  stream: audioHandler.playbackState,
                                  builder: (context, state) {
                                    final isPaused = !(state.data?.playing ?? true);
                                    return MiniMusicVisualizer(color: Colors.white, width: 4, height: 12, pause: isPaused);
                                  }
                                ),
                                const SizedBox(width: 8),
                                Text(Languages.of(context)!.labelPlaying, style: textStyle(context).copyWith(color: Colors.white))
                              ],
                            )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}