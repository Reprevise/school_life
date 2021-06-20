import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/databases/subjects_repository.dart';
import '../../../services/stacked/dialogs.dart';
import '../../models/assignment.dart';
import '../../services/databases/assignments_repository.dart';
import '../../services/databases/hive_helper.dart';
import 'widgets/subject_assignments.dart';

class AssignmentsPage extends StatelessWidget {
  AssignmentsPage({Key? key}) : super(key: key);

  final subjectsRepo = locator<SubjectsRepository>();
  final assignmentsRepo = locator<AssignmentsRepository>();
  final ns = locator<NavigationService>();
  final ds = locator<DialogService>();
  final box = Hive.box<Assignment>(HiveBoxes.assignmentsBox);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (!subjectsRepo.subjects.isNotEmpty) {
            ds.showCustomDialog(variant: DialogType.noSubjects);
            return;
          }
          ns.navigateTo(Routes.addAssignmentPage);
        },
        label: const Text('Add Assignment'),
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
        builder: (context, _, __) {
          final abs = assignmentsRepo.getAssignmentsBySubject();

          return Visibility(
            visible: box.isNotEmpty,
            replacement: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.assignment,
                  size: 128.0,
                ),
                Text(
                  "You don't have any assignments due!",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Woo-hoo!',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: abs.keys.length,
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 72),
              itemBuilder: (_, i) {
                final subject = abs.keys.toList()[i];
                final assignments = List<Assignment>.from(abs[subject]!);
                assignments.sort((one, two) {
                  return one.dueDate.compareTo(two.dueDate);
                });

                return SubjectAssignments(
                  subject: subject,
                  assignments: assignments,
                );

                // final assignment = box.values.toList()[i];
                // final subject = subjectsRepo.getSubject(assignment.subjectID);
                // return AssignmentItem(box.getAt(i)!, subject);
              },
            ),
          );
        },
      ),
    );
  }
}
