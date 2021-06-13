import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/stacked/dialogs.dart';
import '../../../models/assignment.dart';
import '../../../models/subject.dart';

class AssignmentItem extends StatelessWidget {
  const AssignmentItem(
    this.assignment,
    this.assignmentSubject,
  );

  final Assignment assignment;
  final Subject assignmentSubject;

  @override
  Widget build(BuildContext context) {
    final ns = locator<NavigationService>();
    final ds = locator<DialogService>();

    return Container(
      height: 100,
      padding: const EdgeInsets.only(left: 8),
      child: ElevatedButton(
        onPressed: () => ns.navigateTo(
          Routes.assignmentDetailsPage,
          arguments: AssignmentDetailsPageArguments(
            assignment: assignment,
            assignmentSubject: assignmentSubject,
          ),
        ),
        onLongPress: () => ds.showCustomDialog(
          variant: DialogType.deleteAssignment,
          customData: assignment,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 3.0,
          primary: assignmentSubject.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 8),
            Text(
              assignment.name.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: GoogleFonts.raleway(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${assignmentSubject.name}'),
                  Text(DateFormat.yMd().format(assignment.dueDate)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
