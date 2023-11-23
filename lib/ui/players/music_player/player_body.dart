import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/models/song_item.dart';
import 'package:songtube/providers/download_provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/providers/playlist_provider.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/players/music_player/artwork_carousel.dart';
import 'package:songtube/ui/players/music_player/marquee_widget.dart';
import 'package:songtube/ui/text_styles.dart';

class ExpandedPlayerBody extends StatefulWidget {
  const ExpandedPlayerBody({
    Key? key }) : super(key: key);

  @override
  State<ExpandedPlayerBody> createState() => _ExpandedPlayerBodyState();
}

class _ExpandedPlayerBodyState extends State<ExpandedPlayerBody> {
  final BehaviorSubject<double> _dragPositionSubject =
    BehaviorSubject.seeded(0);

  // MediaProvider
  MediaProvider get mediaProvider => Provider.of<MediaProvider>(context, listen: false);
  // DownloadProvider
  DownloadProvider get downloadProvider => Provider.of<DownloadProvider>(context, listen: false);

  // UiProvider
  UiProvider get uiProvider => Provider.of(context, listen: false);

  // Current Song
  SongItem get song => SongItem.fromMediaItem(audioHandler.mediaItem.value!);

  // Player Colors
  Color textColor(MediaProvider provider) {
    final palette = provider.currentColors;
    final defaultColor = Theme.of(context).textTheme.bodyText1!.color!;
    if (AppSettings().enableMusicPlayerBlur) {
      if ((palette.dominant ?? Colors.black).computeLuminance() < 0.2) {
        return palette.text;
      } else {
        return palette.text;
      }
    } else {
      return defaultColor;
    }
  }
  
  Color dominantColor(MediaProvider provider) {
    final palette = provider.currentColors;
    final defaultColor = Theme.of(context).textTheme.bodyText1!.color!;
    if (AppSettings().enableMusicPlayerBlur) {
      if ((palette.dominant ?? Colors.black).computeLuminance() < 0.2) {
        return palette.text;
      } else {
        return palette.text;
      }
    } else {
      return palette.vibrant ?? palette.dominant ?? defaultColor;
    }
  }

  // Drag Value for song Seek
  double? dragValue;
  bool dragging = false;

  // Repeat & Shuffle status
  bool onRepeat = false;
  bool onShuffle = false;

  @override
  void initState() {
    audioHandler.mediaItem.listen((event) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: uiProvider.fwController.animationController,
      builder: (context, child) {
        return SizedBox(
          height: Tween<double>(begin: kToolbarHeight * 1.6, end: MediaQuery.of(context).size.height-38-kToolbarHeight-(kToolbarHeight*0.7)).animate(uiProvider.fwController.animationController).value,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: () {
          if (uiProvider.fwController.animationController.value == 0) {
            uiProvider.fwController.animationController
              .animateTo(1, curve: Curves.fastLinearToSlowEaseIn, duration: const Duration(seconds: 1));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    // Artwork Carousel
                    AnimatedBuilder( 
                      animation: uiProvider.fwController.animationController,
                      builder: (context, child) {
                        return Container(
                          constraints: BoxConstraintsTween(
                            begin: const BoxConstraints.tightFor(width: (kToolbarHeight * 1.6), height: (kToolbarHeight * 1.6)),
                            end: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.width))
                              .evaluate(uiProvider.fwController.animationController),
                          child: child
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ArtworkCarousel(
                          song: song,
                          animationController: uiProvider.fwController.animationController,
                          onSwitchSong: (index) async {
                            if (uiProvider.fwController.isPanelClosed) {
                              return;
                            }
                            if (audioHandler.mediaItem.value!.id != audioHandler.queue.value[index].id) {
                              mediaProvider.playSong(audioHandler.queue.value, index);
                            }
                          }
                        ),
                      ),
                    ),
                    // Song Title and Artist
                    Expanded(
                      child: AnimatedBuilder(
                        animation: uiProvider.fwController.animationController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: (1 - (2 * uiProvider.fwController.animationController.value)) > 0
                              ? (1 - (2 * uiProvider.fwController.animationController.value)) : 0,
                            child: child
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: StreamBuilder<MediaItem?>(
                                stream: audioHandler.mediaItem,
                                builder: (context, snapshot) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        snapshot.data?.title ?? '',
                                        style: smallTextStyle(context).copyWith(fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        snapshot.data?.artist ?? '',
                                        style: tinyTextStyle(context, opacity: 0.6),
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        maxLines: 1,
                                      ),
                                    ],
                                  );
                                }
                              ),
                            ),
                            const SizedBox(width: 16),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                StreamBuilder(
                                  stream: Rx.combineLatest2<double, double, double>(
                                    _dragPositionSubject.stream,
                                    Stream.periodic(const Duration(milliseconds: 1000), (_) => 0),
                                    (dragPosition, _) => dragPosition),
                                  builder: (context, snapshot) {
                                    Duration position = audioHandler.playbackState.value.position;
                                    Duration duration = audioHandler.mediaItem.value?.duration ?? Duration.zero;
                                    return SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Consumer<MediaProvider>(
                                        builder: (context, mediaProvider, _) {
                                          return CircularProgressIndicator(
                                            strokeWidth: 3,
                                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                            valueColor: AlwaysStoppedAnimation(mediaProvider.currentColors.vibrant),
                                            value: duration == Duration.zero ? 0 : (position.inMilliseconds/duration.inMilliseconds),
                                          );
                                        }
                                      ),
                                    );
                                  }
                                ),
                                StreamBuilder<PlaybackState>(
                                  stream: audioHandler.playbackState,
                                  builder: (context, snapshot) {
                                    return AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 400),
                                      child: IconButton(
                                        icon: snapshot.data?.playing ?? false
                                          ? const AppAnimatedIcon(Icons.pause_rounded, size: 20, key: Key('pause'))
                                          : const AppAnimatedIcon(Icons.play_arrow_rounded, size: 20, key: Key('play')),
                                        onPressed: snapshot.data?.playing ?? false
                                          ? () => audioHandler.pause()
                                          : () => audioHandler.play()
                                      ),
                                    );
                                  }
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                audioHandler.skipToNext();
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 8, right: 12, left: 8),
                                child: AppAnimatedIcon(EvaIcons.chevronRight),
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Flexible(
              child: AnimatedBuilder(
                animation: uiProvider.fwController.animationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: (uiProvider.fwController.animationController.value - (1 - uiProvider.fwController.animationController.value)) > 0
                      ? (uiProvider.fwController.animationController.value - (1 - uiProvider.fwController.animationController.value)) : 0,
                    child: Transform.translate(
                      offset: Offset(0, Tween<double>(begin: 180, end: 0).animate(uiProvider.fwController.animationController).value),
                      child: child)
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Song Data
                      _songTitle(),
                      const SizedBox(height: 20),
                      // Playback Controls
                      _playbackControls(),
                      const SizedBox(height: 20),
                      // Progress Bar
                      _progressIndicator(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _playbackControls() {
    MediaProvider provider = Provider.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Repeat Button
        const SizedBox(width: 16),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          decoration: BoxDecoration(
            color: onRepeat ? dominantColor(provider).withOpacity(0.2) : null,
            borderRadius: BorderRadius.circular(100)
          ),
          child: IconButton(
            icon: Icon(
              EvaIcons.repeatOutline,
              size: 16,
              color: textColor(provider).withOpacity(0.6)
            ),
            onPressed: () {
              setState(() {
                onRepeat = !onRepeat;
              });
              audioHandler.setRepeatMode(onRepeat ? AudioServiceRepeatMode.one : AudioServiceRepeatMode.none);
            }
          ),
        ),
        const Spacer(),
        // Previous button
        IconButton(
          icon: Icon(
            EvaIcons.arrowIosBackOutline,
            size: 20,
            color: textColor(provider).withOpacity(0.6)
          ),
          onPressed: () => audioHandler.skipToPrevious()
        ),
        // Padding
        const SizedBox(width: 16),
        // Play/Pause button
        StreamBuilder<PlaybackState>(
          stream: audioHandler.playbackState,
          builder: (context, snapshot) {
            final bool playing = snapshot.data?.playing ?? false;
            return GestureDetector(
              onTap: playing
                ? () => audioHandler.pause()
                : () => audioHandler.play(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: 60,
                width: 60,
                child: playing
                  ? Icon(Icons.pause_rounded, size: 42, 
                      color: dominantColor(provider)
                    )
                  : Icon(Icons.play_arrow_rounded, size: 42,
                      color: dominantColor(provider)
                    )
              ),
            );
          }
        ),
        // Padding
        const SizedBox(width: 16),
        // Next button
        IconButton(
          icon: Icon(
            EvaIcons.arrowIosForwardOutline,
            size: 20,
            color: textColor(provider).withOpacity(0.6)
          ),
          onPressed: () => audioHandler.skipToNext()
        ),
        // Shuffle Button
        const Spacer(),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          decoration: BoxDecoration(
            color: onShuffle ? dominantColor(provider).withOpacity(0.2) : null,
            borderRadius: BorderRadius.circular(100)
          ),
          child: IconButton(
            icon: Icon(
              EvaIcons.shuffle2Outline,
              size: 16,
              color: textColor(provider).withOpacity(0.6)
            ),
            onPressed: () {
              setState(() {
                onShuffle = !onShuffle;
              });
              audioHandler.setShuffleMode(onShuffle ? AudioServiceShuffleMode.all : AudioServiceShuffleMode.none);
            }
          ),
        ),
        const SizedBox(width: 16)
      ],
    );
  }

  Widget _songTitle() {
    MediaProvider provider = Provider.of(context);
    PlaylistProvider playlistProvider = Provider.of(context);
    bool isFavorite = playlistProvider.favorites.songs.any((element) => element.id == song.id);
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Song Details
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 16),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: StreamBuilder<MediaItem?>(
                      stream: audioHandler.mediaItem,
                      builder: (context, snapshot) {
                        return MarqueeWidget(
                          textColor: textColor(provider),
                          currentSong: snapshot.data,
                          animationDuration: const Duration(seconds: 10),
                          backDuration: const Duration(seconds: 5),
                          pauseDuration: const Duration(seconds: 2),
                          direction: Axis.horizontal,
                          child: Text(
                            '${snapshot.data?.title ?? ''}    ',
                            key: ValueKey(snapshot.data?.title),
                            style: bigTextStyle(context).copyWith(fontWeight: FontWeight.w900).copyWith(color: textColor(provider)),
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        );
                      }
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: StreamBuilder<MediaItem?>(
                      stream: audioHandler.mediaItem,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data?.artist ?? '',
                          key: ValueKey(snapshot.data?.artist),
                          style: subtitleTextStyle(context, opacity: 0.7).copyWith(color: textColor(provider).withOpacity(0.7)),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        );
                      }
                    ),
                  ),
                ),
              ],
            ),
          ),
          Bounce(
            duration: const Duration(milliseconds: 150),
            onPressed: () {
              playlistProvider.addToFavorites(song);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: AppAnimatedIcon(
                  isFavorite ? Ionicons.heart : Ionicons.heart_outline,
                  key: ValueKey(song.id+isFavorite.toString()),
                  color: isFavorite ? null : textColor(provider).withOpacity(0.6),
                ),
              ),
            )
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _progressIndicator() {
    MediaProvider provider = Provider.of(context);
    return StreamBuilder(
      stream: Rx.combineLatest2<double, double, double>(
        _dragPositionSubject.stream,
        Stream.periodic(const Duration(milliseconds: 1000), (_) => 0),
        (dragPosition, _) => dragPosition),
      builder: (context, snapshot) {
        Duration position = audioHandler.playbackState.value.position;
        Duration duration = audioHandler.mediaItem.value?.duration ?? Duration.zero;
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
                  valueIndicatorTextStyle: TextStyle(
                    color: accentColor,
                  ),
                  trackHeight: 2,
                ),
                child: Slider(
                  activeColor: dominantColor(provider),
                  inactiveColor: textColor(provider).withOpacity(0.06),
                  min: 0.0,
                  max: duration.inMilliseconds.toDouble(),
                  value: duration == Duration.zero ? 0 : max(0.0, min(
                    dragValue ?? position.inMilliseconds.toDouble(),
                    duration.inMilliseconds.toDouble()
                  )),
                  onChanged: (value) {
                    if (!dragging) {
                      dragging = true;
                    }
                    setState(() {
                      dragValue = value;
                    });
                  },
                  onChangeEnd: (value) {
                    audioHandler.seek(Duration(milliseconds: value.toInt()));
                    setState(() {
                      dragValue = null;
                      dragging = false;
                    });
                  },
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Row(
                children: <Widget>[
                  Text(
                    "${position.inMinutes}:${(position.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                    style: tinyTextStyle(context, opacity: 0.6).copyWith(color: textColor(provider)),
                  ),
                  const Spacer(),
                  Text(
                    "${duration.inMinutes}:${(duration.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                    style: tinyTextStyle(context, opacity: 0.6).copyWith(color: textColor(provider)),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}