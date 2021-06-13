import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/services/databases/hive_helper.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/databases/subjects_repository.dart';
import '../../../services/stacked/dialogs.dart';
import 'widgets/assignment_item.dart';

class AssignmentsPage extends StatelessWidget {
  final subjectsRepo = locator<SubjectsRepository>();
  final ns = locator<NavigationService>();
  final ds = locator<DialogService>();
  final box = Hive.box<Assignment>(HiveBoxes.assignmentsBox);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleAddAssignmentPress,
        label: Text('Create'),
        icon: const Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Assignments',
          style: Theme.of(context).textTheme.headline6,
        ),
        elevation: 0,
      ),
      body: ValueListenableBuilder<Box<Assignment>>(
        valueListenable: box.listenable(),
        builder: (context, box, _) {
          return Visibility(
            visible: box.isNotEmpty,
            replacement: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.assignment,
                  size: 128.0,
                ),
                Text(
                  "You don't have any assignments due!",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Woo-hoo!',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            child: ListView.builder(
              itemCount: box.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (c, i) {
                final assignment = box.values.toList()[i];
                final subject = subjectsRepo.getSubject(assignment.subjectID);
                return AssignmentItem(assignment, subject);
              },
            ),
          );
        },
      ),
    );
  }

  void _handleAddAssignmentPress() {
    if (!subjectsRepo.subjects.isNotEmpty) {
      ds.showCustomDialog(variant: DialogType.noSubjects);
      return;
    }
    ns.navigateTo(Routes.addAssignmentPage);
  }
}
