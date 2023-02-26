import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioViewModel extends ChangeNotifier {
  final AudioPlayer _audio = AudioPlayer();

  AudioState _state = AudioState.loading;
  int _position = 0;

  // Getter
  AudioState get state => _state;
  int get position => _position;

  void init(Uri uriAudio) {
    // Adds the path to the file to read it
    _audio.setAudioSource(AudioSource.uri(uriAudio));

    // Track position of the player
    _audio.positionStream.listen((Duration event) {
      _position = event.inSeconds;
      notifyListeners();
    });

    // State of player
    _audio.playerStateStream.listen((PlayerState state) {
      final bool isPlaying = state.playing;

      if (state.processingState == ProcessingState.loading || state.processingState == ProcessingState.buffering) {
        _state = AudioState.loading;
      } else if (!isPlaying) {
        _state = AudioState.paused;
      } else if (state.processingState != ProcessingState.completed) {
        _state = AudioState.playing;
      } else {
        _audio.seek(Duration.zero);
        _audio.pause();
      }

      notifyListeners();
    });
  }

  /// Play audio
  void play() => _audio.play();

  /// Pause audio
  void pause() => _audio.pause();

  void deleteRecording(String path) => File(path).deleteSync();
}

enum AudioState { loading, paused, playing }
