import 'package:flutter/material.dart';
import 'package:school_life/util/models/assignment.dart';
import 'package:school_life/util/models/subject.dart';

class AllAssignments extends StatelessWidget {
  final Future<List<Assignment>> future;
  final Map<int, Subject> assignmentSubjectsByID;
  final Function deleteAssignment;

  AllAssignments(
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
          default:
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            if (snapshot.data.length > 0) {
              return Column(
                children: snapshot.data.map(
                  (assignment) {
                    if (assignmentSubjectsByID == null)
                      return Center(child: CircularProgressIndicator());
                    Subject currentSubject =
                        assignmentSubjectsByID[assignment.subjectID];
                    return AssignmentItem(
                      assignment: assignment,
                      assignmentSubject: currentSubject,
                      onLongPress: () =>
                          deleteAssignmentPopup(context, assignment),
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
        }
      },
    );
  }

  void deleteAssignmentPopup(BuildContext context, Assignment assignment) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final DialogTheme _dialogTheme = Theme.of(context).dialogTheme;
        final Color _contentStyleColor = _dialogTheme.contentTextStyle.color;
        return AlertDialog(
          title: RichText(
            text: TextSpan(
              style: TextStyle(
                color: _dialogTheme.titleTextStyle.color,
                fontSize: 16,
              ),
              children: <TextSpan>[
                TextSpan(text: "Do you want to delete "),
                TextSpan(
                  text: "${assignment.name}?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text(
                "Yes",
                style: TextStyle(color: _contentStyleColor),
              ),
              onPressed: () {
                deleteAssignment(assignment);
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              child: Text(
                "No",
                style: TextStyle(color: _contentStyleColor),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }
}

class AssignmentItem extends StatelessWidget {
  final Assignment assignment;
  final Function onLongPress;
  final Subject assignmentSubject;

  AssignmentItem({
    @required this.assignment,
    this.onLongPress,
    this.assignmentSubject,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.button.color;
    return Card(
      color: Color(assignmentSubject.colorValue),
      elevation: 3.0,
      child: InkWell(
        onTap: () {},
        onLongPress: onLongPress,
        child: Container(
          height: 100,
          width: 375,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      assignment.name,
                      style: TextStyle(color: textColor),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Subject: ${assignmentSubject.name}",
                      style: TextStyle(color: textColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Due: ${assignment.dueDate}",
                      style: TextStyle(color: textColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
