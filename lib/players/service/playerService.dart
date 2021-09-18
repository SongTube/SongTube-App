// Dart
import 'dart:async';
import 'dart:math';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

MediaControl playControl = MediaControl(
  androidIcon: 'drawable/ic_play_arrow',
  label: 'Play',
  action: MediaAction.play,
);
MediaControl pauseControl = MediaControl(
  androidIcon: 'drawable/ic_pause',
  label: 'Pause',
  action: MediaAction.pause,
);
MediaControl skipToNextControl = MediaControl(
  androidIcon: 'drawable/ic_navigate_next',
  label: 'Next',
  action: MediaAction.skipToNext,
);
MediaControl skipToPreviousControl = MediaControl(
  androidIcon: 'drawable/ic_navigate_before',
  label: 'Previous',
  action: MediaAction.skipToPrevious,
);
MediaControl stopControl = MediaControl(
  androidIcon: 'drawable/ic_clear',
  label: 'Stop',
  action: MediaAction.stop,
);

class SongTubePlayerHandler extends BaseAudioHandler {
  
  SongTubePlayerHandler() {
    _player = AudioPlayer();
    _setState();
    playbackState.listen((value) {
      if (value.processingState == AudioProcessingState.completed) {
        _handlePlaybackCompleted();
      }
    });
  }

  List<MediaItem> _queue;
  AudioPlayer _player;
  int _index = 0;

  // Enable Repeat & Random
  bool enableRepeat = false;
  bool enableRandom = false;

  bool get hasNext => _index + 1 < _queue.length;
  bool get hasPrevious => _index > 0;

  @override
  Future<void> skipToPrevious() async {
    if (_player.position < Duration(seconds: 3)) {
      _skip(-1);
    } else {
      _player.seek(Duration(seconds: 0));
    }
  }

  @override
  Future<void> skipToNext() async {
    if (enableRandom) {
      _index = Random().nextInt(queue.value.length);
      await _player.setUrl(queue.value[_index].id);
      play();
      return;
    } 
    _skip(1);
  }

  @override
  Future<void> playMediaItem(MediaItem item) async {
    _index = queue.value.indexOf(item);
    mediaItem.add(item);
    await _player.setUrl(queue.value[_index].id);
    play();
  }

  Future<void> _handlePlaybackCompleted() async {
    if (enableRepeat) {
      await _player.setUrl(mediaItem.value.id);
      play();
      return;
    }
    if (enableRandom) {
      _index = Random().nextInt(queue.value.length);
      mediaItem.add(queue.value[_index]);
      await _player.setUrl(mediaItem.value.id);
      play();
      return;
    } 
    if (hasNext) {
      skipToNext();
    } else {
      _player.stop();
    }
  }

  Future<void> _skip(int offset) async {
    final newPos = _index + offset;
    if (!(newPos >= 0 && newPos < _queue.length)) return;
    if (_player.playing) {
      // Stop current item
      await _player.stop();
    }
    // Load next item
    _index = newPos;
    mediaItem.add(queue.value[_index]);
    _player.setUrl(mediaItem.value.id);
    play();
  }

  // Handle a request to stop audio and finish the task.
  @override
  Future<void> stop() async {
    await _player.pause();
    await _player.dispose();
    // Shut down this task
    await super.stop();
  }

  // Handle a request to play audio.
  @override
  Future<void> play() async {
    await _player.play();
  }

  @override
  Future<void> playFromMediaId(String index, [Map<String, dynamic> map]) async {
    int ind = int.parse(index);
    _index = ind;
    mediaItem.add(queue.value[ind]);
    await _player.setUrl(mediaItem.value.id);
    play();
  }

  // Handle a request to pause audio.
  @override
  Future<void> pause() async {
    await _player.pause();
  }

  @override
  Future<dynamic> customAction(String action, [Map<String, dynamic> object]) async {
    if (action == "enableRepeat") {
      enableRepeat = !enableRepeat;
      return enableRepeat;
    }
    if (action == "enableRandom") {
      enableRandom = !enableRandom;
      return enableRandom;
    }
    return null;
  }

  /// Get MediaPlayer Controls
  List<MediaControl> getControls() {
    if (_player.playing) {
      return [
        skipToPreviousControl,
        pauseControl,
        skipToNextControl,
        stopControl
      ];
    } else {
      return [
        skipToPreviousControl,
        playControl,
        skipToNextControl,
        stopControl,
      ];
    }
  }

  /// Broadcasts the current state to all clients.
  Future<void> _setState() async {
    playbackState.add(PlaybackState(
      // Which buttons should appear in the notification now
      controls: [
        MediaControl.skipToPrevious,
        MediaControl.pause,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      // Which other actions should be enabled in the notification
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      // Which controls to show in Android's compact view.
      androidCompactActionIndices: const [0, 1, 3],
      // Whether audio is ready, buffering, ...
      processingState: _getProcessingState(),
      // Whether audio is playing
      playing: _player.playing,
      // The current position as of this update. You should not broadcast
      // position changes continuously because listeners will be able to
      // project the current position after any elapsed time based on the
      // current speed and whether audio is playing and ready. Instead, only
      // broadcast position updates when they are different from expected (e.g.
      // buffering, or seeking).
      updatePosition: _player.position,
      // The current buffered position as of this update
      bufferedPosition: _player.bufferedPosition,
      // The current speed
      speed: 1.0,
      // The current queue position
      queueIndex: _player.currentIndex,
    ));
  }

  /// Maps just_audio's processing state into into audio_service's playing
  /// state. If we are in the middle of a skip, we use [_skipState] instead.
  AudioProcessingState _getProcessingState() {
    switch (_player.processingState) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        throw Exception("Invalid state: ${_player.processingState}");
    }
  }

}

class ScreenState {
  final List<MediaItem> queue;
  final MediaItem mediaItem;
  final PlaybackState playbackState;

  ScreenState(this.queue, this.mediaItem, this.playbackState);
}