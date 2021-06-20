import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/forms/form_spacer.dart';
import '../../../models/assignment.dart';
import '../../../models/subject.dart';
import 'assignment_item.dart';

class SubjectAssignments extends StatelessWidget {
  final Subject subject;
  final List<Assignment> assignments;

  const SubjectAssignments({
    Key? key,
    required this.subject,
    required this.assignments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: [
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            subject.name.toUpperCase(),
            textAlign: TextAlign.right,
            style: GoogleFonts.raleway(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const FormSpacer(),
        ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemCount: assignments.length,
          itemBuilder: (c, i) {
            return AssignmentItem(assignments[i], subject);
          },
          separatorBuilder: (_, __) => const FormSpacer(),
        ),
      ],
    );
  }
}
