import 'package:flutter/material.dart';

import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    Widget buildHeaderChild(String dayOfTheWeek) {
      return Container(
        color: Theme.of(context).primaryColor,
        width: 100,
        height: 50,
        child: Center(
            child: Text(dayOfTheWeek + ".",
                style: Theme.of(context).textTheme.display1)),
      );
    }

    TableRow tableHeader = TableRow(children: [
      // buildHeaderChild("Sun"),
      buildHeaderChild("Mon"),
      buildHeaderChild("Tue"),
      buildHeaderChild("Wed"),
      buildHeaderChild("Thu"),
      buildHeaderChild("Fri"),
      // buildHeaderChild("Sat"),
    ]);

    return Scaffold(
      appBar: CustomAppBar(title: "Schedule"),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Table(
          border:
              TableBorder.all(width: 3.0, color: Theme.of(context).accentColor),
          children: [
            tableHeader,
          ],
        ),
      ),
    );
  }
}

/* class _SchedulePageState extends State<SchedulePage> {
  CalendarController _calendarController;
  CalendarFormat _selectedCalFormat;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _selectedCalFormat = CalendarFormat.week;
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new CustomAppBar(title: "Schedule", actions: <Widget>[
        _buildCalFormatDropdown(),
        _buildTodayIconButton()
      ]),
      drawer: CustomDrawer(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendar(),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarStyle: CalendarStyle(),
      headerStyle: HeaderStyle(
        leftChevronIcon: Icon(Icons.chevron_left,
            color: Theme.of(context).primaryIconTheme.color),
        rightChevronIcon: Icon(Icons.chevron_right,
            color: Theme.of(context).primaryIconTheme.color),
        formatButtonVisible: false,
      ),
      calendarController: _calendarController,
      initialCalendarFormat: CalendarFormat.week,
      availableGestures: AvailableGestures.horizontalSwipe,
      availableCalendarFormats: {
        CalendarFormat.week: 'Week',
        CalendarFormat.month: 'Month'
      },
    );
  }

  Widget _buildTodayIconButton() {
    return IconButton(
      icon: Icon(Icons.calendar_today),
      onPressed: () async {
        DateTime _currentTime = await NTP.now();
        setState(() {
          _calendarController.setSelectedDay(_currentTime);
          _calendarController.setFocusedDay(_currentTime);
        });
      },
    );
  }

  Widget _buildCalFormatDropdown() {
    return DropdownButton(
      value: _selectedCalFormat == CalendarFormat.month ? "Month" : "Week",
      elevation: 2,
      items: [
        DropdownMenuItem(
          child: Text("Week"),
          value: "Week",
        ),
        DropdownMenuItem(
          child: Text("Month"),
          value: "Month",
        ),
      ],
      onChanged: (value) {
        setState(() {
          if (value == "Month") {
            _selectedCalFormat = CalendarFormat.month;
            _calendarController.setCalendarFormat(CalendarFormat.month);
          } else {
            _selectedCalFormat = CalendarFormat.week;
            _calendarController.setCalendarFormat(CalendarFormat.week);
          }
        });
      },
    );
  }
} */
