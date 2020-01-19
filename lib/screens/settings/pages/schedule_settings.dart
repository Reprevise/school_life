import 'package:flutter/material.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/main.dart';
import 'package:school_life/screens/settings/pages/helpers/schedule_helper.dart';
import 'package:school_life/screens/settings/pages/widgets/choose_days_school_dialog.dart';
import 'package:school_life/util/days_util.dart';

class ScheduleSettingsPage extends StatefulWidget {
  @override
  _ScheduleSettingsPageState createState() => _ScheduleSettingsPageState();
}

class _ScheduleSettingsPageState extends State<ScheduleSettingsPage> {
  // Map<String, bool> _selectedDays = <String, bool>{};
  ScheduleHelper helper;

  @override
  void initState() {
    super.initState();
    helper = getIt<ScheduleHelper>();
  }

  void _selectSchoolDaysDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ChooseDaysOfSchoolDialog(
          selectedDays: helper.selectedDays,
          onSaved: (Map<String, bool> value) {
            helper.saveSelectedDays(value);
            setState(() {});
          },
        );
      },
    );
  }

  String _getDisplayableDays() {
    final List<String> days = <String>[];
    final Map<String, bool> copy = Map<String, bool>.from(helper.selectedDays);
    copy.removeWhere((String key, bool value) => value == false);
    final List<String> daysInIntegerString = copy.keys.toList();
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
