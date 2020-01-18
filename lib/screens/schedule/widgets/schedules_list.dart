import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/schedule/widgets/schedule_item.dart';
import 'package:school_life/services/databases/db_helper.dart';

class SchedulesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Box<Subject> box = Hive.box<Subject>(DatabaseHelper.SUBJECTS_BOX);

    return ValueListenableBuilder<Box<Subject>>(
      valueListenable: box.listenable(keys: <String>['schedule']),
      builder: (BuildContext context, Box<Subject> box, Widget child) {
        final List<Subject> values = box.values.toList();
        return Visibility(
          visible: box.isNotEmpty,
          child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(15),
            itemCount: values.length,
            itemBuilder: (BuildContext context, int index) {
              final Subject subject = values[index];
              final bool isFirst = subject == values.first;
              final bool isLast = subject == values.last;
              return ScheduleItem(subject, isFirst: isFirst, isLast: isLast);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        );
      },
    );
  }
}
