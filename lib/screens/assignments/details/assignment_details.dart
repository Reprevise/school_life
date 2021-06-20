import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';

import '../../../models/assignment.dart';
import '../../../models/subject.dart';
import '../../../util/color_utils.dart';

class AssignmentDetailsPage extends StatelessWidget {
  const AssignmentDetailsPage(
    this.assignment,
    this.assignmentSubject, {
    Key? key,
  }) : super(key: key);

  final Assignment assignment;
  final Subject assignmentSubject;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final darkAccent = ColorUtils.getDarkerAccent(assignmentSubject.color);
    final offsetColor = ColorUtils.isLightColor(assignmentSubject.color)
        ? Colors.black
        : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          assignment.name,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: offsetColor),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: offsetColor),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(
          Icons.check,
          color: Colors.green,
        ),
        label: const Text('Complete'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Assignment is due in ${assignment.dueDate.timeago(allowFromNow: true)}.',
              style: const TextStyle(color: Colors.red),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Assignment Details',
              style: textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: darkAccent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              assignment.details.trim().isEmpty
                  ? 'No assignment details'
                  : assignment.details,
              style: textTheme.bodyText2!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
