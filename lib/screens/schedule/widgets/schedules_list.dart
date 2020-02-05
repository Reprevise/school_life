import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/schedule/widgets/schedule_item.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/util/days_util.dart';
import 'package:school_life/util/date_utils.dart';

class SchedulesList extends StatelessWidget {
  const SchedulesList({Key key, @required this.selectedDay}) : super(key: key);

  final DateTime selectedDay;

  void sortSchedule(List<Subject> values, String selectedDayOfWeek) {
    values.sort((Subject subjectOne, Subject subjectTwo) {
      final Map<String, List<TimeOfDay>> oneSchedule = subjectOne.schedule,
          twoSchedule = subjectTwo.schedule;
      final TimeOfDay one = oneSchedule[selectedDayOfWeek][0],
          two = twoSchedule[selectedDayOfWeek][0];
      final DateTime oneDate = selectedDay.onlyDate
              .add(Duration(hours: one.hour, minutes: one.minute)),
          twoDate = selectedDay.onlyDate
              .add(Duration(hours: two.hour, minutes: two.minute));
      final int oneDateMilli = oneDate.millisecondsSinceEpoch,
          twoDateMilli = twoDate.millisecondsSinceEpoch;
      return oneDateMilli.compareTo(twoDateMilli);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Box<Subject> box = Hive.box<Subject>(Databases.SUBJECTS_BOX);
    final double fontSize = MediaQuery.of(context).size.width / 20;
    final String weekdayString = selectedDay.weekday.toString();
    final String selectedDayOfWeek = daysFromIntegerString[weekdayString];

    return ValueListenableBuilder<Box<Subject>>(
      valueListenable: box.listenable(),
      builder: (BuildContext context, Box<Subject> box, Widget child) {
        final List<Subject> values = getIt<SubjectsRepository>()
            .getSubjectsWithSameDaySchedule(selectedDayOfWeek);
        sortSchedule(values, selectedDayOfWeek);

        return Visibility(
          visible: values.isNotEmpty,
          child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(15),
            itemCount: values.length,
            itemBuilder: (BuildContext context, int index) {
              final Subject subject = values[index];
              final bool isFirst = subject == values.first;
              final bool isLast = subject == values.last;
              return ScheduleItem(
                subject,
                isFirst: isFirst,
                isLast: isLast,
                selectedDay: selectedDay,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
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
                      .display2
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
