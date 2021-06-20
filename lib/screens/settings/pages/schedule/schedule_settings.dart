import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dart_date/dart_date.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../components/screen_header/screen_header.dart';
import '../../../../enums/schedule_date_type.dart';
import '../../../../services/settings/schedule.dart';
import '../../../../util/date_utils.dart';
import '../../widgets/router_tile.dart';
import '../../widgets/setting_header.dart';

class ScheduleSettingsPage extends StatefulWidget {
  const ScheduleSettingsPage({Key? key}) : super(key: key);

  @override
  _ScheduleSettingsPageState createState() => _ScheduleSettingsPageState();
}

class _ScheduleSettingsPageState extends State<ScheduleSettingsPage> {
  late final ScheduleSettingsHelper helper;
  var weekends = false;

  @override
  void initState() {
    super.initState();
    helper = locator<ScheduleSettingsHelper>();
    weekends = helper.areWeekendsEnabled;
  }

  Future<void> _selectDate(ScheduleDateType type) async {
    final result = await showDatePicker(
      context: context,
      initialDate:
          type == ScheduleDateType.start ? helper.startDate : helper.endDate,
      firstDate: DateTime.now().onlyDate.subYears(5),
      lastDate: DateTime.now().onlyDate.addYears(5),
    );
    if (result == null) {
      return;
    }
    await helper.saveDate(type, result);
    setState(() {});
  }

  String? formatDate(DateTime? date) {
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
    await helper.saveTime(type, result);
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
            children: const <Widget>[
              BackButton(),
              ScreenHeader('Schedule Settings'),
            ],
          ),
          const SettingHeader('Basics'),
          CheckboxListTile(
            value: weekends,
            title: const Text('Weekends'),
            activeColor: Colors.blue,
            onChanged: (newValue) async {
              if (newValue == null) return;
              await helper.saveWeekendStatus(newValue);
              setState(() {
                weekends = newValue;
              });
            },
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
            subtitle: Text(helper.startTime.format(context)),
            onTap: () => _selectTime(ScheduleDateType.start),
          ),
          ListTile(
            title: Text('End time', style: titleStyle),
            subtitle: Text(helper.endTime.format(context)),
            onTap: () => _selectTime(ScheduleDateType.end),
          ),
          const RouterTile(
            title: 'Holidays',
            icon: Icons.event,
            route: Routes.scheduleHolidaysPage,
          ),
        ],
      ),
    );
  }
}
