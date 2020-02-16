import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/subjects/widgets/subject_item.dart';
import 'package:school_life/services/databases/db_helper.dart';

class SubjectsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 22;
    final box = Hive.box<Subject>(Databases.subjectsBox);

    return ValueListenableBuilder<Box<Subject>>(
      valueListenable: box.listenable(),
      builder: (context, box, _) {
        return Visibility(
          visible: box.isNotEmpty,
          child: Column(
            children: box.values
                .map((subject) => SubjectItem(subject))
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
                    .headline3
                    .copyWith(fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Click the button below to add some!',
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
