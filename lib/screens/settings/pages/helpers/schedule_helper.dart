import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:school_life/models/settings_defaults.dart';
import 'package:school_life/models/user_settings_keys.dart';
import 'package:school_life/services/databases/db_helper.dart';

class ScheduleHelper {
  ScheduleHelper() {
    _settingsBox = Hive.box<dynamic>(DatabaseHelper.SETTINGS_BOX);
    _getVariables();
  }

  Box<dynamic> _settingsBox;
  Map<String, bool> _selectedDays = <String, bool>{};

  Map<String, bool> get selectedDays => _selectedDays;

  void _getVariables() {
    _getSelectedDays();
  }

  void _getSelectedDays() {
    final String mapString =
        _settingsBox.get(UserSettingsKeys.SCHOOL_DAYS) as String;
    if (mapString == null) {
      _selectedDays = ScheduleSettingsDefaults.defaultDaysOfSchool;
      return;
    }
    final Map<String, dynamic> map =
        jsonDecode(mapString) as Map<String, dynamic>;
    _selectedDays = map.cast<String, bool>();
  }

  void saveSelectedDays(Map<String, bool> input) {
    final String mapString = jsonEncode(input);
    _settingsBox.put(UserSettingsKeys.SCHOOL_DAYS, mapString);
    _selectedDays = input;
  }
}
