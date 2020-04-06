import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/schedule/widgets/schedule_item.dart';
import 'package:school_life/main.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/util/date_utils.dart';
import 'package:school_life/util/day_utils.dart';

class SchedulesList extends StatelessWidget {
  const SchedulesList({@required this.selectedDay});

  final DateTime selectedDay;

  void sortSchedule(List<Subject> values, String selectedDayOfWeek) {
    values.sort((subjectOne, subjectTwo) {
      final oneSchedule = subjectOne.schedule,
          twoSchedule = subjectTwo.schedule;
      final one = oneSchedule[selectedDayOfWeek][0],
          two = twoSchedule[selectedDayOfWeek][0];
      final oneDate = selectedDay.onlyDate
              .add(Duration(hours: one.hour, minutes: one.minute)),
          twoDate = selectedDay.onlyDate
              .add(Duration(hours: two.hour, minutes: two.minute));
      final oneDateMilli = oneDate.millisecondsSinceEpoch,
          twoDateMilli = twoDate.millisecondsSinceEpoch;
      return oneDateMilli.compareTo(twoDateMilli);
    });
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Subject>(Databases.subjectsBox);
    final fontSize = MediaQuery.of(context).size.width / 20;
    final weekdayString = selectedDay.weekday.toString();
    final selectedDayOfWeek = daysFromIntegerString[weekdayString];

    return ValueListenableBuilder<Box<Subject>>(
      valueListenable: box.listenable(),
      builder: (context, box, child) {
        final values = sl<SubjectsRepository>()
            .getSubjectsWithSameDaySchedule(selectedDayOfWeek);
        sortSchedule(values, selectedDayOfWeek);

        return Visibility(
          visible: values.isNotEmpty,
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
          replacement: Center(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.schedule,
                  color: Colors.grey[400],
                  size: 128.0,
                ),
                Text(
                  'You don\'t have any classes today!',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontSize: fontSize),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
