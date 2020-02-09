import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/services/databases/db_helper.dart';

@singleton
@injectable
class AssignmentsRepository {
  AssignmentsRepository() {
    _assignmentsDB = Hive.box(Databases.ASSIGNMENTS_BOX);
  }

  Box<Assignment> _assignmentsDB;

  int get nextID {
    if (assignments.isEmpty) {
      return 0;
    }
    final List<int> takenIDs =
        assignments.map((Assignment assignment) => assignment.id).toList();

    int id = 0;
    do {
      id++;
    } while (takenIDs.contains(id));
    return id;
  }

  List<Assignment> get assignments {
    final List<Assignment> data = _assignmentsDB.values.toList();
    return data ?? <Assignment>[];
  }

  Assignment getAssignment(int id) {
    return _assignmentsDB.getAt(id);
  }

  List<Assignment> getAssignmentsFromSubjectID(int subjectID) {
    return assignments
        .where((Assignment assignment) => assignment.subjectID == subjectID)
        .toList();
  }

  Future<int> addAssignment(Assignment assignment) {
    return _assignmentsDB.add(assignment);
  }
}
