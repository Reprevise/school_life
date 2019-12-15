import 'package:flutter/material.dart';
import 'package:school_life/widgets/index.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
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
    return Scaffold(
      appBar: CustomAppBar(
        "Calendar",
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              setState(() {
                _calendarController.setFocusedDay(DateTime.now());
              });
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: _buildCalendar(),
    );
  }
}
