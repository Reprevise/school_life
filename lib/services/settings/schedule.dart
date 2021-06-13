import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../enums/schedule_date_type.dart';
import '../../models/settings_defaults.dart';
import '../../models/settings_keys.dart';
import '../../util/day_utils.dart';
import '../databases/hive_helper.dart';

class ScheduleSettingsHelper {
  late final Box<dynamic> _settingsBox;

  ScheduleSettingsHelper() {
    _settingsBox = Hive.box<dynamic>(HiveBoxes.settingsBox);
  }

  bool get areWeekendsEnabled {
    return _settingsBox.get(
      SettingsKeys.weekends,
      defaultValue: ScheduleSettingsDefaults.weekends,
    );
  }

  DateTime get startDate {
    return _settingsBox.get(
      SettingsKeys.startDate,
      defaultValue: DateTime(DateTime.now().year),
    );
  }

  DateTime get endDate {
    return _settingsBox.get(
      SettingsKeys.endDate,
      defaultValue: DateTime(DateTime.now().year),
    );
  }

  TimeOfDay get startTime {
    return _settingsBox.get(
      SettingsKeys.startTime,
      defaultValue: TimeOfDay(hour: 8, minute: 0),
    );
  }

  TimeOfDay get endTime {
    return _settingsBox.get(
      SettingsKeys.endTime,
      defaultValue: TimeOfDay(hour: 14, minute: 30),
    );
  }

  Future<void> saveWeekendStatus(bool newValue) async {
    await _settingsBox.put(SettingsKeys.weekends, newValue);
  }

  String getDisplayableDays() {
    if (areWeekendsEnabled) {
      return weekdaysWithWeekends.join(', ');
    }
    return weekdays.join(', ');
  }

  Future<void> saveDate(ScheduleDateType type, DateTime date) async {
    switch (type) {
      case ScheduleDateType.start:
        await _settingsBox.put(SettingsKeys.startDate, date);
        break;
      case ScheduleDateType.end:
        await _settingsBox.put(SettingsKeys.endDate, date);
        break;
    }
  }

  Future<void> saveTime(ScheduleDateType type, TimeOfDay time) async {
    switch (type) {
      case ScheduleDateType.start:
        await _settingsBox.put(SettingsKeys.startTime, time);
        break;
      case ScheduleDateType.end:
        await _settingsBox.put(SettingsKeys.endTime, time);
        break;
    }
  }
}
