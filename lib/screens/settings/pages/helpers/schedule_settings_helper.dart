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
    _settingsBox = Hive.box<dynamic>(Databases.SETTINGS_BOX);
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
    final String mapString =
        _settingsBox.get(SettingsKeys.SCHOOL_DAYS) as String;
    if (mapString == null) {
      _dayValues = ScheduleSettingsDefaults.defaultDaysOfSchool;
      return;
    }
    final Map<String, dynamic> map =
        jsonDecode(mapString) as Map<String, dynamic>;
    _dayValues = map.cast<String, bool>();
  }

  void _getDates() {
    _startDate = _settingsBox.get(SettingsKeys.START_DATE) as DateTime;
    _endDate = _settingsBox.get(SettingsKeys.END_DATE) as DateTime;
    _startDate ??= DateTime(DateTime.now().year);
    _endDate ??= DateTime(DateTime.now().year);
  }

  void _getTimes() {
    _startTime = _settingsBox.get(SettingsKeys.START_TIME) as TimeOfDay;
    _endTime = _settingsBox.get(SettingsKeys.END_TIME) as TimeOfDay;
    _startTime ??= const TimeOfDay(hour: 8, minute: 0);
    _endTime ??= const TimeOfDay(hour: 14, minute: 30);
  }

  void saveDayValues(Map<String, bool> input) {
    final String mapString = jsonEncode(input);
    _settingsBox.put(SettingsKeys.SCHOOL_DAYS, mapString);
    _dayValues = input;
  }

  String getDisplayableDays() {
    final List<String> days = <String>[];
    final Map<String, bool> dayValuesCopy = Map<String, bool>.from(_dayValues);
    dayValuesCopy.removeWhere((String key, bool value) => value == false);
    final List<String> daysInIntegerString = dayValuesCopy.keys.toList();
    for (final String item in daysInIntegerString) {
      days.add(daysFromIntegerString[item]);
    }
    return days.join(', ');
  }

  void saveDate(ScheduleDateType type, DateTime date) {
    switch (type) {
      case ScheduleDateType.START:
        _startDate = date.onlyDate;
        _settingsBox.put(SettingsKeys.START_DATE, date);
        break;
      case ScheduleDateType.END:
        _endDate = date.onlyDate;
        _settingsBox.put(SettingsKeys.END_DATE, date);
        break;
    }
  }

  void saveTime(ScheduleDateType type, TimeOfDay time) {
    switch (type) {
      case ScheduleDateType.START:
        _startTime = time;
        _settingsBox.put(SettingsKeys.START_TIME, time);
        break;
      case ScheduleDateType.END:
        _endTime = time;
        _settingsBox.put(SettingsKeys.END_TIME, time);
        break;
    }
  }
}
