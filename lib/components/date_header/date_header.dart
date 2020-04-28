import 'dart:async';

import 'package:flutter/material.dart';

const _days = <int, String>{
  DateTime.monday: 'MON',
  DateTime.tuesday: 'TUE',
  DateTime.wednesday: 'WED',
  DateTime.thursday: 'THU',
  DateTime.friday: 'FRI',
  DateTime.saturday: 'SAT',
  DateTime.sunday: 'SUN',
};

const _months = <int, String>{
  DateTime.january: 'Jan',
  DateTime.february: 'Feb',
  DateTime.march: 'Mar',
  DateTime.april: 'Apr',
  DateTime.may: 'May',
  DateTime.june: 'Jun',
  DateTime.july: 'Jul',
  DateTime.august: 'Aug',
  DateTime.september: 'Sep',
  DateTime.october: 'Oct',
  DateTime.november: 'Nov',
  DateTime.december: 'Dec',
};

class DateHeader extends StatefulWidget {
  @override
  _DateHeaderState createState() => _DateHeaderState();
}

class _DateHeaderState extends State<DateHeader> {
  TimeOfDay _time;
  String _dayOfWeek;
  String _month;
  int _day;
  String _formattedDayNumber;

  @override
  void initState() {
    super.initState();
    _setDates(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (_) {
      final now = DateTime.now();
      if (now.minute != _time.minute) {
        _setDates(now);
      }
    });
  }

  void _setDates(DateTime date) {
    _time = TimeOfDay.fromDateTime(date);
    _dayOfWeek = _days[date.weekday];
    _month = _months[date.month];
    _day = date.day;
    _formattedDayNumber = _getFormattedDayNumber(_day);
    if (mounted) setState(() {});
  }

  String _getFormattedDayNumber(int day) {
    String formatted;
    switch (day) {
      case 1:
        formatted = "1st";
        break;
      case 2:
        formatted = "2nd";
        break;
      case 3:
        formatted = "3rd";
        break;
      case 31:
        formatted = "31st";
        break;
      default:
        formatted = "${day}th";
        break;
    }
    return formatted;
  }

  static const _bold = TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final _defaultStyle = TextStyle(
      fontSize: 16,
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.white,
      fontFamily: "Montserrat",
    );
    return Container(
      alignment: Alignment.centerRight,
      child: RichText(
        text: TextSpan(
          style: _defaultStyle,
          children: [
            TextSpan(
              style: _bold,
              text: _dayOfWeek,
            ),
            TextSpan(
              text: ', $_month. ',
            ),
            TextSpan(
              style: _bold,
              text: '$_formattedDayNumber ',
            ),
            TextSpan(
              text: '| ${_time.format(context)}',
            ),
          ],
        ),
      ),
    );
  }
}
