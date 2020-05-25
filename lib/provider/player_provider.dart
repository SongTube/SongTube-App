// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:audioplayers/audioplayers.dart';

enum PlayerState { playing, stopped, paused }
class Player extends ChangeNotifier {

  AudioPlayer audioPlayer;
  String currentSong;
  PlayerState _playerState;

  Player() {
    audioPlayer = AudioPlayer();
    _playerState = PlayerState.stopped;
    audioPlayer.onPlayerCompletion.listen((event) {
      playerState = PlayerState.stopped;
    });
  }

  PlayerState get playerState => _playerState;
  set playerState(PlayerState value) {
    _playerState = value;
    notifyListeners();
  }

  void play([String songPath]) async {
    int result;
    if (songPath == null) {
      if (currentSong == null) return;
      result = await audioPlayer.play(currentSong,
        isLocal: true, respectAudioFocus: true);
    } else {
      currentSong = songPath;
      result = await audioPlayer.play(songPath,
        isLocal: true, respectAudioFocus: true);
    }

    if (result == 1) {
      playerState = PlayerState.playing;
    }
  }

  void pause() {
    audioPlayer.pause();
    playerState = PlayerState.paused;
  }

  void stop() {
    audioPlayer.stop();
    currentSong = null;
    playerState = PlayerState.stopped;
  }

}