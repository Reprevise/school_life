import 'package:flutter/material.dart';
import 'package:school_life/components/dialog/dialogs.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';

class AssignmentItem extends StatelessWidget {
  final Assignment assignment;
  final void Function(Assignment) deleteAssignment;
  final Subject assignmentSubject;

  const AssignmentItem(
    this.assignment,
    this.deleteAssignment,
    this.assignmentSubject,
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.display1.copyWith(color: Colors.black);
    final DateTime dueDate = assignment.dueDate;
    final String date = "${dueDate.year}-${dueDate.month}-${dueDate.day}";
    return Card(
      color: Color(assignmentSubject.colorValue),
      elevation: 3.0,
      child: InkWell(
        onTap: () {},
        onLongPress: () => showDeleteAssignmentDialog(
          context,
          assignment,
          deleteAssignment,
        ),
        child: Container(
          height: 100,
          width: 375,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      assignment.name,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: textTheme.display3.copyWith(color: Colors.black),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8),
                child: Row(
                  children: <Widget>[
                    Text("${assignmentSubject.name}", style: textStyle),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: <Widget>[
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
