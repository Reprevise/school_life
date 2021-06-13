import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:school_life/app/app.locator.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

import '../../models/assignment.dart';
import 'hive_helper.dart';

class AssignmentsRepository {
  late final Box<Assignment> _assignmentsDB;
  late final SubjectsRepository _subjectsRepo;

  AssignmentsRepository() {
    _assignmentsDB = Hive.box(HiveBoxes.assignmentsBox);
    _subjectsRepo = locator<SubjectsRepository>();
  }

  int get nextID {
    if (assignments.isEmpty) {
      return 0;
    }
    final takenIDs = assignments.map((assignment) => assignment.id).toList();

    var id = 0;
    do {
      id++;
    } while (takenIDs.contains(id));
    return id;
  }

  List<Assignment> get assignments => _assignmentsDB.values.toList();

  Assignment getAssignment(int id) => _assignmentsDB.getAt(id)!;

  List<Assignment> getAssignmentsFromSubjectID(int subjectID) {
    return assignments
        .where((assignment) => assignment.subjectID == subjectID)
        .toList();
  }

  Map<Subject, List<Assignment>> getAssignmentsBySubject() {
    final assignmentsBySID = groupBy<Assignment, int>(
      assignments,
      (e) => e.subjectID,
    );
    return assignmentsBySID.map(
      (key, value) => MapEntry(_subjectsRepo.getSubject(key), value),
    );
  }

  Future<int> addAssignment(Assignment assignment) {
    return _assignmentsDB.add(assignment);
  }
}
