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
  Box settings;
  Map<String, bool> _selectedDays = {};

  @override
  void initState() {
    super.initState();
    settings = Hive.box(DatabaseHelper.SETTINGS_BOX);
    _getSelectedDays();
  }

  void _getSelectedDays() {
    String mapString = settings.get(UserSettingsKeys.SCHOOL_DAYS);
    if (mapString == null) {
      _selectedDays = ScheduleSettingsDefaults.defaultDaysOfSchool;
    }
    Map<String, bool> map = json.decode(mapString).cast<String, bool>();
    _selectedDays = map;
  }

  void _selectSchoolDaysDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: ChooseDaysOfSchoolDialog(
        selectedDays: _selectedDays,
        onSaved: (value) {
          final String mapString = jsonEncode(value);
          settings.put(UserSettingsKeys.SCHOOL_DAYS, mapString);
          setState(() {
            _selectedDays = value;
          });
        },
      ),
    );
  }

  String _getDisplayableDays() {
    List<String> days = [];
    Map<String, bool> temp = Map.from(_selectedDays);
    temp.removeWhere((key, value) => value == false);
    List daysInIntegerString = temp.keys.toList();
    for (String item in daysInIntegerString) {
      days.add(daysFromIntegerString[item]);
    }
    return days.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Schedule Settings"),
      body: ListView(
        primary: false,
        children: <Widget>[
          ListTile(
            title: Text("School Days"),
            subtitle: Text(_getDisplayableDays()),
            onTap: _selectSchoolDaysDialog,
          )
        ],
      ),
    );
  }
}
