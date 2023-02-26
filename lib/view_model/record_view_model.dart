import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
    if (await Permission.storage.request().isGranted && await _record.hasPermission()) {
      final Directory docPath = await getApplicationDocumentsDirectory();
      final String recordsStoragePath = '${docPath.path}/records';

      if (!Directory(recordsStoragePath).existsSync()) {
        Directory(recordsStoragePath).createSync();
      }

      // Start recording
      await _record.start(path: '$recordsStoragePath/${DateTime.now().millisecondsSinceEpoch}.m4a');

      _isRecording = await _record.isRecording();
      _isPausing = !_isRecording;

      notifyListeners();
    }
  }

  /// Stop recording
  void stopRecording() async {
    await _record.stop();

    _isRecording = false;
    _isPausing = false;

    notifyListeners();
  }

  /// Pause recording
  void pauseRecording() async {
    await _record.pause();

    _isPausing = await _record.isPaused();
    _isRecording = !_isPausing;

    notifyListeners();
  }
}
