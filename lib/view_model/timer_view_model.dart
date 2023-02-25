import 'dart:async';

import 'package:flutter/material.dart';

class TimerViewModel extends ChangeNotifier {
  late Timer _timer;

  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  int get hours => _hours;
  int get minutes => _minutes;
  int get seconds => _seconds;

  /// Launch timer
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds += 1;
      _minutes = _minutes;
      _hours = _hours;

      if (_seconds > 59) {
        if (_minutes > 59) {
          _hours += 1;
          _minutes = 0;
        } else {
          _minutes += 1;
          _seconds = 0;
        }
      }

      notifyListeners();
    });
  }

  /// Stop timer
  void resetTimer() {
    _timer.cancel();

    _hours = 0;
    _minutes = 0;
    _seconds = 0;

    notifyListeners();
  }

  /// Pause timer
  void pauseTimer() {
    _timer.cancel();

    notifyListeners();
  }
}
