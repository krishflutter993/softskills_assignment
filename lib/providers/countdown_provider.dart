import 'dart:async';
import 'package:flutter/material.dart';

class CountdownProvider extends ChangeNotifier {
  Timer? _timer;
  String _formattedTime = '';
  final VoidCallback? onWeekEndedCallback;

  CountdownProvider({this.onWeekEndedCallback}) {
    _startTimer();
  }

  String get formattedTime => _formattedTime;

  void _startTimer() {
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    final target = getNextSundayEnd();
    final difference = target.difference(now);

    if (difference.isNegative || difference.inSeconds <= 0) {
      _formattedTime = "0d 0h 0m 0s";
      notifyListeners();
      
      // Trigger callback if week ended
      if (onWeekEndedCallback != null) {
        onWeekEndedCallback!();
      }
      return;
    }

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;

    _formattedTime = "${days}d ${hours}h ${minutes}m ${seconds}s";
    notifyListeners();
  }

  /// Calculates the next Sunday at 11:59:59 PM local time.
  DateTime getNextSundayEnd() {
    final now = DateTime.now();
    int daysUntilSunday = DateTime.sunday - now.weekday;

    DateTime target = DateTime(
      now.year,
      now.month,
      now.day + daysUntilSunday,
      23,
      59,
      59,
    );

    // If today is Sunday and we are past 23:59:59, schedule for the next Sunday
    if (target.isBefore(now)) {
      target = target.add(const Duration(days: 7));
    }
    return target;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
