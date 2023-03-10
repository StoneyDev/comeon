import 'dart:collection';
import 'dart:io';

import 'package:comeon/models/recording.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeViewModel extends ChangeNotifier {
  List<Recording> _recordings = [];

  /// An unmodifiable view of the recordings
  UnmodifiableListView<Recording> get recordings => UnmodifiableListView(_recordings);

  Future<Directory?> getPath() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo? androidDeviceInfo;

    if (Platform.isAndroid) {
      androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    }

    final bool storagePermission =
        (await Permission.storage.request().isGranted || (androidDeviceInfo?.version.sdkInt ?? 0) >= 33);

    if (storagePermission) {
      final Directory docPath = await getApplicationDocumentsDirectory();

      return Directory.fromUri(Uri(path: '${docPath.path}/records'));
    }

    return null;
  }

  /// get recordings
  void getRecordings() async {
    try {
      _recordings = [];

      final AudioPlayer audio = AudioPlayer();
      final Directory? recordingsPath = await getPath();

      if (recordingsPath != null) {
        if (!Directory(recordingsPath.path).existsSync()) {
          Directory(recordingsPath.path).createSync();
        }

        final List<FileSystemEntity> storageFiles = recordingsPath.listSync();

        for (final FileSystemEntity file in storageFiles) {
          final Duration? duration = await audio.setUrl(file.path);

          _recordings = [..._recordings, Recording(urlPath: file.uri, duration: duration)];
        }

        notifyListeners();
      }
    } catch (e) {}
  }
}
