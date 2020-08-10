import 'package:hive/hive.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/services/databases/db_helper.dart';

class AssignmentsRepository {
  AssignmentsRepository() {
    _assignmentsDB = Hive.box(Databases.assignmentsBox);
  }

  Box<Assignment> _assignmentsDB;

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

  List<Assignment> get assignments {
    final data = _assignmentsDB.values.toList();
    return data ?? <Assignment>[];
  }

  Assignment getAssignment(int id) {
    return _assignmentsDB.getAt(id);
  }

  List<Assignment> getAssignmentsFromSubjectID(int subjectID) {
    return assignments
        .where((assignment) => assignment.subjectID == subjectID)
        .toList();
  }

  Future<int> addAssignment(Assignment assignment) {
    return _assignmentsDB.add(assignment);
  }
}
