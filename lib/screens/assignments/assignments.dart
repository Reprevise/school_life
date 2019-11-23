import 'package:flutter/material.dart';
import 'package:school_life/screens/assignments/widgets/all_assignments/all_assignments.dart';
import 'package:school_life/screens/forms/add_assignnment/add_assignment.dart';
import 'package:school_life/screens/settings/children/assignments-set.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/widgets/scaffold/custom_scaffold.dart';

class AssignmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Assignments",
      appBarActions: <Widget>[
        PopupMenuButton(
          onSelected: (_) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AssignmentsSettingsPage(),
            ),
          ),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text("Settings"),
                value: "Settings",
              ),
            ];
          },
        ),
      ],
      fabLocation: FloatingActionButtonLocation.centerFloat,
      fab: FloatingActionButton.extended(
        onPressed: () {
          RepositoryServiceSubject.getAllSubjects().then((subjects) {
            if (subjects.isEmpty) {
              userHasNoSubjects(context);
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAssignmentPage(),
              ),
            );
          });
        },
        label: Text(
          "Add Assignment",
          style: TextStyle(fontFamily: "OpenSans"),
        ),
        icon: Icon(Icons.add),
      ),
      scaffoldBody: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.only(top: 20, bottom: 70),
        child: AllAssignments(),
      ),
    );
  }

  void userHasNoSubjects(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("No subjects found"),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
