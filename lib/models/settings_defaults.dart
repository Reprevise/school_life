import 'package:flutter/material.dart';

class MainSettingsDefaults {
  static const Brightness DEFAULT_BRIGHTNESS = Brightness.light;
}

class ScheduleSettingsDefaults {
  static Map<int, bool> defaultDaysOfSchool = {
    DateTime.monday: true,
    DateTime.tuesday: true,
    DateTime.wednesday: true,
    DateTime.thursday: true,
    DateTime.friday: true,
    DateTime.saturday: false,
    DateTime.sunday: false,
  };

}
