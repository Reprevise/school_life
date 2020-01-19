import 'package:flutter/material.dart';
import 'package:school_life/util/date_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleHeader extends StatelessWidget {
  const ScheduleHeader({
    Key key,
    @required this.onDaySelected,
    @required this.controller,
  }) : super(key: key);

  final CalendarController controller;
  final Function(DateTime, List<dynamic>) onDaySelected;

  @override
  Widget build(BuildContext context) {
    const BorderRadius borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    );

    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 1),
              blurRadius: 5,
            ),
          ],
        ),
        child: TableCalendar(
          calendarController: controller,
          availableCalendarFormats: const <CalendarFormat, String>{
            CalendarFormat.week: 'Week',
          },
          availableGestures: AvailableGestures.horizontalSwipe,
          initialCalendarFormat: CalendarFormat.week,
          startDay: DateTime.now().todaysDate,
          calendarStyle: const CalendarStyle(
            todayColor: Color(0xFF5459E0),
            contentPadding: EdgeInsets.zero,
          ),
          startingDayOfWeek: StartingDayOfWeek.monday,
          headerVisible: false,
          onDaySelected: onDaySelected,
        ),
      ),
    );
  }
}
