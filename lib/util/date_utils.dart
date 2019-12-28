import 'package:flutter/material.dart';

extension DateUtils on DateTime {
  DateTime get todaysDate => DateTime(year, month, day);
  TimeOfDay get currentTime => TimeOfDay.fromDateTime(this);
}
