// Dart
import 'dart:async';
import 'dart:io';
import 'dart:math';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:songtube/internal/globals.dart';

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

// NOTE: Your entrypoint MUST be a top-level function.
void songtubePlayer() async {
  AudioServiceBackground.run(() => SongTubePlayerService());
}

class SongTubePlayerService extends BackgroundAudioTask {
  
  List<MediaItem> _queue;
  List<MediaItem> get queue => _queue;
  AudioPlayer _player;
  StreamSubscription<PlaybackEvent> _eventSubscription;
  AudioProcessingState _skipState;
  int timesPositionChanged = 0;
  int _index = 0;
  int lastPlayerPosition = 0;

  // Enable Repeat & Random
  bool enableRepeat = false;
  bool enableRandom = false;

  // Audio Session
  AudioSession session;

  // Audio Effects
  AndroidEqualizer equalizer = AndroidEqualizer();
  AndroidLoudnessEnhancer loudnessEnhancer = AndroidLoudnessEnhancer();


  bool get hasNext => _index + 1 < _queue.length;
  bool get hasPrevious => _index > 0;

  @override
  Future<void> onSkipToPrevious() async {
    if (_player.position < Duration(seconds: 3)) {
      _skip(-1);
    } else {
      _player.seek(Duration(seconds: 0));
    }
  }
  @override
  Future<void> onSkipToNext() async {
    if (enableRandom) {
      _index = Random().nextInt(_queue.length);
      await AudioServiceBackground.setMediaItem(_queue[_index]);
      await _player.setUrl(mediaItem.id);
      onPlay();
      return;
    } 
    _skipState = AudioProcessingState.skippingToNext;
    _skip(1);
  }

  MediaItem get mediaItem => _queue[_index];

  // Initialise your audio task.
  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    _queue = <MediaItem>[];
    session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());
    session.interruptionEventStream.listen((event) {
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
            _player.setVolume(0.4);
            break;
          case AudioInterruptionType.pause:
            onPause();
            break;
          case AudioInterruptionType.unknown:
            onPause();
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            _player.setVolume(1);
            break;
          case AudioInterruptionType.pause:
            // This causes some issues, better not resume music
            // onPlay();
            break;
          case AudioInterruptionType.unknown:
            // The interruption ended but we should not resume.
            break;
        }
      }
    });
    session.becomingNoisyEventStream.listen((_) {
      _player.pause();
    });
    _player = new AudioPlayer(audioPipeline: AudioPipeline(
      androidAudioEffects: [ equalizer, loudnessEnhancer ]));
    _eventSubscription = _player.playbackEventStream.listen((event) {
      _broadcastState(null);
    });
    // Special processing for state transitions.
    _player.processingStateStream.listen((state) {
      switch (state) {
        case ProcessingState.completed:
          _handlePlaybackCompleted();
          break;
        case ProcessingState.ready:
          // If we just came from skipping between tracks, clear the skip
          // state now that we're ready to play.
          _skipState = null;
          break;
        default:
          break;
      }
    });
  }

  @override
  Future<void> onUpdateQueue(List<MediaItem> newqueue) async {
    _queue = newqueue;
    await AudioServiceBackground.setQueue(newqueue);
    super.onUpdateQueue(newqueue);
  }

  @override
  Future<void> onUpdateMediaItem(MediaItem mediaItem) async {
    final index = _queue.indexWhere((element) => element.id == mediaItem.id);
    _queue[index] = mediaItem;
    AudioServiceBackground.queue[index] = mediaItem;
    if (AudioServiceBackground.mediaItem.id == mediaItem.id) {
      await AudioServiceBackground.setMediaItem(_queue[index]);
    }
    return super.onUpdateMediaItem(mediaItem);
  }

  @override
  Future<void> onPlayMediaItem(MediaItem item) async {
    _index = queue.indexOf(item);
    AudioServiceBackground.setMediaItem(queue[_index]);
    await _player.setUrl(queue[_index].id);
    onPlay();
  }

  Future<void> _handlePlaybackCompleted() async {
    if (enableRepeat && _queue.length > 1) {
      await _player.setUrl(mediaItem.id);
      onPlay();
      return;
    }
    if (enableRandom && _queue.length > 1) {
      _index = Random().nextInt(_queue.length);
      await AudioServiceBackground.setMediaItem(_queue[_index]);
      await _player.setUrl(mediaItem.id);
      onPlay();
      return;
    } 
    if (hasNext) {
      onSkipToNext();
    } else {
      await _player.stop();
      _broadcastState(AudioProcessingState.completed);
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
    await AudioServiceBackground.setMediaItem(_queue[_index]);
    _skipState = offset > 0
      ? AudioProcessingState.skippingToNext
      : AudioProcessingState.skippingToPrevious;
    await _player.setUrl(mediaItem.id);
    _skipState = null;
    onPlay();
  }

  // Handle a request to stop audio and finish the task.
  @override
  Future<void> onStop() async {
    await _player.pause();
    await _player.dispose();
    _eventSubscription.cancel();
    // It is important to wait for this state to be broadcast before we shut
    // down the task. If we don't, the background task will be destroyed before
    // the message gets sent to the UI.
    await _broadcastState(null);
    // Shut down this task
    await super.onStop();
  }

  // Handle a request to play audio.
  @override
  Future<void> onPlay() async {
    await session.setActive(true);
    await _player.play();
  }

  @override
  Future<void> onPlayFromMediaId(String index) async {
    int ind = int.parse(index);
    _index = ind;
    await AudioServiceBackground.setMediaItem(_queue[ind]);
    await _player.setUrl(mediaItem.id);
    onPlay();
  }

  // Handle a request to pause audio.
  @override
  Future<void> onPause() async {
    await _player.pause();
  }

  // Handle a request to seek to a position.
  @override
  Future<void> onSeekTo(Duration position) async {
    _player.seek(position);
  }

  @override
  Future<dynamic> onCustomAction(String action, dynamic object) async {
    if (action == "enableRepeat") {
      enableRepeat = !enableRepeat;
      return enableRepeat;
    }
    if (action == "enableRandom") {
      enableRandom = !enableRandom;
      return enableRandom;
    }
    if (action == "retrieveEqualizer") {
      final parameters = await equalizer.parameters;
      final map = {
        'enabled': equalizer.enabled ? 'true' : 'false',
        'bands': List.generate(parameters.bands.length, (index) {
          final band = parameters.bands[index];
          return {
            'centerFrequency': band.centerFrequency,
            'minFreq': parameters.minDecibels,
            'maxFreq': parameters.maxDecibels,
            'gain': band.gain
          };
        })
      };
      return map;
    }
    if (action == "updateEqualizer") {
      final enabled = object['enabled'] == 'true' ? true : false;
      if (enabled) {
        await equalizer.setEnabled(true);
      } else {
        await equalizer.setEnabled(false);
      }
      final bands = List.from(object['bands']);
      final parameters = await equalizer.parameters;
      for (int i = 0; parameters.bands.length > i; i++) {
        final bandMap = Map<String, dynamic>.from(bands[i]);
        parameters.bands[i].setGain(bandMap["gain"]);
      }
    }
    if (action == 'retrieveLoudnessGain') {
      return {
        'enabled': loudnessEnhancer.enabled ? 'true' : 'false',
        'gain': loudnessEnhancer.targetGain
      };
    }
    if (action == 'updateLoudnessGain') {
      final enabled = object['enabled'] == 'true' ? true : false;
      if (enabled) {
        await loudnessEnhancer.setEnabled(true);
      } else {
        await loudnessEnhancer.setEnabled(false);
      }
      final gain = object['gain'] as double;
      loudnessEnhancer.setTargetGain(gain);
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
  Future<void> _broadcastState(AudioProcessingState state) async {
    await AudioServiceBackground.setState(
      controls: getControls(),
      systemActions: [
        MediaAction.seekTo,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      ],
      processingState: state != null ? state : _getProcessingState(),
      playing: _player.playing,
      position: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
    );
  }

  /// Maps just_audio's processing state into into audio_service's playing
  /// state. If we are in the middle of a skip, we use [_skipState] instead.
  AudioProcessingState _getProcessingState() {
    if (_skipState != null) return _skipState;
    switch (_player.processingState) {
      case ProcessingState.idle:
        return AudioProcessingState.stopped;
      case ProcessingState.loading:
        return AudioProcessingState.connecting;
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