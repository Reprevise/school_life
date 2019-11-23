import 'package:flutter/material.dart';
import 'package:school_life/widgets/scaffold/custom_scaffold.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final _calendarFormats = {
    CalendarFormat.week: 'week',
  };
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  TableCalendar _buildCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      availableCalendarFormats: _calendarFormats,
      initialCalendarFormat: CalendarFormat.week,
      availableGestures: AvailableGestures.horizontalSwipe,
      // builders: CalendarBuilders(
      //   dayBuilder: _buildDays,
      // ),
      headerVisible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Schedule",
      appBarActions: <Widget>[
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {
            setState(() {
              _calendarController.setFocusedDay(DateTime.now());
            });
          },
        ),
      ],
      scaffoldBody: _buildCalendar(),
    );
  }
}
