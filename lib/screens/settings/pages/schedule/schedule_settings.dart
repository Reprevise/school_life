import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_life/components/screen_header/screen_header.dart';
import 'package:school_life/enums/schedule_date_type.dart';
import 'package:school_life/main.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/screens/settings/pages/widgets/choose_days_school_dialog.dart';
import 'package:school_life/screens/settings/widgets/router_tile.dart';
import 'package:school_life/screens/settings/widgets/setting_header.dart';
import 'package:school_life/services/settings/schedule.dart';
import 'package:school_life/util/date_utils.dart';

class ScheduleSettingsPage extends StatefulWidget {
  @override
  _ScheduleSettingsPageState createState() => _ScheduleSettingsPageState();
}

class _ScheduleSettingsPageState extends State<ScheduleSettingsPage> {
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
      builder: (context) {
        return ChooseDaysOfSchoolDialog(
          selectedDays: helper.dayValues,
          onSaved: (value) {
            helper.saveDayValues(value);
            setState(() {});
          },
        );
      },
    );
  }

  Future<void> _selectDate(ScheduleDateType type) async {
    final result = await showDatePicker(
      context: context,
      initialDate:
          type == ScheduleDateType.start ? helper.startDate : helper.endDate,
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
    final result = await showTimePicker(
      context: context,
      initialTime:
          type == ScheduleDateType.start ? helper.startTime : helper.endTime,
    );
    if (result == null) {
      return;
    }
    helper.saveTime(type, result);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.bodyText2;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ListView(
        primary: false,
        children: <Widget>[
          Row(
            children: <Widget>[
              BackButton(),
              const ScreenHeader('Schedule Settings'),
            ],
          ),
          const SettingHeader('Basics'),
          ListTile(
            title: Text('School Days', style: titleStyle),
            subtitle: Text(helper.getDisplayableDays()),
            onTap: _selectSchoolDaysDialog,
          ),
          ListTile(
            title: Text('Start date', style: titleStyle),
            subtitle: Text(formatDate(helper.startDate) ?? 'Not set'),
            onTap: () => _selectDate(ScheduleDateType.start),
          ),
          ListTile(
            title: Text('End date', style: titleStyle),
            subtitle: Text(formatDate(helper.endDate) ?? 'Not set'),
            onTap: () => _selectDate(ScheduleDateType.end),
          ),
          ListTile(
            title: Text('Start time', style: titleStyle),
            subtitle: Text(helper.startTime?.format(context) ?? 'Not set'),
            onTap: () => _selectTime(ScheduleDateType.start),
          ),
          ListTile(
            title: Text('End time', style: titleStyle),
            subtitle: Text(helper.endTime?.format(context) ?? 'Not set'),
            onTap: () => _selectTime(ScheduleDateType.end),
          ),
          RouterTile(
            title: 'Holidays',
            icon: Icons.event,
            route: Routes.holidays,
          ),
        ],
      ),
    );
  }
}
