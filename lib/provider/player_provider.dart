// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:audioplayers/audioplayers.dart';
import 'package:songtube/internal/database/models/downloaded_file.dart';

enum PlayerState { playing, stopped, paused }
class Player extends ChangeNotifier {

  final AudioPlayer audioPlayer = AudioPlayer();
  String currentSong;
  PlayerState _playerState;
  List<DownloadedFile> queue;
  int queueIndex;
  bool _showMediaPlayer = false;
  
  Player() {
    _playerState = PlayerState.stopped;
    listener();
  }

  listener() {
    audioPlayer.onPlayerCompletion.listen((event){
      print("AudioPlayer: Song ended");
      onComplete();
    });
  }

  bool get showMediaPlayer => _showMediaPlayer;

  set showMediaPlayer(bool value) {
    _showMediaPlayer = value;
    notifyListeners();
  }

  Stream get position => audioPlayer.onAudioPositionChanged;
  Stream get duration => audioPlayer.onDurationChanged;

  PlayerState get playerState => _playerState;
  set playerState(PlayerState value) {
    _playerState = value;
    notifyListeners();
  }
  
  void onComplete() async {
    int result = await playNext();
    if (result == null) {
      playerState = PlayerState.stopped;
      showMediaPlayer = false;
    }
    notifyListeners();
  }

  Future<void> play([int index]) async {
    int result;
    if (index == null) {
      if (currentSong == null) return;
      result = await audioPlayer.play(currentSong,
        isLocal: true, respectAudioFocus: true);
    } else {
      currentSong = queue[index].path;
      result = await audioPlayer.play(currentSong,
        isLocal: true, respectAudioFocus: true);
      queueIndex = index;
    }
    if (result == 1) playerState = PlayerState.playing;
  }

  void pause() {
    audioPlayer.pause();
    playerState = PlayerState.paused;
  }

  void stop() {
    audioPlayer.stop();
    currentSong = null;
    playerState = PlayerState.stopped;
    showMediaPlayer = false;
    notifyListeners();
  }

  Future<int> playPrevious() async {
    if (queue[queueIndex] != queue.first) {
      await play(queueIndex-1);
      notifyListeners();
      return 0;
    }
    return null;
  }

  Future<int> playNext() async {
    if (queue[queueIndex] != queue.last) {
      await play(queueIndex+1);
      notifyListeners();
      return 0;
    }
    return null;
  }

  void seek(Duration position) => audioPlayer.seek(position);

}