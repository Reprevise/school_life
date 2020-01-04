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
    final fontSize = MediaQuery.of(context).size.width / 20;
    Box<Assignment> box = Hive.box<Assignment>(DatabaseHelper.ASSIGNMENTS_BOX);

    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, Box<Assignment> box, child) {
        if (box.isNotEmpty) {
          return Column(
            children: box.values.map(
              (assignment) {
                Subject currentSubject = getIt<SubjectsRepository>()
                    .getSubject(assignment.subjectID);
                return AssignmentItem(
                  assignment,
                  currentSubject,
                );
              },
            ).toList(),
          );
        } else {
          return Column(
            children: <Widget>[
              Icon(
                Icons.assignment,
                color: Colors.grey[400],
                size: 128.0,
              ),
              Text(
                "You don't have any assignments due!",
                style: Theme.of(context)
                    .textTheme
                    .display2
                    .copyWith(fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Woo-hoo!",
                style: Theme.of(context)
                    .textTheme
                    .display2
                    .copyWith(fontSize: fontSize / 1.2),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }
      },
    );
  }
}
