import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/util/days_util.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem(
    this.subject, {
    Key key,
    this.isFirst,
    this.isLast,
    @required this.selectedDay,
  }) : super(key: key);

  final Subject subject;
  final bool isFirst;
  final bool isLast;
  final DateTime selectedDay;

  static const Radius radius = Radius.circular(10);

  BorderRadius get leftBorderRadius {
    if (isFirst & isLast) {
      return const BorderRadius.horizontal(left: radius);
    } else if (isFirst) {
      return const BorderRadius.only(topLeft: radius);
    } else if (isLast) {
      return const BorderRadius.only(bottomLeft: radius);
    }
    return null;
  }

  BorderRadius get rightBorderRadius {
    if (isFirst & isLast) {
      return const BorderRadius.horizontal(right: radius);
    } else if (isFirst) {
      return const BorderRadius.only(topRight: radius);
    } else if (isLast) {
      return const BorderRadius.only(bottomRight: radius);
    }
    return null;
  }

  BorderRadius get borderRadius {
    if (isFirst & isLast) {
      return const BorderRadius.all(radius);
    } else if (isFirst) {
      return const BorderRadius.vertical(top: radius);
    } else if (isLast) {
      return const BorderRadius.vertical(bottom: radius);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final weekdayString = selectedDay.weekday.toString();
    final dayOfWeek = daysFromIntegerString[weekdayString];
    final startTime = subject.schedule[dayOfWeek][0].format(context);
    final endTime = subject.schedule[dayOfWeek][1].format(context);

    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: borderRadius,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            decoration: BoxDecoration(
              borderRadius: leftBorderRadius,
              gradient: LinearGradient(
                colors: <Color>[
                  const Color(0xFF005ab5),
                  const Color(0xFF5a00b5).withOpacity(0.65),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  startTime,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  endTime,
                  style: TextStyle(color: Colors.grey[300]),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 3,
            height: 50,
            color: subject.color,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: rightBorderRadius,
                ),
                child: Text(
                  subject.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: useWhiteForeground(Theme.of(context).accentColor)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
