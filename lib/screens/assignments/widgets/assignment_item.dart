import 'package:animations/animations.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_life/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/assignment.dart';
import '../../../models/subject.dart';
import '../../../services/stacked/dialogs.dart';
import '../../../util/color_utils.dart';
import '../details/assignment_details.dart';

class AssignmentItem extends StatelessWidget {
  const AssignmentItem(
    this.assignment,
    this.assignmentSubject, {
    Key? key,
  }) : super(key: key);

  final Assignment assignment;
  final Subject assignmentSubject;

  @override
  Widget build(BuildContext context) {
    final ds = locator<DialogService>();
    final ns = locator<NavigationService>();
    final isLightBckg = ColorUtils.isLightColor(assignmentSubject.color);

    return OpenContainer(
      openBuilder: (context, _) {
        return AssignmentDetailsPage(
          assignment,
          assignmentSubject,
        );
      },
      closedBuilder: (context, openContainer) {
        return Slidable(
          startActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => ds.showCustomDialog(
                  variant: DialogType.deleteAssignment,
                  customData: assignment,
                ),
                icon: Icons.delete_outline,
                label: 'Delete',
                backgroundColor: Colors.red,
              ),
              SlidableAction(
                onPressed: (_) => ns.navigateTo(
                  Routes.addAssignmentPage,
                  arguments: AddAssignmentPageArguments(
                    assignmentToEdit: assignment,
                  ),
                ),
                icon: Icons.edit_outlined,
                label: 'Edit',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {},
                icon: Icons.check_circle_outline_outlined,
                label: 'Complete',
                backgroundColor: Colors.green,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: openContainer,
            style: ElevatedButton.styleFrom(
              elevation: 3.0,
              primary: assignmentSubject.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 8),
                Text(
                  assignment.name.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: GoogleFonts.raleway(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: isLightBckg ? Colors.black : Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: isLightBckg ? Colors.black : Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Due ${assignment.dueDate.timeago(allowFromNow: true)}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: isLightBckg ? Colors.black : Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
