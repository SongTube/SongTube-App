import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/models/videoInfo.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';

MediaControl playControl = const MediaControl(
  androidIcon: 'drawable/ic_play_arrow',
  label: 'Play',
  action: MediaAction.play,
);
MediaControl pauseControl = const MediaControl(
  androidIcon: 'drawable/ic_pause',
  label: 'Pause',
  action: MediaAction.pause,
);
MediaControl skipToNextControl = const MediaControl(
  androidIcon: 'drawable/ic_navigate_next',
  label: 'Next',
  action: MediaAction.skipToNext,
);
MediaControl skipToPreviousControl = const MediaControl(
  androidIcon: 'drawable/ic_navigate_before',
  label: 'Previous',
  action: MediaAction.skipToPrevious,
);
MediaControl stopControl = const MediaControl(
  androidIcon: 'drawable/ic_clear',
  label: 'Stop',
  action: MediaAction.stop,
);

class StAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {

  StAudioHandler() {
    _loadEmptyPlaylist();
    _notifyAudioHandlerAboutPlaybackEvents();
    _listenForDurationChanges();
    _listenForCurrentSongIndexChanges();
  }

  // Video Player Background Playback stuff
  bool backgroundPlaybackEnabled = false;

  late final _player = AudioPlayer(audioPipeline: AudioPipeline(
    androidAudioEffects: [ equalizer, loudnessEnhancer ]));
  final _playlist = ConcatenatingAudioSource(children: []);
  final VideoExtractor extractor = VideoExtractor();

  // Equalizer
  AndroidEqualizer equalizer = AndroidEqualizer();
  AndroidLoudnessEnhancer loudnessEnhancer = AndroidLoudnessEnhancer();

  Future<void> _loadEmptyPlaylist() async {
    try {
      await _player.setAudioSource(_playlist);
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    _player.playbackEventStream.listen((PlaybackEvent event) {
      final playing = _player.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: getControls(),
        systemActions: const {
          MediaAction.seek,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        repeatMode: const {
          LoopMode.off: AudioServiceRepeatMode.none,
          LoopMode.one: AudioServiceRepeatMode.one,
          LoopMode.all: AudioServiceRepeatMode.all,
        }[_player.loopMode]!,
        shuffleMode: (_player.shuffleModeEnabled)
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: event.currentIndex,
      ));
    });
  }

  UriAudioSource _createAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(
      !backgroundPlaybackEnabled
        ? Uri(path: mediaItem.id)
        : Uri.parse(mediaItem.id),
      tag: MediaItem(
        id: mediaItem.id,
        title: mediaItem.title,
        artist: mediaItem.artist,
        album: mediaItem.album,
        genre: mediaItem.genre,
        duration: mediaItem.duration,
        artUri: !backgroundPlaybackEnabled
          ? Uri.parse('file://${mediaItem.artUri.toString()}')
          : mediaItem.artUri,
        extras: mediaItem.extras,
      )
    );
  }

  void _listenForDurationChanges() {
    _player.durationStream.listen((duration) {
      var index = _player.currentIndex;
      if (index != null && _player.audioSource!.sequence.isNotEmpty) {
        final oldMediaItem = queue.value[index];
        final newMediaItem = oldMediaItem.copyWith(duration: duration);
        mediaItem.add(newMediaItem);
      }
    });
  }

  void _listenForCurrentSongIndexChanges() {
    _player.currentIndexStream.listen((index) {
      if (index == null || queue.value.isEmpty) {
        return;
      }
      mediaItem.add(queue.value[index]);
    });
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    mediaItem.add(null);
    return super.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() async {
    _player.seekToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    _player.seekToPrevious();
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= queue.value.length) return;
    _player.seek(Duration.zero, index: index);
    play();
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    if (shuffleMode == AudioServiceShuffleMode.none) {
      _player.setShuffleModeEnabled(false);
    } else {
      _player.setShuffleModeEnabled(true);
    }
  }

  @override
  Future<void> updateQueue(List<MediaItem> newQueue) async {
    queue.add(newQueue);
    final audioSource = newQueue.map(_createAudioSource);
    await _playlist.clear();
    await _playlist.addAll(audioSource.toList());
    await _player.setAudioSource(_playlist);
    return await super.updateQueue(newQueue);
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        _player.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.one:
        _player.setLoopMode(LoopMode.one);
        break;
      case AudioServiceRepeatMode.group:
      case AudioServiceRepeatMode.all:
        _player.setLoopMode(LoopMode.all);
        break;
    }
  }
  
  @override
  Future<dynamic> customAction(String name, [Map<String, dynamic>? extras]) async {
    if (name == "retrieveEqualizer") {
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
    if (name == "updateEqualizer") {
      final enabled = extras!['enabled'] == 'true' ? true : false;
      if (enabled) {
        await equalizer.setEnabled(true);
      } else {
        await equalizer.setEnabled(false);
      }
      final bands = List.from(extras['bands']);
      final parameters = await equalizer.parameters;
      for (int i = 0; parameters.bands.length > i; i++) {
        final bandMap = Map<String, dynamic>.from(bands[i]);
        parameters.bands[i].setGain(bandMap["gain"]);
      }
    }
    if (name == 'retrieveLoudnessGain') {
      return {
        'enabled': loudnessEnhancer.enabled ? 'true' : 'false',
        'gain': loudnessEnhancer.targetGain
      };
    }
    if (name == 'updateLoudnessGain') {
      final enabled = extras!['enabled'] == 'true' ? true : false;
      if (enabled) {
        await loudnessEnhancer.setEnabled(true);
      } else {
        await loudnessEnhancer.setEnabled(false);
      }
      final gain = extras['gain'] as double;
      loudnessEnhancer.setTargetGain(gain);
    }
    if (name == 'initBackgroundPlayback') {
      backgroundPlaybackEnabled = true;
      final position = Duration(seconds: extras!['position']);
      final audioUrl = extras['audioUrl'];
      final youtubeStream = StreamInfoItem.fromMap(extras['videoStream']);
      final youtubeVideo = YoutubeVideo(videoInfo: VideoInfo.fromStreamInfoItem(youtubeStream));
      final audioSource = MediaItem(
        id: audioUrl,
        title: youtubeVideo.videoInfo.name!,
        duration: Duration(milliseconds: youtubeVideo.videoInfo.length!),
        artUri: Uri.parse(youtubeVideo.videoInfo.thumbnailUrl!)
      );
      // Resume Playback
      await stop();
      await _player.setAudioSource(_createAudioSource(audioSource), initialPosition: position, preload: false);
      mediaItem.add(audioSource);
      play();
    }
    if (name == 'stopBackgroundPlayback') {
      backgroundPlaybackEnabled = false;
      await stop();
      return {
        'position': _player.position.inSeconds,
      };
    }
    return null;
  }

  /// Play next item in queue for Background Playback
  void backgroundPlaybackGoNext() {
    
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

}