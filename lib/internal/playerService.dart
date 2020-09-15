// Dart
import 'dart:async';

// Packages
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
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

// NOTE: Your entrypoint MUST be a top-level function.
void audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {

  List<MediaItem> _queue;
  List<MediaItem> get queue => _queue;
  AudioPlayer _player;
  StreamSubscription<Duration> _eventSubscription;
  StreamSubscription<AudioPlayerState> _playerStateSubscription;
  int timesPositionChanged = 0;
  int _index = 0;

  // Audio Session
  AudioSession session;

  bool get hasNext => _index + 1 < _queue.length;
  bool get hasPrevious => _index > 0;

  @override
  Future<void> onSkipToPrevious() async {
    if (await _player.getCurrentPosition() < 3000) {
      _skip(-1);
    } else {
      _player.seek(Duration(seconds: 0));
      _setState();
    }
  }
  @override
  Future<void> onSkipToNext() => _skip(1);

  MediaItem get mediaItem => _queue[_index];

  // Initialise your audio task.
  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    _queue = new List<MediaItem>();
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
            onPlay();
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
    _player = new AudioPlayer();
    _eventSubscription = _player.onAudioPositionChanged.listen((event) async {
      if (timesPositionChanged < 5) {
        timesPositionChanged += 1;
      } else {
        PlaybackState(
          processingState: AudioServiceBackground.state.processingState,
          playing: _player.state == AudioPlayerState.PLAYING ? true : false,
          position: Duration(milliseconds: await _player.getCurrentPosition()),
          actions: Set()
        );
        timesPositionChanged = 0;
      }
    });
    _playerStateSubscription = _player.onPlayerStateChanged.listen((state) {
      switch (state) {
        case AudioPlayerState.COMPLETED:
          _handlePlaybackCompleted();
          break;
        default:
          break;
      }
    });
    _setState();
  }

  Future<void> _handlePlaybackCompleted() async {
    if (hasNext) {
      onSkipToNext();
    } else {
      _setState(processingState: AudioProcessingState.completed);
      _player.stop();
    }
  }

  Future<void> _skip(int offset) async {
    final newPos = _index + offset;
    if (!(newPos >= 0 && newPos < _queue.length)) return;
    if (_player.state == AudioPlayerState.PLAYING) {
      // Stop current item
      await _player.stop();
    }
    // Load next item
    _index = newPos;
    await AudioServiceBackground.setMediaItem(_queue[_index]);
    onPlay();
  }

  // Handle a request to stop audio and finish the task.
  @override
  Future<void> onStop() async {
    _setState(processingState: AudioProcessingState.stopped);
    _player.stop();
    _eventSubscription.cancel();
    _playerStateSubscription.cancel();
    super.onStop();
  }

  // Handle a request to play audio.
  @override
  Future<void> onPlay() async {
    await session.setActive(true);
    int result = await _player.play(
      AudioServiceBackground.queue[_index].id,
      isLocal: true,
    );
    if (result == 1) {
      _setState(processingState: AudioProcessingState.ready);
    }
  }

  @override
  Future<void> onPlayFromMediaId(String index) async {
    int ind = int.parse(index);
    _index = ind;
    await AudioServiceBackground.setMediaItem(_queue[ind]);
    onPlay();
  }

  // Handle a request to pause audio.
  @override
  Future<void> onPause() async {
    int result = await _player.pause();
    if (result == 1) {
      _setState(processingState: AudioProcessingState.buffering);
    }
  }

  // Handle a headset button click (play/pause, skip next/prev).
  @override
  Future<void> onUpdateQueue(List<MediaItem> queue) async {
    await AudioServiceBackground.setQueue(queue);
    _queue = queue;
    return;
  }

  // Handle a request to seek to a position.
  @override
  Future<void> onSeekTo(Duration position) async {
    _player.seek(position);
    _setState();
  }

  /// Get MediaPlayer Controls
  List<MediaControl> getControls() {
      if (_player.state == AudioPlayerState.PLAYING) {
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

  Future<void> _setState({
    AudioProcessingState processingState,
    Duration bufferedPosition,
    int position
  }) async {
    await AudioServiceBackground.setState(
      controls: getControls(),
      systemActions: [MediaAction.seekTo],
      processingState:
          processingState ?? AudioServiceBackground.state.processingState,
      playing: _player.state == AudioPlayerState.PLAYING ? true : false,
      position: Duration(milliseconds: _player.state == AudioPlayerState.PLAYING
        ? await _player.getCurrentPosition() : 0)
    );
  }
}

class ScreenState {
  final List<MediaItem> queue;
  final MediaItem mediaItem;
  final PlaybackState playbackState;

  ScreenState(this.queue, this.mediaItem, this.playbackState);
}