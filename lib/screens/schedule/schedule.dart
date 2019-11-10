import 'package:flutter/material.dart';
import 'package:school_life/services/theme_service.dart';
import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';
import 'package:school_life/widgets/lifecycle_event_handler/lifecycle_events.dart';
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
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
        resumeCallBack: () => ThemeService().checkMatchingBrightness(context)));
    super.initState();
    _calendarController = CalendarController();
  }

  Widget _buildDays(BuildContext context, DateTime time, List<dynamic> list) {
    // return Text(time.toString());
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
    ThemeService().checkMatchingBrightness(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Schedule",
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
