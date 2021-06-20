import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/date_utils.dart';
import '../../../util/day_utils.dart';

class ScheduleHeader extends StatelessWidget {
  final void Function(DateTime) onDaySelected;
  final DateTime focusedDay;

  const ScheduleHeader({
    Key? key,
    required this.onDaySelected,
    required this.focusedDay,
  }) : super(key: key);

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
          final isFocused = focusedDay.onlyDate == d;
          final w = '${d.weekday}';
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextButton(
              onPressed: () => onDaySelected(d),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fixedSize: const Size(75, 100),
                backgroundColor: isFocused ? Colors.grey.shade800 : Colors.grey,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _getFormattedDayNumber(d.day),
                    style: const TextStyle(color: Colors.white),
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
