import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/schedule/widgets/schedule_item.dart';
import 'package:school_life/services/databases/db_helper.dart';

class SchedulesList extends StatelessWidget {
  const SchedulesList({Key key, @required this.selectedDay}) : super(key: key);

  final DateTime selectedDay;

  @override
  Widget build(BuildContext context) {
    final Box<Subject> box = Hive.box<Subject>(DatabaseHelper.SUBJECTS_BOX);
    final double fontSize = MediaQuery.of(context).size.width / 20;

    return ValueListenableBuilder<Box<Subject>>(
      valueListenable: box.listenable(keys: <String>['schedule']),
      builder: (BuildContext context, Box<Subject> box, Widget child) {
        final List<Subject> values = box.values
            .where((Subject subject) => subject.schedule != null)
            .toList();
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
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
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
                  'You don\'t have any schedules!',
                  style: Theme.of(context)
                      .textTheme
                      .display2
                      .copyWith(fontSize: fontSize),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Add some below.',
                  style: Theme.of(context)
                      .textTheme
                      .display2
                      .copyWith(fontSize: fontSize / 1.2),
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
