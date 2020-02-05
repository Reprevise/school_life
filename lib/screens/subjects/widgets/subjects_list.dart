import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/subjects/widgets/subject_item.dart';
import 'package:school_life/services/databases/db_helper.dart';

class SubjectsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).size.width / 20;
    final Box<Subject> box = Hive.box<Subject>(Databases.SUBJECTS_BOX);

    return ValueListenableBuilder<Box<Subject>>(
      valueListenable: box.listenable(),
      builder: (BuildContext context, Box<Subject> box, Widget child) {
        return Visibility(
          visible: box.isNotEmpty,
          child: Column(
            children: box.values
                .map((Subject subject) => SubjectItem(subject))
                .toList(),
          ),
          replacement: Column(
            children: <Widget>[
              Icon(
                Icons.school,
                color: Colors.grey[400],
                size: 128.0,
              ),
              Text(
                'You don\'t have any subjects!',
                style: Theme.of(context)
                    .textTheme
                    .display2
                    .copyWith(fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Click the button below to add some!',
                style: Theme.of(context)
                    .textTheme
                    .display2
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
