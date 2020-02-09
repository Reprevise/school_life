import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/enums/schedule_date_type.dart';
import 'package:school_life/main.dart';
import 'package:school_life/screens/settings/pages/helpers/schedule_settings_helper.dart';
import 'package:school_life/screens/settings/pages/widgets/choose_days_school_dialog.dart';
import 'package:school_life/screens/settings/pages/widgets/holidays.dart';
import 'package:school_life/screens/settings/widgets/index.dart';
import 'package:school_life/util/date_utils.dart';

class ScheduleSettingsPage extends StatefulWidget {
  @override
  _ScheduleSettingsPageState createState() => _ScheduleSettingsPageState();
}

class _ScheduleSettingsPageState extends State<ScheduleSettingsPage> {
  // Map<String, bool> _selectedDays = <String, bool>{};
  ScheduleSettingsHelper helper;

  @override
  void initState() {
    super.initState();
    helper = sl<ScheduleSettingsHelper>();
  }

  void _selectSchoolDaysDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ChooseDaysOfSchoolDialog(
          selectedDays: helper.dayValues,
          onSaved: (Map<String, bool> value) {
            helper.saveDayValues(value);
            setState(() {});
          },
        );
      },
    );
  }

  Future<void> _selectDate(ScheduleDateType type) async {
    final DateTime result = await showDatePicker(
      context: context,
      initialDate:
          type == ScheduleDateType.START ? helper.startDate : helper.endDate,
      firstDate: DateTime.now().onlyDate.subtractYears(5),
      lastDate: DateTime.now().onlyDate.addYears(5),
    );
    if (result == null) {
      return;
    }
    helper.saveDate(type, result);
    setState(() {});
  }

  String formatDate(DateTime date) {
    if (date == null) {
      return null;
    }
    return DateFormat.yMMMd().format(date);
  }

  Future<void> _selectTime(ScheduleDateType type) async {
    final TimeOfDay result = await showTimePicker(
      context: context,
      initialTime:
          type == ScheduleDateType.START ? helper.startTime : helper.endTime,
    );
    if (result == null) {
      return;
    }
    helper.saveTime(type, result);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('Schedule Settings'),
      body: ListView(
        primary: false,
        children: <Widget>[
          const SettingHeader('Basics'),
          ListTile(
            title: const Text('School Days'),
            subtitle: Text(helper.getDisplayableDays()),
            onTap: _selectSchoolDaysDialog,
          ),
          ListTile(
            title: const Text('Start date'),
            subtitle: Text(formatDate(helper.startDate) ?? 'Not set'),
            onTap: () => _selectDate(ScheduleDateType.START),
          ),
          ListTile(
            title: const Text('End date'),
            subtitle: Text(formatDate(helper.endDate) ?? 'Not set'),
            onTap: () => _selectDate(ScheduleDateType.END),
          ),
          ListTile(
            title: const Text('Start time'),
            subtitle: Text(helper.startTime?.format(context) ?? 'Not set'),
            onTap: () => _selectTime(ScheduleDateType.START),
          ),
          ListTile(
            title: const Text('End time'),
            subtitle: Text(helper.endTime?.format(context) ?? 'Not set'),
            onTap: () => _selectTime(ScheduleDateType.END),
          ),
          RouterTile(
            title: 'Holidays',
            icon: Icons.event,
            route: const ScheduleHolidaysPage(),
          ),
        ],
      ),
    );
  }
}
