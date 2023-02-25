import 'package:flutter/material.dart';
import 'package:record/record.dart';

class RecordViewModel extends ChangeNotifier {
  final Record _record = Record();

  bool _isRecording = false;
  bool _isPausing = false;

  // Getter
  bool get isRecording => _isRecording;
  bool get isPausing => _isPausing;

  /// Launch record
  void startRecording() async {
    try {
      if (await _record.hasPermission()) {
        // Start recording
        await _record.start();

        _isRecording = await _record.isRecording();
        _isPausing = !_isRecording;

        notifyListeners();
      }
    } catch (e) {}
  }

  /// Stop recording
  void stopRecording() async {
    try {
      await _record.stop();

      _isRecording = false;
      _isPausing = false;

      notifyListeners();
    } catch (e) {}
  }

  /// Pause recording
  void pauseRecording() async {
    try {
      await _record.pause();

      _isPausing = await _record.isPaused();
      _isRecording = !_isPausing;

      notifyListeners();
    } catch (e) {}
  }
}
