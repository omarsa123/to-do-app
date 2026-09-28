import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract final class DateUtilities {
  static String labelDate(DateTime date) {
    DateTime tomorow = DateUtils.dateOnly(
      DateTime.now(),
    ).add(Duration(days: 1));
    DateTime yesterday = DateUtils.dateOnly(
      DateTime.now(),
    ).subtract(Duration(days: 1));
    DateTime today = DateUtils.dateOnly(DateTime.now());
    DateTime selected = DateUtils.dateOnly(date);
    if (selected == yesterday) {
      return 'Yesterday';
    } else if (selected == today) {
      return 'Today';
    } else if (selected == tomorow) {
      return 'Tommorow';
    } else {
      return DateFormat('dd / MM / yyyy').format(date);
    }
  }
  static String formatTime(DateTime time) {
  return '${time.hour.toString().padLeft(2, '0')}:'
      '${time.minute.toString().padLeft(2, '0')}';
}
}