import 'package:flutter/material.dart';
import 'package:record/record.dart';

class RecordViewModel extends ChangeNotifier {
  final Record record = Record();

  bool isRecording = false;
  bool isPausing = false;

  bool get status => isRecording;

  /// Launch record
  void startRecording() async {
    try {
      if (await record.hasPermission()) {
        // Start recording
        await record.start();

        isRecording = await record.isRecording();
        isPausing = !isRecording;

        notifyListeners();
      }
    } catch (e) {}
  }

  /// Stop recording
  void stopRecording() async {
    try {
      await record.stop();

      isRecording = false;
      isPausing = false;

      notifyListeners();
    } catch (e) {}
  }

  /// Pause recording
  void pauseRecording() async {
    try {
      await record.pause();

      isPausing = await record.isPaused();
      isRecording = !isPausing;

      notifyListeners();
    } catch (e) {}
  }
}
