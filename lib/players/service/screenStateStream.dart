// Internal
import 'package:songtube/players/service/playerService.dart';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:rxdart/rxdart.dart';

/// Encapsulate all the different data we're interested in into a single
  /// stream so we don't have to nest StreamBuilders.
  Stream<ScreenState> get screenStateStream =>
      Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState, ScreenState>(
          AudioService.queueStream,
          AudioService.currentMediaItemStream,
          AudioService.playbackStateStream,
          (queue, mediaItem, playbackState) =>
              ScreenState(queue, mediaItem, playbackState));