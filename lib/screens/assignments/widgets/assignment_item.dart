import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:school_life/components/dialog/dialogs.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/assignments/details/assignment_details.dart';

class AssignmentItem extends StatelessWidget {
  final Assignment assignment;
  final Subject assignmentSubject;

  const AssignmentItem(this.assignment,
      this.assignmentSubject,);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.display1.copyWith(color: Colors.black);
    final DateTime dueDate = assignment.dueDate;
    final String date = "${dueDate.year}-${dueDate.month}-${dueDate.day}";
    return Card(
      color: assignment.color,
      elevation: 3.0,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AssignmentDetailsPage(assignment),
            ),
          );
        },
        onLongPress: () => showDeleteAssignmentDialog(
          context,
          assignment,
        ),
        child: Container(
          height: 100,
          width: 375,
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 8),
              TextOneLine(
                assignment.name,
                textAlign: TextAlign.start,
                style: textTheme.display2.copyWith(color: Colors.black),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${assignmentSubject.name}", style: textStyle),
                    Text(date, style: textStyle),
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
