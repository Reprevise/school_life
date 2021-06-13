import 'package:flutter/material.dart';

abstract class BasicSettingsDefaults {
  static const ThemeMode theme = ThemeMode.system;
  static const String firstName = 'Guest';
  static const String lastName = '';
}

abstract class ScheduleSettingsDefaults {
  static const bool weekends = false;
}
