import 'package:flutter/material.dart';

import '../../../models/assignment.dart';
import '../../../models/subject.dart';
import '../../../util/color_utils.dart';

class AssignmentDetailsPage extends StatelessWidget {
  const AssignmentDetailsPage(this.assignment, this.assignmentSubject);

  final Assignment assignment;
  final Subject assignmentSubject;

  Color getTextColorFromBackground(Color backgroundColor) {
    return ThemeData.estimateBrightnessForColor(backgroundColor) ==
            Brightness.light
        ? Colors.black
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final lightAccent = ColorUtils.getLighterAccent(assignmentSubject.color);
    final darkAccent = ColorUtils.getDarkerAccent(assignmentSubject.color);

    return Scaffold(
      backgroundColor: lightAccent,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          color: assignmentSubject.color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(36),
            topRight: Radius.circular(36),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          children: <Widget>[
            Text(assignment.name),
            Visibility(
              visible: assignment.details.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Details',
                      style: textTheme.headline3,
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
                      assignment.details,
                      style: textTheme.bodyText2!.copyWith(
                        color: getTextColorFromBackground(darkAccent),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
