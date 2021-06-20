import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

import '../../app/app.locator.dart';
import '../../models/assignment.dart';
import '../../models/subject.dart';
import 'hive_helper.dart';
import 'subjects_repository.dart';

class AssignmentsRepository {
  late final Box<Assignment> _assignmentsDB;
  late final SubjectsRepository _subjectsRepo;

  AssignmentsRepository() {
    _assignmentsDB = Hive.box(HiveBoxes.assignmentsBox);
    _subjectsRepo = locator<SubjectsRepository>();
  }

  List<Assignment> get assignments => _assignmentsDB.values.toList();

  Assignment getAssignment(String id) => _assignmentsDB.get(id)!;

  List<Assignment> getAssignmentsFromSubjectID(String subjectID) {
    return assignments
        .where((assignment) => assignment.subjectID == subjectID)
        .toList();
  }

  Map<Subject, List<Assignment>> getAssignmentsBySubject() {
    final assignmentsBySID = groupBy<Assignment, String>(
      assignments,
      (e) => e.subjectID,
    );
    return assignmentsBySID.map(
      (key, value) => MapEntry(_subjectsRepo.getSubject(key)!, value),
    );
  }

  Future<void> addAssignment(Assignment assignment) {
    return _assignmentsDB.put(assignment.id, assignment);
  }
}
