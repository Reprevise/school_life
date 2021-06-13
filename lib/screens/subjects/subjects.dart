import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_life/components/date_header/date_header.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/hive_helper.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import 'widgets/subject_item.dart';

class SubjectsPage extends StatelessWidget {
  final _navService = locator<NavigationService>();
  final box = Hive.box<Subject>(HiveBoxes.subjectsBox);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navService.navigateTo(Routes.addSubjectPage),
        label: Text('Create'),
        icon: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'Subjects',
          style: Theme.of(context).textTheme.headline6,
        ),
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ValueListenableBuilder<Box<Subject>>(
        valueListenable: box.listenable(),
        builder: (context, box, _) {
          return Visibility(
            visible: box.isNotEmpty,
            replacement: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.school,
                  color: Colors.grey[400],
                  size: 128.0,
                ),
                Text(
                  "You don't have any subjects!",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Click the button below to add some!',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            child: ListView.builder(
              itemExtent: 75,
              shrinkWrap: true,
              itemCount: box.length,
              itemBuilder: (_, i) {
                return SubjectItem(box.getAt(i)!);
              },
            ),
          );
        },
      ),
    );
  }
}
