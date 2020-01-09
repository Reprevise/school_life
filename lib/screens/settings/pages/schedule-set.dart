import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/models/settings_defaults.dart';
import 'package:school_life/models/user_settings.dart';
import 'package:school_life/screens/settings/pages/widgets/choose_days_school_dialog.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/util/days_from_integer.dart';

class ScheduleSettingsPage extends StatefulWidget {
  @override
  _ScheduleSettingsPageState createState() => _ScheduleSettingsPageState();
}

class _ScheduleSettingsPageState extends State<ScheduleSettingsPage> {
  Box<dynamic> settings;
  Map<String, bool> _selectedDays = <String, bool>{};

  @override
  void initState() {
    super.initState();
    settings = Hive.box<dynamic>(DatabaseHelper.SETTINGS_BOX);
    _getSelectedDays();
  }

  void _getSelectedDays() {
    final String mapString =
        settings.get(UserSettingsKeys.SCHOOL_DAYS) as String;
    if (mapString == null) {
      _selectedDays = ScheduleSettingsDefaults.defaultDaysOfSchool;
    }
    final Map<String, bool> map =
        json.decode(mapString).cast<String, bool>() as Map<String, bool>;
    _selectedDays = map;
  }

  void _selectSchoolDaysDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ChooseDaysOfSchoolDialog(
          selectedDays: _selectedDays,
          onSaved: (Map<String, bool> value) {
            final String mapString = jsonEncode(value);
            settings.put(UserSettingsKeys.SCHOOL_DAYS, mapString);
            setState(() {
              _selectedDays = value;
            });
          },
        );
      },
    );
  }

  String _getDisplayableDays() {
    final List<String> days = <String>[];
    final Map<String, bool> temp = Map<String, bool>.from(_selectedDays);
    temp.removeWhere((String key, bool value) => value == false);
    final List<String> daysInIntegerString = temp.keys.toList();
    for (String item in daysInIntegerString) {
      days.add(daysFromIntegerString[item]);
    }
    return days.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('Schedule Settings'),
      body: ListView(
        primary: false,
        children: <Widget>[
          ListTile(
            title: const Text('School Days'),
            subtitle: Text(_getDisplayableDays()),
            onTap: _selectSchoolDaysDialog,
          )
        ],
      ),
    );
  }
}
