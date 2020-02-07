import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/assignments/widgets/assignment_item.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class AssignmentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).size.width / 20;
    final Box<Assignment> box =
        Hive.box<Assignment>(Databases.ASSIGNMENTS_BOX);

    return ValueListenableBuilder<Box<Assignment>>(
      valueListenable: box.listenable(),
      builder: (BuildContext context, Box<Assignment> box, Widget child) {
        return Visibility(
          visible: box.isNotEmpty,
          child: Column(
            children: box.values.map(
              (Assignment assignment) {
                final Subject currentSubject = getIt<SubjectsRepository>()
                    .getSubject(assignment.subjectID);
                return AssignmentItem(
                  assignment,
                  currentSubject,
                );
              },
            ).toList(),
          ),
          replacement: Column(
            children: <Widget>[
              Icon(
                Icons.assignment,
                color: Colors.grey[400],
                size: 128.0,
              ),
              Text(
                'You don\'t have any assignments due!',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Woo-hoo!',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(fontSize: fontSize / 1.2),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
