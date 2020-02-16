import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_life/models/holiday.dart';

class HolidayItem extends StatelessWidget {
  const HolidayItem({Key key, this.holiday}) : super(key: key);

  final Holiday holiday;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(30),
          right: Radius.circular(30),
        ),
        color: Theme.of(context).brightness == Brightness.light
            ? const Color(0xFFE7E7E7)
            : const Color(0xFF474747),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              holiday.name,
              style: Theme.of(context).textTheme.headline2,
            ),
            _HolidayIndicator(
              start: true,
              date: holiday.startDate,
            ),
            _HolidayIndicator(
              start: false,
              date: holiday.endDate,
            ),
          ],
        ),
      ),
    );
  }
}

class _HolidayIndicator extends StatelessWidget {
  const _HolidayIndicator({Key key, this.start, this.date}) : super(key: key);

  final bool start;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.35,
      child: Card(
        color: !start
            ? const Color(0xFF5EC999).withOpacity(0.25)
            : const Color(0xFFEF7198).withOpacity(0.25),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color:
                    !start ? const Color(0xFF5EC999) : const Color(0xFFEF7198),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              child: Text(DateFormat.yMMMd().format(date)),
            ),
          ],
        ),
      ),
    );
  }
}
