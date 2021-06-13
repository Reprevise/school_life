import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../app/app.locator.dart';
import '../../../models/subject.dart';
import '../../../services/databases/hive_helper.dart';
import '../../../services/databases/subjects_repository.dart';
import '../../../util/date_utils.dart';
import '../../../util/day_utils.dart';
import 'schedule_item.dart';

class SchedulesList extends StatelessWidget {
  const SchedulesList({required this.selectedDay});

  final DateTime selectedDay;

  void sortSchedule(List<Subject> values, String selectedDayOfWeek) {
    final repo = locator<SubjectsRepository>();
    values.sort((subjectOne, subjectTwo) {
      final timeOne = repo
              .getTimeBlockFromDay(selectedDayOfWeek, subjectOne.schedule!)
              .startTime,
          timeTwo = repo
              .getTimeBlockFromDay(selectedDayOfWeek, subjectTwo.schedule!)
              .startTime;
      final oneDate = selectedDay.onlyDate
              .add(Duration(hours: timeOne.hour, minutes: timeOne.minute))
              .millisecondsSinceEpoch,
          twoDate = selectedDay.onlyDate
              .add(Duration(hours: timeTwo.hour, minutes: timeTwo.minute))
              .millisecondsSinceEpoch;
      return oneDate.compareTo(twoDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Subject>(HiveBoxes.subjectsBox);
    final fontSize = MediaQuery.of(context).size.width / 20;
    final weekdayString = selectedDay.weekday.toString();
    final selectedDayOfWeek = daysFromIntegerString[weekdayString]!;

    return ValueListenableBuilder<Box<Subject>>(
      valueListenable: box.listenable(),
      builder: (context, box, child) {
        final values = locator<SubjectsRepository>()
            .getSubjectsWithSameDaySchedule(selectedDayOfWeek);
        sortSchedule(values, selectedDayOfWeek);

        return Visibility(
          visible: values.isNotEmpty,
          replacement: Column(
            children: <Widget>[
              Icon(
                Icons.schedule,
                size: 128.0,
              ),
              Text(
                "You don't have any classes today!",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(15),
            itemCount: values.length,
            itemBuilder: (context, index) {
              final subject = values[index];
              final isFirst = subject == values.first;
              final isLast = subject == values.last;
              return ScheduleItem(
                subject,
                isFirst: isFirst,
                isLast: isLast,
                selectedDay: selectedDay,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.white,
                height: 1,
              );
            },
          ),
        );
      },
    );
  }
}
