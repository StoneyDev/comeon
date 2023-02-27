import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
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
  Future<void> startRecording() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo? androidDeviceInfo;

    if (Platform.isAndroid) {
      androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    }

    final bool storagePermission =
        (await Permission.storage.request().isGranted || (androidDeviceInfo?.version.sdkInt ?? 0) >= 33);

    if (storagePermission && await _record.hasPermission()) {
      final Directory docPath = await getApplicationDocumentsDirectory();
      final String recordsStoragePath = '${docPath.path}/records';

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
