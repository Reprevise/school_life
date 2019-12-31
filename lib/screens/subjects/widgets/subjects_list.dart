import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/subjects/widgets/subject_item.dart';
import 'package:school_life/services/databases/db_helper.dart';

class SubjectsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 20;

    return WatchBoxBuilder(
      box: Hive.box<Subject>(DatabaseHelper.SUBJECTS_BOX),
      builder: (context, box) {
        if (box.isEmpty) {
          return Column(
            children: <Widget>[
              Icon(
                Icons.school,
                color: Colors.grey[400],
                size: 128.0,
              ),
              Text(
                "You don't have any subjects!",
                style: Theme.of(context)
                    .textTheme
                    .display2
                    .copyWith(fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Click the button below to add some!",
                style: Theme.of(context)
                    .textTheme
                    .display2
                    .copyWith(fontSize: fontSize / 1.2),
                textAlign: TextAlign.center,
              ),
            ],
          );
        } else {
          return Column(
            children: box.values
                .map((subject) => SubjectItem(subject))
                .toList(),
          );
        }
      },
    );
  }
}
