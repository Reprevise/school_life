import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  const DateHeader({Key? key}) : super(key: key);

  @override
  _DateHeaderState createState() => _DateHeaderState();
}

class _DateHeaderState extends State<DateHeader> {
  late TimeOfDay _time;
  late String _dayOfWeek;
  late String _month;
  late int _day;
  late String _formattedDayNumber;

  @override
  void initState() {
    super.initState();
    _setDates(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      if (now.minute != _time.minute) {
        _setDates(now);
      }
    });
  }

  void _setDates(DateTime date) {
    _time = TimeOfDay.fromDateTime(date);
    _dayOfWeek = _days[date.weekday]!;
    _month = _months[date.month]!;
    _day = date.day;
    _formattedDayNumber = _getFormattedDayNumber(_day);
    if (mounted) setState(() {});
  }

  String _getFormattedDayNumber(int day) {
    switch (day) {
      case 1:
        return '1st';
      case 2:
        return '2nd';
      case 3:
        return '3rd';
      case 31:
        return '31st';
      default:
        return '${day}th';
    }
  }

  static const _bold = TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final _defaultStyle = GoogleFonts.raleway(
      fontSize: 16,
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.white,
    );
    return RichText(
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
    );
  }
}
