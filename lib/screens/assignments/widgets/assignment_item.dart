import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:school_life/components/dialogs/dialogs.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/router/router.gr.dart';

class AssignmentItem extends StatelessWidget {
  const AssignmentItem(
    this.assignment,
    this.assignmentSubject,
  );

  final Assignment assignment;
  final Subject assignmentSubject;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.headline4.copyWith(color: Colors.black);
    final dueDate = assignment.dueDate;
    final date = '${dueDate.year}-${dueDate.month}-${dueDate.day}';
    return Card(
      color: assignmentSubject.color,
      elevation: 3.0,
      child: InkWell(
        onTap: () {
          ExtendedNavigator.rootNavigator.pushNamed(
            Routes.assignmentDetails,
            arguments: AssignmentDetailsPageArguments(
              assignment: assignment,
              assignmentSubject: assignmentSubject,
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
              const SizedBox(height: 8),
              Text(
                assignment.name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: textTheme.headline3.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${assignmentSubject.name}', style: textStyle),
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
