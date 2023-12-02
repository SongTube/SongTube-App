import 'dart:io';
import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/models/videoInfo.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:songtube/internal/artwork_manager.dart';

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
    _notifyAudioHandlerAboutPlaybackEvents();
    _handlePlaybackCompleted();
  }

  // Video Player Background Playback stuff
  bool backgroundPlaybackEnabled = false;

  // Current Index
  int? _index;
  bool get hasNext => _index != null && (_index! + 1 < queue.value.length);
  bool get hasPrevious => _index != null && (_index! > 0);

  // Enable Repeat & Random
  bool enableRepeat = false;
  bool enableRandom = false;

  late final _player = AudioPlayer(audioPipeline: AudioPipeline(
    androidAudioEffects: [ equalizer, loudnessEnhancer ]));
  final VideoExtractor extractor = VideoExtractor();

  // Equalizer
  AndroidEqualizer equalizer = AndroidEqualizer();
  AndroidLoudnessEnhancer loudnessEnhancer = AndroidLoudnessEnhancer();

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
        queueIndex: _index,
      ));
    });
  }

  Future<UriAudioSource> _createAudioSource(MediaItem mediaItem) async {
    File? artwork;
    try {
      artwork = await ArtworkManager.writeArtwork(mediaItem.id);
    } catch (_) {}
    final item = mediaItem.copyWith(artUri: artwork != null && !backgroundPlaybackEnabled ? Uri.parse('file://${artwork.path}') : mediaItem.artUri);
    return AudioSource.file(mediaItem.id, tag: item);
  }

  void _handlePlaybackCompleted() {
    _player.processingStateStream.listen((event) async {
      if (event == ProcessingState.completed) {
        if (enableRandom || enableRepeat) {
          if (enableRepeat) {
            await _player.seek(Duration.zero);
            await play();
            return;
          }
          if (enableRandom) {
            final randomIndex = Random().nextInt(queue.value.length-1);
            skipToQueueItem(randomIndex);
          }
        } else {
          skipToNext();
        }
      }
    });
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    mediaItem.add(null);
    await _player.stop();
    return super.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() async {
    if (hasNext) {
      skip(_index!+1);
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (hasPrevious) {
      skip(_index!-1);
    }
  }

  Future<void> skip(int index) async {
    try {    // Load next item
      _index = index;
      final audioSource = await _createAudioSource(queue.value[_index!]);
      mediaItem.add(audioSource.tag);
      await _player.setAudioSource(audioSource);
      await play();
    } catch (_) {}
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    try {
      if (index < 0 || index >= queue.value.length) return;
      // Load next item
      _index = index;
      final audioSource = await _createAudioSource(queue.value[_index!]);
      mediaItem.add(audioSource.tag);
      await _player.setAudioSource(audioSource);
      await play();
    } catch (_) {}
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    if (shuffleMode == AudioServiceShuffleMode.none) {
      enableRandom = false;
    } else {
      enableRandom = true;
    }
  }

  @override
  Future<void> updateQueue(List<MediaItem> newQueue) async {
    try {
      queue.add(newQueue);
    } catch (_) {}
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
      await _player.setAudioSource(await _createAudioSource(audioSource), initialPosition: position, preload: false);
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