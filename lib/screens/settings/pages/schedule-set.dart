import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/models/settings_defaults.dart';
import 'package:school_life/models/user_settings.dart';
import 'package:school_life/services/databases/settings_db.dart';
import 'package:school_life/util/days_from_integer.dart';

class ScheduleSettingsPage extends StatefulWidget {
  @override
  _ScheduleSettingsPageState createState() => _ScheduleSettingsPageState();
}

class _ScheduleSettingsPageState extends State<ScheduleSettingsPage> {
  Box settings;
  Map _selectedDays = <int, bool>{};

  @override
  void initState() {
    super.initState();
    settings = Hive.box(SettingsDBCreator.SETTINGS_BOX);
    _getDefaultValues();
  }

  void _getDefaultValues() {
    _selectedDays = settings.get(UserSettingsKeys.SCHOOL_DAYS) ??
        ScheduleSettingsDefaults.defaultDaysOfSchool;
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

  String getDisplayableDays() {
    List<String> days = [];
    Map temp = Map.from(_selectedDays);
    temp.removeWhere((key, value) => value == false);
    print(temp);
    List daysInIntegers = temp.keys.toList();
    for (int item in daysInIntegers) {
      days.add(DAYS_FROM_INTEGER[item]);
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
            subtitle: Text(getDisplayableDays()),
            onTap: _selectSchoolDaysDialog,
          )
        ],
      ),
    );
  }
}

class ChooseDaysOfSchoolDialog extends StatefulWidget {
  const ChooseDaysOfSchoolDialog({
    Key key,
    @required this.selectedDays,
    @required this.onSaved,
  }) : super(key: key);

  final Map<int, bool> selectedDays;
  final ValueChanged<Map<int, bool>> onSaved;

  @override
  _ChooseDaysOfSchoolDialogState createState() =>
      _ChooseDaysOfSchoolDialogState(selectedDays);
}

class _ChooseDaysOfSchoolDialogState extends State<ChooseDaysOfSchoolDialog> {
  _ChooseDaysOfSchoolDialogState(this._selectedDays);

  Map<int, bool> _selectedDays;

  @override
  Widget build(BuildContext context) {
    final DialogTheme _dialogTheme = Theme.of(context).dialogTheme;
    final Color _contentStyleColor = _dialogTheme.contentTextStyle.color;
    return AlertDialog(
      title: Text("What days do you have school?"),
      actions: <Widget>[
        MaterialButton(
          child: Text(
            "SAVE",
            style: TextStyle(color: _contentStyleColor),
          ),
          onPressed: () {
            widget.onSaved(_selectedDays);
            Navigator.pop(context);
          },
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CheckboxListTile(
              title: Text("Monday"),
              value: _selectedDays[DateTime.monday],
              onChanged: (value) {
                setState(() {
                  _selectedDays[DateTime.monday] = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Tuesday"),
              value: _selectedDays[DateTime.tuesday],
              onChanged: (value) {
                setState(() {
                  _selectedDays[DateTime.tuesday] = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Wednesday"),
              value: _selectedDays[DateTime.wednesday],
              onChanged: (value) {
                setState(() {
                  _selectedDays[DateTime.wednesday] = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Thursday"),
              value: _selectedDays[DateTime.thursday],
              onChanged: (value) {
                setState(() {
                  _selectedDays[DateTime.thursday] = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Friday"),
              value: _selectedDays[DateTime.friday],
              onChanged: (value) {
                setState(() {
                  _selectedDays[DateTime.friday] = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Saturday"),
              value: _selectedDays[DateTime.saturday],
              onChanged: (value) {
                setState(() {
                  _selectedDays[DateTime.saturday] = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Sunday"),
              value: _selectedDays[DateTime.sunday],
              onChanged: (value) {
                setState(() {
                  _selectedDays[DateTime.sunday] = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
