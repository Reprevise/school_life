import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_life/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/subject.dart';
import '../../../services/databases/assignments_repository.dart';
import '../../../services/stacked/dialogs.dart';

class SubjectItem extends StatelessWidget {
  const SubjectItem(this.subject, {Key? key}) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    final ds = locator<DialogService>();
    final ns = locator<NavigationService>();
    final assignmentsRepo = locator<AssignmentsRepository>();
    final showBuilding = subject.building.isNotEmpty;
    final aCount =
        assignmentsRepo.getAssignmentsFromSubjectID(subject.id).length;

    Color getColorFromAssignmentCount() {
      if (aCount <= 3) {
        return const Color(0xFF67D279);
      } else if (aCount <= 6) {
        return const Color(0xFFD2A867);
      } else {
        return const Color(0xFFD26767);
      }
    }

    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => ds.showCustomDialog(
              variant: DialogType.deleteSubject,
              customData: subject,
            ),
            icon: Icons.delete_outline,
            label: 'Delete',
            backgroundColor: Colors.red,
          ),
          SlidableAction(
            onPressed: (_) => ns.navigateTo(
              Routes.addSubjectPage,
              arguments: AddSubjectPageArguments(
                subjectToEdit: subject,
              ),
            ),
            icon: Icons.edit_outlined,
            label: 'Edit',
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        onLongPress: () => ds.showCustomDialog(
          variant: DialogType.deleteSubject,
          customData: subject,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 3,
                decoration: BoxDecoration(
                  color: subject.color,
                  borderRadius: BorderRadiusDirectional.circular(3),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      subject.name.toUpperCase(),
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.raleway(
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${showBuilding ? "B: ${subject.building} " : ''}'
                      'R: ${subject.room}'
                      ' | ${subject.teacher}',
                      style: GoogleFonts.montserrat(
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor: getColorFromAssignmentCount(),
                child: Text(
                  '${aCount > 9 ? '9+' : aCount}',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
