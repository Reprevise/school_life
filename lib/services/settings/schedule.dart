import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:school_life/enums/schedule_date_type.dart';
import 'package:school_life/models/settings_defaults.dart';
import 'package:school_life/models/settings_keys.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/util/days_util.dart';
import 'package:school_life/util/date_utils.dart';

@singleton
@injectable
class ScheduleSettingsHelper {
  ScheduleSettingsHelper() {
    _settingsBox = Hive.box<dynamic>(Databases.settingsBox);
    _getVariables();
  }

  Box<dynamic> _settingsBox;

  Map<String, bool> _dayValues = <String, bool>{};
  Map<String, bool> get dayValues => _dayValues;

  DateTime _startDate, _endDate;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;

  TimeOfDay _startTime, _endTime;
  TimeOfDay get startTime => _startTime;
  TimeOfDay get endTime => _endTime;

  void _getVariables() {
    _getDayValues();
    _getDates();
    _getTimes();
  }

  void _getDayValues() {
    final mapString =
        _settingsBox.get(SettingsKeys.schoolDays) as String;
    if (mapString == null) {
      _dayValues = ScheduleSettingsDefaults.daysOfSchool;
      return;
    }
    final map =
        jsonDecode(mapString) as Map<String, dynamic>;
    _dayValues = map.cast<String, bool>();
  }

  void _getDates() {
    _startDate = _settingsBox.get(SettingsKeys.startDate) as DateTime;
    _endDate = _settingsBox.get(SettingsKeys.endDate) as DateTime;
    _startDate ??= DateTime(DateTime.now().year);
    _endDate ??= DateTime(DateTime.now().year);
  }

  void _getTimes() {
    _startTime = _settingsBox.get(SettingsKeys.startTime) as TimeOfDay;
    _endTime = _settingsBox.get(SettingsKeys.endTime) as TimeOfDay;
    _startTime ??= const TimeOfDay(hour: 8, minute: 0);
    _endTime ??= const TimeOfDay(hour: 14, minute: 30);
  }

  void saveDayValues(Map<String, bool> input) {
    final mapString = jsonEncode(input);
    _settingsBox.put(SettingsKeys.schoolDays, mapString);
    _dayValues = input;
  }

  String getDisplayableDays() {
    final days = <String>[];
    final dayValuesCopy = Map<String, bool>.from(_dayValues);
    dayValuesCopy.removeWhere((key, value) => value == false);
    final daysInIntegerString = dayValuesCopy.keys.toList();
    for (final item in daysInIntegerString) {
      days.add(daysFromIntegerString[item]);
    }
    return days.join(', ');
  }

  void saveDate(ScheduleDateType type, DateTime date) {
    switch (type) {
      case ScheduleDateType.start:
        _startDate = date.onlyDate;
        _settingsBox.put(SettingsKeys.startDate, date);
        break;
      case ScheduleDateType.end:
        _endDate = date.onlyDate;
        _settingsBox.put(SettingsKeys.endDate, date);
        break;
    }
  }

  void saveTime(ScheduleDateType type, TimeOfDay time) {
    switch (type) {
      case ScheduleDateType.start:
        _startTime = time;
        _settingsBox.put(SettingsKeys.startTime, time);
        break;
      case ScheduleDateType.end:
        _endTime = time;
        _settingsBox.put(SettingsKeys.endTime, time);
        break;
    }
  }
}
