import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_life/util/day_utils.dart';

import '../../../util/date_utils.dart';

class ScheduleHeader extends StatelessWidget {
  final void Function(DateTime) onDaySelected;
  final DateTime focusedDay;

  const ScheduleHeader({
    required this.onDaySelected,
    required this.focusedDay,
  });

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

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().onlyDate;
    final twoWeeks = now.addDays(8).eachDay(now).toList();

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        shrinkWrap: true,
        itemExtent: 100,
        itemCount: twoWeeks.length,
        itemBuilder: (c, i) {
          final d = twoWeeks[i];
          final w = '${d.weekday}';
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fixedSize: Size(75, 100),
                backgroundColor: Colors.grey.shade800,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _getFormattedDayNumber(d.day),
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '${daysFromIntegerString[w]!.substring(0, 3)}.',
                    style: GoogleFonts.raleway(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
