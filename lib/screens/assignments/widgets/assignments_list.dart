import 'package:flutter/material.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/assignments/widgets/assignment_item.dart';

class AssignmentsList extends StatelessWidget {
  final Future<List<Assignment>> future;
  final Map<int, Subject> assignmentSubjectsByID;
  final Function(Assignment) deleteAssignment;

  AssignmentsList(
    this.future,
    this.assignmentSubjectsByID,
    this.deleteAssignment,
  );

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 20;

    return FutureBuilder<List<Assignment>>(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return Column(
                children: snapshot.data.map(
                  (assignment) {
                    Subject currentSubject =
                        assignmentSubjectsByID[assignment.subjectID];
                    return AssignmentItem(
                      assignment,
                      deleteAssignment,
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
            break;
          default:
            return Center(child: Text("Something went wrong :("));
        }
      },
    );
  }
}
